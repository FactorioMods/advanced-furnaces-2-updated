-- Optional progression adapted from Load-Furn-2-2-1-SAFix 0.4.3.
local common = {"automation-science-pack", "logistic-science-pack", "chemical-science-pack"}
local presets = {
    vanilla = {
        packs = {"production-science-pack", "utility-science-pack", "space-science-pack"},
        counts = {4, 5, 6, 6, 6}
    },
    ["space-age"] = {
        packs = {"production-science-pack", "utility-science-pack", "space-science-pack",
            "metallurgic-science-pack", "electromagnetic-science-pack", "cryogenic-science-pack"},
        counts = {4, 6, 7, 8, 9}
    },
    ["space-exploration"] = {
        packs = {"space-science-pack", "production-science-pack", "utility-science-pack",
            "se-energy-science-pack-1", "se-material-science-pack-1"},
        counts = {4, 5, 6, 7, 8}
    },
    sesa = {
        packs = {"space-science-pack", "production-science-pack", "utility-science-pack",
            "metallurgic-science-pack", "electromagnetic-science-pack", "se-energy-science-pack-1",
            "cryogenic-science-pack", "se-material-science-pack-1"},
        counts = {4, 5, 7, 9, 11}
    }
}

local function preset(mode)
    local has_sa, has_se = mods["space-age"], mods["space-exploration"]
    if (mode == "space-age" and not has_sa) or
        (mode == "space-exploration" and not has_se) then
        mode = "vanilla"
    elseif mode == "sesa" and not (has_sa and has_se) then
        mode = has_sa and "space-age" or (has_se and "space-exploration" or "vanilla")
    end
    local definition = presets[mode]
    local packs = table.deepcopy(common)
    for _, pack in ipairs(definition.packs) do packs[#packs + 1] = pack end
    local ingredients = {}
    for tier = 1, 5 do
        ingredients[tier] = {}
        for index = 1, definition.counts[tier] do
            -- Incoming combined tier 5 lists cryogenic science before SE energy science.
            local source = index
            if mode == "sesa" and tier == 5 then
                if index == 9 then source = 10 elseif index == 10 then source = 9 end
            end
            ingredients[tier][index] = {packs[source], 1}
        end
    end
    return ingredients
end

-- A candidate science unlock must not depend on any of our furnace technologies.
local function depends_on_furnace(name, visited)
    if string.match(name, "^furnace%-pro%-[1-5]$") then return true end
    if visited[name] then return false end
    visited[name] = true
    local technology = data.raw.technology[name]
    for _, prerequisite in ipairs(technology and technology.prerequisites or {}) do
        if depends_on_furnace(prerequisite, visited) then return true end
    end
    return false
end

local function science_prerequisite(pack)
    if not ((data.raw.item and data.raw.item[pack]) or (data.raw.tool and data.raw.tool[pack])) then
        return nil, false
    end
    local candidates = {}
    for name, technology in pairs(data.raw.technology) do
        for _, effect in ipairs(technology.effects or {}) do
            if effect.type == "unlock-recipe" then
                local recipe = data.raw.recipe[effect.recipe]
                for _, result in ipairs(recipe and recipe.results or {}) do
                    if result.name == pack then
                        candidates[#candidates + 1] = name
                        break
                    end
                end
            end
        end
    end
    table.sort(candidates)
    -- Prefer the conventional pack technology, including Space Age's triggered research.
    if data.raw.technology[pack] then table.insert(candidates, 1, pack) end
    for _, candidate in ipairs(candidates) do
        if not depends_on_furnace(candidate, {}) then return candidate, true end
    end
    -- Initial science needs no unlock technology.
    local recipe = data.raw.recipe[pack]
    return nil, recipe ~= nil and recipe.enabled ~= false
end

return function()
    local mode = settings.startup["load-furn-balance-mode"].value
    if mode == "unbalanced" then return end
    local ingredients = preset(mode)
    local science = {}
    local prerequisites = {}
    for tier = 1, 5 do
        local technology = data.raw.technology["furnace-pro-" .. tier]
        prerequisites[tier] = table.deepcopy(technology.prerequisites or {})
        for _, ingredient in ipairs(ingredients[tier]) do
            local pack = ingredient[1]
            if not science[pack] then
                local prerequisite, valid = science_prerequisite(pack)
                science[pack] = {prerequisite = prerequisite, valid = valid}
            end
            local prerequisite, valid = science[pack].prerequisite, science[pack].valid
            if not valid then
                log("Advanced Furnaces: research preset unavailable (science pack " .. ingredient[1] ..
                    " has no safe unlock); preserving original research for every tier.")
                return
            end
            if prerequisite then
                local found = false
                for _, existing in ipairs(prerequisites[tier]) do
                    if existing == prerequisite then found = true end
                end
                if not found then table.insert(prerequisites[tier], prerequisite) end
            end
        end
    end
    -- Commit atomically: incomplete overhauls cannot leave a partially applied preset.
    for tier = 1, 5 do
        local technology = data.raw.technology["furnace-pro-" .. tier]
        technology.unit.ingredients = ingredients[tier]
        technology.prerequisites = prerequisites[tier]
    end
end
