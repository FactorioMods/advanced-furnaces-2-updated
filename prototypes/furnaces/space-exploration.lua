-- Category names alone do not promise support for every overhaul recipe/fluid layout.
if mods["space-exploration"] then
    for tier = 1, 5 do
        local furnace = data.raw["assembling-machine"]["furnace-pro-0" .. tier]
        for _, category in ipairs({"kiln", "casting"}) do
            if data.raw["recipe-category"][category] then
                local found = false
                for _, existing in ipairs(furnace.crafting_categories) do
                    if existing == category then found = true end
                end
                if not found then table.insert(furnace.crafting_categories, category) end
            end
        end
    end
end
