function add_loader_pro_recipe(data)
    local name = data.name
    local localised_name = data.localised_name
    local category = data.category or "logistics"
    local ingredients = data.ingredients
    local order = data.order
    return {
        type = "recipe",
        name = name,
        localised_name = localised_name,
        ingredients = ingredients,
        enabled = false,
        order = order,
        subgroup = "belt",
        energy_required = 0.5,
        results = {{type="item", name=name, amount=1}},
    }
end

if settings.startup["logist"].value == true then
    local recipes = 
        {
            add_loader_pro_recipe{
                name = 'loader-pro-001',
                localised_name = {"recipe-name.loader"},
                ingredients = {
                    {type="item", name="inserter", amount=5},
                    {type="item", name="electronic-circuit", amount=5},
                    {type="item", name="iron-gear-wheel", amount=5},
                    {type="item", name="iron-plate", amount=5},
                    {type="item", name="transport-belt", amount=5}
                },
                order = "d[loader-pro]-a[loader-pro-001]",
            },
            add_loader_pro_recipe{
                name = 'loader-pro-002',
                localised_name = {"recipe-name.fast-loader"},
                ingredients = {
                    {type="item", name="fast-transport-belt", amount=5},
                    {type="item", name="loader-pro-001", amount=1}
                },
                order = "d[loader-pro]-b[loader-pro-002]",
            },
            add_loader_pro_recipe{
                name = "loader-pro-01",
                localised_name = {"recipe-name.express-loader"},
                ingredients = {
                    {type="item", name="express-transport-belt", amount=5},
                    {type="item", name="bulk-inserter", amount=3}
                },
                order = "d[loader-pro]-c[loader-pro-01]",
            },
            add_loader_pro_recipe{
                name = "loader-pro-02",
                localised_name = {"",{"recipe-name.express-loader"}, " PRO-1"},
                ingredients = {
                    {type="item", name="transport-belt-pro", amount=5},
                    {type="item", name="bulk-inserter", amount=3}
                },
                order = "d[loader-pro]-d[loader-pro-02]",
            },
            add_loader_pro_recipe{
                name = "loader-pro-03",
                localised_name = {"",{"recipe-name.express-loader"}, " PRO-2"},
                ingredients = {
                    {type="item", name="transport-belt-pro2", amount=5},
                    {type="item", name="loader-pro-02", amount=1}
                },
                order = "d[loader-pro]-e[loader-pro-03]",
            }
        }
    data:extend(recipes)
end