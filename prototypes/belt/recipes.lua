function add_belt_pro_recipe(data)
    local name = data.name
    local localised_name = data.localised_name
    local category = data.category or "logistics"
    local ingredients = data.ingredients
    local order = data.order
    local result_count = data.result_count
    return {
        type = "recipe",
        name = name,
        localised_name = localised_name,
        ingredients = ingredients,
        enabled = false,
        order = order,
        subgroup = "belt",
        energy_required = 0.5,
        results = {{type="item", name=name, amount=result_count or 1}},
    }
end

if settings.startup["logist"].value == true then
    local recipes = 
        {
            add_belt_pro_recipe{
                name = "transport-belt-pro",
                localised_name = {"",{"recipe-name.express-transport-belt"}, " PRO-1"},
                ingredients = {
                    {type="item", name="iron-gear-wheel", amount=15},
                    {type="item", name="express-transport-belt", amount=1}
                },
                order = "a[transport-belt]-d[transport-belt-pro]",
            },
            add_belt_pro_recipe{
                name = "transport-belt-pro2",
                localised_name = {"",{"recipe-name.express-transport-belt"}, " PRO-2"},
                ingredients = {
                    {type="item", name="iron-gear-wheel", amount=20},
                    {type="item", name="transport-belt-pro", amount=1}
                },
                order = "a[transport-belt]-e[transport-belt-pro2]",
            },
            add_belt_pro_recipe{
                name = "underground-belt-pro",
                localised_name = {"",{"recipe-name.express-underground-belt"}, " PRO-1"},
                ingredients = {
                    {type="item", name="iron-gear-wheel", amount=80},
                    {type="item", name="express-underground-belt", amount=2}
                },
                order = "b[underground-belt]-d[underground-belt-pro]",
                result_count = 2
            },
            add_belt_pro_recipe{
                name = "underground-belt-pro2",
                localised_name = {"",{"recipe-name.express-underground-belt"}, " PRO-2"},
                ingredients = {
                    {type="item", name="iron-gear-wheel", amount=80},
                    {type="item", name="underground-belt-pro", amount=2}
                },
                order = "b[underground-belt]-e[underground-belt-pro2]",
                result_count = 2
            },
            add_belt_pro_recipe{
                name = "splitter-pro",
                localised_name = {"",{"recipe-name.express-splitter"}, " PRO-1"},
                ingredients = {
                    {type="item", name="express-splitter", amount=1},
                    {type="item", name="iron-gear-wheel", amount=15},
                    {type="item", name="advanced-circuit", amount=15}
                },
                order = "c[splitter]-d[splitter-pro]",
            },
            add_belt_pro_recipe{
                name = "splitter-pro2",
                localised_name = {"",{"recipe-name.express-splitter"}, " PRO-2"},
                ingredients = {
                    {type="item", name="splitter-pro", amount=1},
                    {type="item", name="iron-gear-wheel", amount=20},
                    {type="item", name="advanced-circuit", amount=20}
                },
                order = "c[splitter]-e[splitter-pro2]",
            }
        }
    data:extend(recipes)
end