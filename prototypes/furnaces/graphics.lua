-- The restored texture and its emission channel share the original canvas and ground anchor.
for tier = 1, 5 do
    local name = "furnace-pro-0" .. tier
    local path = "__advanced-furnaces-2-updated__/graphics/hr/" .. name
    local entity = data.raw["assembling-machine"][name]
    local body = entity.graphics_set.animation.layers[1]
    body.filename = path .. ".png"
    body.width, body.height, body.scale = 460, 460, 0.45
    local glow = entity.graphics_set.working_visualisations[2].animation
    glow.filename = path .. "-glow.png"
    glow.width, glow.height, glow.scale = 460, 460, 0.45
    glow.draw_as_glow = true
    for _, prototype in ipairs({entity, data.raw.item[name], data.raw.recipe[name]}) do
        prototype.icons = nil
        prototype.icon = path .. "-icon.png"
        prototype.icon_size = 64
    end
    local technology = data.raw.technology["furnace-pro-" .. tier]
    technology.icons = nil
    technology.icon = path .. "-technology.png"
    technology.icon_size = 256
end
