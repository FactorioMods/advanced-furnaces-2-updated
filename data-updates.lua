if settings.startup["steel-plate2"].value == true then
    if data.raw.technology["steel-processing"] then
        table.insert(data.raw.technology["steel-processing"].effects,
                     {type = "unlock-recipe", recipe = "steel-plate2"})
    end
end

for k = 1, 5 do
    local v = "0" .. k
    if mods["pycoalprocessing"] then
        table.insert(data.raw["assembling-machine"]["furnace-pro-" .. v]
                         .crafting_categories, "advanced-foundry")
        table.insert(data.raw["assembling-machine"]["furnace-pro-" .. v]
                         .crafting_categories, "hpf")
        data.raw["assembling-machine"]["furnace-pro-" .. v].ingredient_count = 20
    end
    if mods["IndustrialRevolution"] then
        table.insert(data.raw["assembling-machine"]["furnace-pro-" .. v]
                         .crafting_categories, "incinerating")
        table.insert(data.raw["assembling-machine"]["furnace-pro-" .. v]
                         .crafting_categories, "smelting-1")
        table.insert(data.raw["assembling-machine"]["furnace-pro-" .. v]
                         .crafting_categories, "smelting-2")
        table.insert(data.raw["assembling-machine"]["furnace-pro-" .. v]
                         .crafting_categories, "smelting-3")
        table.insert(data.raw["assembling-machine"]["furnace-pro-" .. v]
                         .crafting_categories, "smelting-4")
        table.insert(data.raw["assembling-machine"]["furnace-pro-" .. v]
                         .crafting_categories, "smelting-5")
        data.raw.recipe["furnace-pro-01"].ingredients =
            {
                {type="item", name="fast-inserter", amount=5}, {type = "item", name="steel-plate", amount=50},
                {type="item", name="electric-furnace", amount=24}, {type = "item", name="electronic-circuit", amount=20},
                {type="item", name="iron-gear-wheel", amount=20}
            }
        data.raw.recipe["furnace-pro-02"].ingredients =
            {
                {type="item", name="fast-inserter", amount=10}, {type="item", name="steel-plate", amount=50},
                {type="item", name="furnace-pro-01", amount=2}, {type="item", name="advanced-circuit", amount=5},
                {type="item", name="iron-gear-wheel", amount=20}
            }
        data.raw.recipe["furnace-pro-03"].ingredients =
            {
                {type="item", name="fast-inserter", amount=20}, {type="item", name="furnace-pro-02", amount=2},
                {type="item", name="advanced-circuit", amount=25}, {type="item", name="speed-module", amount=10},
                {type = "fluid", name = "lubricant", amount = 120}
            }
        data.raw.recipe["furnace-pro-04"].ingredients =
            {
                {type="item", name="bulk-inserter", amount=5}, {type="item", name="furnace-pro-03", amount=2},
                {type="item", name="advanced-circuit", amount=50}, {type="item", name="speed-module-2", amount=5},
                {type = "fluid", name = "lubricant", amount = 120}
            }
        data.raw.recipe["furnace-pro-05"].ingredients =
            {
                {type="item", name="bulk-inserter", amount=10}, {type="item", name="furnace-pro-04", amount=2},
                {type="item", name="advanced-circuit", amount=100}, {type="item", name="speed-module-3", amount=2},
                {type = "fluid", name = "lubricant", amount = 120}
            }
    end
end

if settings.startup["logist"].value == true then
    table.insert(data.raw.technology["furnace-pro-3"].effects,
                 {type = "unlock-recipe", recipe = "loader-pro-02"})
    table.insert(data.raw.technology["furnace-pro-3"].effects,
                 {type = "unlock-recipe", recipe = "transport-belt-pro"})
    table.insert(data.raw.technology["furnace-pro-3"].effects,
                 {type = "unlock-recipe", recipe = "underground-belt-pro"})
    table.insert(data.raw.technology["furnace-pro-3"].effects,
                 {type = "unlock-recipe", recipe = "splitter-pro"})
    table.insert(data.raw.technology["furnace-pro-4"].effects,
                 {type = "unlock-recipe", recipe = "loader-pro-03"})
    table.insert(data.raw.technology["furnace-pro-4"].effects,
                 {type = "unlock-recipe", recipe = "transport-belt-pro2"})
    table.insert(data.raw.technology["furnace-pro-4"].effects,
                 {type = "unlock-recipe", recipe = "underground-belt-pro2"})
    table.insert(data.raw.technology["furnace-pro-4"].effects,
                 {type = "unlock-recipe", recipe = "splitter-pro2"})
    if not mods["LoaderRedux"] and not mods["Krastorio"] then
        table.insert(data.raw.technology["logistics"].effects,
                     {type = "unlock-recipe", recipe = "loader-pro-001"})
        table.insert(data.raw.technology["logistics-2"].effects,
                     {type = "unlock-recipe", recipe = "loader-pro-002"})
        table.insert(data.raw.technology["logistics-3"].effects,
                     {type = "unlock-recipe", recipe = "loader-pro-01"})
    end
end
