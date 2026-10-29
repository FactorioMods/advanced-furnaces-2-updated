-- Vanilla's belt animation tables are local in Factorio 2.1. Read prototypes,
-- including modern direction indices and belt-reader graphics, instead.
local function custom_belt_animation(filename)
    local animation = table.deepcopy(data.raw["transport-belt"]["transport-belt"].belt_animation_set)
    -- These original sheets have 16 columns and 20 rows of 128-pixel frames.
    animation.animation_set = {
        filename = filename,
        priority = "extra-high",
        width = 128,
        height = 128,
        scale = 0.5,
        frame_count = 16,
        direction_count = 20
    }
    return animation
end

transport_belt_pro_animation_set = custom_belt_animation(
    "__advanced-furnaces-2-updated__/graphics/entity/transport-belt-pro.png")
transport_belt_pro2_animation_set = custom_belt_animation(
    "__advanced-furnaces-2-updated__/graphics/entity/transport-belt-pro2.png")
