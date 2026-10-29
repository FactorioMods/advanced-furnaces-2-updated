-- Opt-in reuse of existing furnace categories and conservative alternate-ore steel paths.
if not settings.startup["load-furn-extra-smelting"].value then return end


local function single_solid(entries)
    if not entries or #entries ~= 1 then return end
    local entry = entries[1]
    if entry.type == "fluid" or entry.probability and entry.probability ~= 1 or
        entry.amount_min or entry.amount_max or entry.ignored_by_productivity or
        entry.ignored_by_stats or entry.catalyst_amount then return end
    if entry.independent_probability and entry.independent_probability ~= 1 or
        entry.shared_probability and (entry.shared_probability.min ~= 0 or entry.shared_probability.max ~= 1) or
        entry.extra_count_fraction and entry.extra_count_fraction ~= 0 then return end
    for _, field in ipairs({"quality_change", "quality_min", "quality_max", "percent_spoiled",
        "always_fresh", "reset_freshness_on_craft", "spoil_weight"}) do
        if entry[field] ~= nil then return end
    end
    local amount = entry.amount or entry[2]
    if not amount or amount <= 0 or amount % 1 ~= 0 then return end
    return entry.name or entry[1], amount
end

local furnace_categories = {}
for _, furnace in pairs(data.raw.furnace or {}) do
    for _, category in ipairs(furnace.crafting_categories or {}) do
        if data.raw["recipe-category"][category] then furnace_categories[category] = true end
    end
end
-- Furnace prototypes also include recyclers. Inherit only categories backed by an
-- actual deterministic one-ore -> one-metal-plate recipe, never recycling/chemistry.
local categories = {}
for _, recipe in pairs(data.raw.recipe) do
    local ore = single_solid(recipe.ingredients)
    local plate = single_solid(recipe.results)
    if ore and string.find(ore, "ore", 1, true) and plate and
        string.match(plate, "%-plate$") and plate ~= "stone-plate" and
        not recipe.surface_conditions and not recipe.preserve_products_in_machine_output then
        local function accept(category)
            if furnace_categories[category] and not string.find(category, "recycl", 1, true) and
                not string.find(category, "chem", 1, true) and
                not string.find(category, "crafting", 1, true) then
                categories[category] = true
            end
        end
        accept(recipe.category or "crafting")
        for _, category in ipairs(recipe.categories or {}) do accept(category) end
    end
end
local ordered_categories = {}
for category in pairs(categories) do ordered_categories[#ordered_categories + 1] = category end
table.sort(ordered_categories)
for tier = 1, 5 do
    local furnace = data.raw["assembling-machine"]["furnace-pro-0" .. tier]
    local present = {}
    for _, category in ipairs(furnace.crafting_categories) do present[category] = true end
    for _, category in ipairs(ordered_categories) do
        if not present[category] then table.insert(furnace.crafting_categories, category) end
    end
end


local function unlock(recipe)
    if recipe.enabled ~= false then return false end
    local candidates = {}
    for name, technology in pairs(data.raw.technology) do
        for _, effect in ipairs(technology.effects or {}) do
            if effect.type == "unlock-recipe" and effect.recipe == recipe.name then
                candidates[#candidates + 1] = name
                break
            end
        end
    end
    table.sort(candidates)
    return candidates[1]
end

local steel = data.raw.recipe["steel-plate"]
if not steel then return end
local steel_input, iron_required = single_solid(steel.ingredients)
local steel_output, steel_amount = single_solid(steel.results)
if steel_input ~= "iron-plate" or steel_output ~= "steel-plate" then return end
if steel.surface_conditions or steel.preserve_products_in_machine_output then return end
local steel_unlock = unlock(steel)
if steel_unlock == nil then return end

local function gcd(a, b)
    while b ~= 0 do a, b = b, a % b end
    return a
end

local research_unit = table.deepcopy(data.raw.technology["furnace-pro-1"].unit)
research_unit.count_formula = nil
research_unit.count = 1

local recipe_names = {}
for name in pairs(data.raw.recipe) do recipe_names[#recipe_names + 1] = name end
table.sort(recipe_names)
for _, name in ipairs(recipe_names) do
    local source = data.raw.recipe[name]
    local ore, ore_amount = single_solid(source.ingredients)
    local plate, plate_amount = single_solid(source.results)
    local smelting = categories[source.category or "crafting"]
    for _, category in ipairs(source.categories or {}) do
        if categories[category] then smelting = true end
    end
    -- The ordinary iron-ore path already has steel-plate2. Do not compose recycling,
    -- fluid processing, multi-output or unrelated metal recipes into new steel paths.
    if smelting and not source.surface_conditions and not source.preserve_products_in_machine_output and
        plate == "iron-plate" and ore and ore ~= "iron-ore" and
        string.find(ore, "ore", 1, true) and not string.find(name, "-AdvFurn", 1, true) then
        local source_unlock = unlock(source)
        local divisor = gcd(plate_amount, iron_required)
        local source_batches, steel_batches = iron_required / divisor, plate_amount / divisor
        local input_amount, output_amount = ore_amount * source_batches, steel_amount * steel_batches
        local generated_name = "advanced-furnaces-direct-steel-" .. name
        if source_unlock ~= nil and input_amount <= 65535 and output_amount <= 65535 and
            not data.raw.recipe[generated_name] and not data.raw.technology[generated_name] then
            local prerequisites = {"furnace-pro-1"}
            if source_unlock then prerequisites[#prerequisites + 1] = source_unlock end
            if steel_unlock and steel_unlock ~= source_unlock then
                prerequisites[#prerequisites + 1] = steel_unlock
            end
            data:extend({
                {
                    type = "recipe", name = generated_name, categories = {"AdvFurn"}, enabled = false,
                    icons = {{icon = "__advanced-furnaces-2-updated__/graphics/icons/steel-plate.png", icon_size = 64}},
                    localised_name = {"advanced-furnaces.direct-steel", {"?", {"item-name." .. ore}, ore}},
                    subgroup = "pro-furnace", ingredients = {{type = "item", name = ore, amount = input_amount}},
                    results = {{type = "item", name = "steel-plate", amount = output_amount}},
                    energy_required = (source.energy_required or 0.5) * source_batches +
                        (steel.energy_required or 0.5) * steel_batches,
                    allow_productivity = source.allow_productivity == true and steel.allow_productivity == true
                },
                {
                    type = "technology", name = generated_name,
                    icon = "__advanced-furnaces-2-updated__/graphics/icons/steel-plate.png", icon_size = 64,
                    localised_name = {"recipe-name." .. generated_name},
                    prerequisites = prerequisites,
                    unit = table.deepcopy(research_unit),
                    effects = {{type = "unlock-recipe", recipe = generated_name}}
                }
            })
            -- Share a concrete localized label instead of relying on an untranslated generated key.
            data.raw.technology[generated_name].localised_name = table.deepcopy(data.raw.recipe[generated_name].localised_name)
        end
    end
end
