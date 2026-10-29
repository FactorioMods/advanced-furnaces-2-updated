-- Run after other compatibility adjustments, once all belt prototypes exist.
return function()
    local belts = {"transport-belt", "fast-transport-belt", "express-transport-belt",
        "transport-belt-pro", "transport-belt-pro2"}
    local loaders = {"loader-pro-001", "loader-pro-002", "loader-pro-01", "loader-pro-02", "loader-pro-03"}
    for index, name in ipairs(loaders) do
        local loader = data.raw["loader-1x1"][name]
        local belt = data.raw["transport-belt"][belts[index]]
        if loader and belt then
            loader.belt_animation_set = table.deepcopy(belt.belt_animation_set)
            loader.animation_speed_coefficient = belt.animation_speed_coefficient
            loader.speed = belt.speed
        end
    end
end
