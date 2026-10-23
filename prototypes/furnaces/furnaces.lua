local energy = settings.startup["load-furn-energy"].value
local crafting = settings.startup["load-furn-crafting-speed"].value
local polluting = settings.startup["load-furn-pollution-speed"].value
function tabadd(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]  --corrected bug. if t1[#t1+i] is used, indices will be skipped
    end
    return t1
end

function assemblerpictures()
  return
  {
    north =
      {
        filename = "__advanced-furnaces-2-updated__/graphics/entity/assembling-machine-3-pipe-N.png",
        priority = "extra-high",
        width = 71,
        height = 38,
        shift = util.by_pixel(2.25, 15),
        scale = 0.5
      },
    east =
      {
        filename = "__advanced-furnaces-2-updated__/graphics/entity/assembling-machine-3-pipe-E.png",
        priority = "extra-high",
        width = 42,
        height = 76,
        shift = util.by_pixel(-24.5, 1),
        scale = 0.5
      },
    south =
      {
        filename = "__advanced-furnaces-2-updated__/graphics/entity/assembling-machine-3-pipe-S.png",
        priority = "extra-high",
        width = 88,
        height = 61,
        shift = util.by_pixel(0, -30),
        scale = 0.5
      },
    west =
      {
        filename = "__advanced-furnaces-2-updated__/graphics/entity/assembling-machine-3-pipe-W.png",
        priority = "extra-high",
        width = 39,
        height = 73,
        shift = util.by_pixel(25.75, 1.25),
        scale = 0.5
      }
  }
end

function add_furnace(data)
local name = data.name
local crafting_speed = data.crafting_speed
local energy_usage = data.energy_usage
local next_upgrade = data.next_upgrade
local module_slots = data.module_slots
local icon = data.icon
local icons = data.icons
local pollution = data.pollution



-- crafting_categories = {"smelting", "AdvFurn", "mixing-furnace","crafting", "oil-processing", "chemistry", "crafting-with-fluid"}
crafting_categories = {"smelting", "AdvFurn", "mixing-furnace"}
angelssmelting = {"blast-smelting" ,"blast-smelting-2" ,"blast-smelting-3" ,"blast-smelting-4" ,"chemical-smelting" ,"chemical-smelting-2" ,"chemical-smelting-3" ,"chemical-smelting-4" ,"induction-smelting" ,"induction-smelting-2" ,"induction-smelting-3" ,"induction-smelting-4" ,"casting" ,"casting-2" ,"casting-3" ,"casting-4" ,"strand-casting" ,"strand-casting-2" ,"strand-casting-3" ,"strand-casting-4","sintering","sintering-2","sintering-3","sintering-4" }
nonbobelectronics = {"chemical-furnace"}
Bio_Industries = {"biofarm-mod-smelting"}

--[[

if mods["angelssmelting"] then
    for i=1,#angelssmelting do
        crafting_categories[#crafting_categories+1] = angelssmelting[i] 
    end
end
if not mods["bobelectronics"] then
    for i=1,#nonbobelectronics do
        crafting_categories[#crafting_categories+1] = nonbobelectronics[i] 
    end
end
]]-- 

if mods["angelssmelting"] then
    crafting_categories = tabadd(crafting_categories,angelssmelting)
end
if mods["Bio_Industries"] then
    crafting_categories = tabadd(crafting_categories,Bio_Industries)
end
if not mods["bobelectronics"] then
    crafting_categories = tabadd(crafting_categories,nonbobelectronics)
end

--table.foreach(y, function(k, v) table.insert(x, v) end)
 


--[[ shity code
if mods["angelssmelting"] and not mods["bobelectronics"] then
    crafting_categories = {"smelting", "AdvFurn", "strand-casting", "induction-smelting", "induction-smelting-2", "chemical-smelting", "casting", "blast-smelting", "mixing-furnace", "chemical-furnace"}
elseif mods["angelssmelting"] and mods["bobelectronics"] then
    crafting_categories = {"smelting", "AdvFurn", "strand-casting", "induction-smelting", "induction-smelting-2", "chemical-smelting", "casting", "blast-smelting", "mixing-furnace"}
elseif mods["bobelectronics"] and not mods["bobplates"] and not mods["angelssmelting"] then
    crafting_categories = {"smelting", "AdvFurn", "mixing-furnace"}
elseif mods["bobplates"] and not mods["angelssmelting"] then
    crafting_categories = {"smelting", "AdvFurn", "mixing-furnace", "chemical-furnace"}
else
    crafting_categories = {"smelting", "AdvFurn", "mixing-furnace", "chemical-furnace"}
end
]]--


return {
        type = "assembling-machine",
        name = name,
        icon = icon,
        icons = icons,
        icon_size = 64,
        flags = {"placeable-neutral","placeable-player", "player-creation"},
        minable = {mining_time = 1, result = name},
        max_health = 500,
        base_productivity = 0,
        corpse = "big-remnants",
        dying_explosion = "medium-explosion",
        resistances = {
            {type = "fire", percent = 100},
            {type = "acid", percent = 100}
        },
        collision_box = {{-2.5, -2.5}, {2.5, 2.5}},
        selection_box = {{-2.7, -2.6}, {2.7, 2.3}},
        module_slots = module_slots,
        allowed_effects = {"speed", "productivity", "consumption", "pollution", "quality"},
        crafting_categories = crafting_categories,
        fast_replaceable_group = "furnace",
        ingredient_count = 4,
        result_count = 2,
        crafting_speed = crafting_speed,
        next_upgrade = next_upgrade,
        energy_usage = energy_usage,
        fluid_boxes_off_when_no_fluid_recipe = true,
        fluid_boxes = {
            {
                production_type = "input",
                pipe_picture = assemblerpictures(),
                pipe_covers = pipecoverspictures(),

                volume = 1000,
                pipe_connections = {{ flow_direction="input", direction = defines.direction.north, position = {-2, -1.8} }}
            },
            {
                production_type = "input",
                pipe_picture = assemblerpictures(),
                pipe_covers = pipecoverspictures(),

                volume = 1000,
                pipe_connections = {{ flow_direction="input", direction = defines.direction.north, position = {0, -1.8} }}
            },
            {
                production_type = "input",
                pipe_picture = assemblerpictures(),
                pipe_covers = pipecoverspictures(),

                volume = 1000,
                pipe_connections = {{ flow_direction="input", direction = defines.direction.north, position = {2, -1.8} }}
            },
            -- {
            --     production_type = "input",
            --     pipe_picture = assemblerpictures(),
            --     pipe_covers = pipecoverspictures(),

            --     volume = 1000,
            --     pipe_connections = {{ flow_direction="input", direction = defines.direction.north, position = {2, -2} }}
            -- },
            {
                production_type = "output",
                pipe_picture = assemblerpictures(),
                pipe_covers = pipecoverspictures(),
                volume = 1000,
                pipe_connections = {{ flow_direction="output", direction = defines.direction.south, position = {-2, 1.8} }}
            },
            {
                production_type = "output",
                pipe_picture = assemblerpictures(),
                pipe_covers = pipecoverspictures(),
                volume = 1000,
                pipe_connections = {{ flow_direction="output", direction = defines.direction.south, position = {0, 1.8} }}
            },
            {
                production_type = "output",
                pipe_picture = assemblerpictures(),
                pipe_covers = pipecoverspictures(),
                volume = 1000,
                pipe_connections = {{ flow_direction="output", direction = defines.direction.south, position = {2, 1.8} }}
            }
            
        },
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = { pollution = pollution }
        },
        vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
        working_sound = {
            sound = {filename = "__base__/sound/electric-furnace.ogg", volume = 0.7},
            apparent_volume = 1.5
        },

		graphics_set = {
			animation = {
                layers =
                {
                    {
                        filename = "__advanced-furnaces-2-updated__/graphics/entity/"..name..".png",
                        priority = "high",
                        width = 230,
                        height = 230,
                        frame_count = 1,
                        scale = 0.9,
                        shift = util.by_pixel(0,0),
                    },
                    {
                        filename = "__advanced-furnaces-2-updated__/graphics/entity/lab_shadow.png",
                        priority = "high",
                        width = 293,
                        height = 230,
                        frame_count = 1,
                        scale = 0.9,
                        shift = util.by_pixel(30,0),
                        draw_as_shadow = true
                    },
                    {
                        filename = "__advanced-furnaces-2-updated__/graphics/entity/lab_albedo_ao.png",
                        priority = "high",
                        width = 230,
                        height = 230,
                        frame_count = 1,
                        scale = 0.9,
                        shift = util.by_pixel(0,-14),
                    }
                }
            },
			working_visualisations = {
				{
					animation = {
						filename = "__advanced-furnaces-2-updated__/graphics/entity/gr/1.png",
						priority = "high",
						width = 130,
						height = 130,
						frame_count = 10,
						scale =  1.56,
						blend_mode = "additive-soft",
						shift = util.by_pixel(0,0),
						animation_speed = 0.01,
	
					}
				},
				{
					animation = {
						filename = "__advanced-furnaces-2-updated__/graphics/entity/gr/"..name..".png",
						priority = "high",
						width = 230,
						height = 230,
						frame_count = 1,
						scale = 0.9,
						blend_mode = "additive-soft",
						shift = util.by_pixel(0,0),
						animation_speed = 0.3,
					},
					light = {intensity = 0.4, size = 6, shift = {1.9, 2}, color = {r = 255, g = 69, b = 0}}
				},
				{
					light = {intensity = 0.4, size = 6, shift = {-1.9, 2}, color = {r = 255, g = 69, b = 0}}
				},
				{
					light = {intensity = 0.4, size = 7, shift = {0, -1}, color = {r = 255, g = 69, b = 0}}
				}
			}

		}
        
    }
end

local entities =
{
    add_furnace{
        name = "furnace-pro-01",
        crafting_speed = 48 * crafting,
        energy_usage = energy * 4320 .. "kW",
        pollution = polluting * 48 * crafting,
        module_slots = 4,
        icon = "__advanced-furnaces-2-updated__/graphics/icons/ico_1_64.png",
        next_upgrade = "furnace-pro-02",
    },
    add_furnace{
        name = "furnace-pro-02",
        crafting_speed = 96 * crafting,
        energy_usage = energy * 8640 .. "kW",
        pollution = polluting * 96 * crafting,
        module_slots = 6,
        icon = "__advanced-furnaces-2-updated__/graphics/icons/ico_2_64.png",
        next_upgrade = "furnace-pro-03"
    },
    add_furnace{
        name = "furnace-pro-03",
        crafting_speed = 192 * crafting,
        energy_usage = energy * 17280 .. "kW",
        pollution = polluting * 192 * crafting,
        module_slots = 8,
        icon = "__advanced-furnaces-2-updated__/graphics/icons/ico_3_64.png",
        next_upgrade = "furnace-pro-04"
    },
add_furnace{
        name = "furnace-pro-04",
        crafting_speed = 384 * crafting,
        energy_usage = energy * 34560 .. "kW",
        pollution = polluting * 384 * crafting,
        module_slots = 12,
        icon = "__advanced-furnaces-2-updated__/graphics/icons/ico_4_64.png",
        next_upgrade = "furnace-pro-05"
    },
add_furnace{
        name = "furnace-pro-05",
        crafting_speed = 768 * crafting,
        energy_usage = energy * 69120 .. "kW",
        pollution = polluting * 768 * crafting,
        module_slots = 16,
        icon = "__advanced-furnaces-2-updated__/graphics/icons/ico_5_64.png",
        next_upgrade = nil
    }
}
data:extend(entities)
data.raw["assembling-machine"]["furnace-pro-01"].graphics_set.working_visualisations[1].animation.animation_speed = 0.03
data.raw["assembling-machine"]["furnace-pro-02"].graphics_set.working_visualisations[1].animation.animation_speed = 0.02
data.raw["assembling-machine"]["furnace-pro-05"].graphics_set.working_visualisations[1].animation.animation_speed = 0.005