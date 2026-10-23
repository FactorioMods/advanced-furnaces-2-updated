function add_furnace_recipe(data)
    local name = data.name
    local order = data.order
    local categories = data.categories or {"crafting"}
    local ingredients = data.ingredients

    return {
        type = "recipe",
        name = name,
        ingredients = ingredients,
        enabled = false,
        order = order,
        subgroup = "pro-furnace",
        energy_required = 1,
        results = {{type="item", name=name, amount=1}},
        categories = categories,
    }
end

local recipes =
    {
        add_furnace_recipe{
            name = "furnace-pro-01",
            ingredients =
                {
                    {type="item", name="fast-inserter", amount=5},
                    {type="item", name="steel-plate", amount=50},
                    {type="item", name="electric-furnace", amount=24},
                    {type="item", name="electronic-circuit", amount=20},
                    {type="item", name="iron-gear-wheel", amount=20},

                },
            order = "c[furnace-pro]-d1[01]",
        },
        add_furnace_recipe{
            name = "furnace-pro-02",
            ingredients =
                {
                    {type="item", name="fast-inserter", amount=10},
                    {type="item", name="steel-plate", amount=50},
                    {type="item", name="furnace-pro-01", amount=2},
                    {type="item", name="advanced-circuit", amount=5},
                    {type="item", name="iron-gear-wheel", amount=20},

                },
            order = "c[furnace-pro]-d2[02]",
        },
        add_furnace_recipe{
            name = "furnace-pro-03",
            ingredients =
                {
                    {type="item", name="fast-inserter", amount=20},
                    {type="item", name="furnace-pro-02", amount=2},
                    {type="item", name="advanced-circuit", amount=25},
                    {type="item", name="speed-module", amount=10},
                    {type = "fluid", name = "lubricant", amount = 120}
                },
            order = "c[furnace-pro]-d3[03]",
            categories = {"crafting-with-fluid"},
        },
 add_furnace_recipe{
            name = "furnace-pro-04",
            ingredients =
                {
                    {type="item", name="bulk-inserter", amount=5},
                    {type="item", name="furnace-pro-03", amount=2},
                    {type="item", name="advanced-circuit", amount=50},
                    {type="item", name="speed-module-2", amount=5},
                    {type = "fluid", name = "lubricant", amount = 120}
                },
            order = "c[furnace-pro]-d4[04]",
            categories = {"crafting-with-fluid"},
        },
 add_furnace_recipe{
            name = "furnace-pro-05",
            ingredients =
                {
                    {type="item", name="bulk-inserter", amount=10},
                    {type="item", name="furnace-pro-04", amount=2},
                    {type="item", name="advanced-circuit", amount=100},
                    {type="item", name="speed-module-3", amount=2},
                    {type = "fluid", name = "lubricant", amount = 120}
                },
            order = "c[furnace-pro]-d5[05]",
            categories = {"crafting-with-fluid"},
        },
    }
data:extend(recipes)


if settings.startup["steel-plate2"].value == true then
    if data.raw.technology["steel-processing"] then
        enabl_steel_plate2 = false
    else
        enabl_steel_plate2 = true
    end
local steel = {
type = "recipe",
name = "steel-plate2",
categories = {"AdvFurn"},
icon = "__advanced-furnaces-2-updated__/graphics/icons/steel-plate.png",
icon_size = 64,

enabled = enabl_steel_plate2,
energy_required = 16,
ingredients = {{type="item", name="iron-ore", amount=5}},
results = {{type="item", name="steel-plate", amount=1}},

localised_name = {"recipe-name.steel-plate"}
}

data:extend({steel})
end
local coal_amount = 8
if settings.startup["cool"].value == true then
    coal_amount = settings.startup["recipe-wood-to-coal"].value
data:extend({
  {
    type = "recipe",
    name = "cool",
    categories = {"smelting"},
    icon = "__advanced-furnaces-2-updated__/graphics/icons/coal.png",
    icon_size = 64,
    enabled = true,
    energy_required = 10,
    ingredients = {{type="item", name="wood", amount=1}},
    results = {{type="item", name="coal", amount=coal_amount}},
    localised_name = {"item-name.coal"}
  }
})
end
