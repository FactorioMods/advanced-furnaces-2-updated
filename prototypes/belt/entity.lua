require("prototypes.belt.animation_set")

if settings.startup["logist"].value == true then
     data:extend({
        {
            type = "underground-belt",
            name = "underground-belt-pro",
            localised_name = {"",{"entity-name.express-underground-belt"}, " PRO-1"},
            icon = "__advanced-furnaces-2-updated__/graphics/icons/underground-belt-pro.png",
            icon_size = 32,
            flags = {"placeable-neutral", "player-creation"},
            minable = {hardness = 0.2, mining_time = 0.1, result = "underground-belt-pro"},
            max_health = 300,
            corpse = "small-remnants",
            max_distance = 15,
            underground_sprite =
            {
                filename = "__core__/graphics/arrows/underground-lines.png",
                priority = "high",
                width = 64,
                height = 64,
                x = 64,
                scale = 0.5
            },
            underground_remove_belts_sprite =
            {
                filename = "__core__/graphics/arrows/underground-lines-remove.png",
                priority = "high",
                width = 64,
                height = 64,
                x = 64,
                scale = 0.5
            },
            resistances =
            {
                {
                    type = "fire",
                    percent = 60
                },
                {
                    type = "impact",
                    percent = 30
                }
            },
            collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
            selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
            animation_speed_coefficient = 32,
            belt_animation_set = transport_belt_pro_animation_set,
            fast_replaceable_group = "transport-belt",
            next_upgrade = "underground-belt-pro2",
            speed = data.raw['underground-belt']['underground-belt'].speed*5,
            structure =
        {
            direction_in =
            {
            sheet =
            {
                
                filename = "__advanced-furnaces-2-updated__/graphics/entity/underground-belt-pro.png",
                priority = "extra-high",
                width = 192,
                height = 192,
                y = 192,
                scale = 0.5
            }
            },
            direction_out =
            {
            sheet =
            {
                
                filename = "__advanced-furnaces-2-updated__/graphics/entity/underground-belt-pro.png",
                priority = "extra-high",
                width = 192,
                height =192,
                scale = 0.5
            }
            },
            direction_in_side_loading =
            {
            sheet =
            {
                filename = "__advanced-furnaces-2-updated__/graphics/entity/underground-belt-pro.png",
                priority = "extra-high",
                width = 192,
                height = 192,
                y = 192*3,
                scale = 0.5
            }
            },
            direction_out_side_loading =
            {
            sheet =
            {
                filename = "__advanced-furnaces-2-updated__/graphics/entity/underground-belt-pro.png",
                priority = "extra-high",
                width = 192,
                height = 192,
                y = 192*2,
                scale = 0.5
            }
            },
            back_patch =
            {
            sheet =
            {
                filename = "__base__/graphics/entity/fast-underground-belt/fast-underground-belt-structure-back-patch.png",
                priority = "extra-high",
                width = 192,
                height = 192,
                scale = 0.5
            }
            },
            front_patch =
            {
            sheet =
            {
                filename = "__base__/graphics/entity/fast-underground-belt/fast-underground-belt-structure-front-patch.png",
                priority = "extra-high",
                width = 192,
                height = 192,
                scale = 0.5
            }
            }
        }
        },
            {
            type = "underground-belt",
            name = "underground-belt-pro2",
            localised_name = {"",{"entity-name.express-underground-belt"}, " PRO-2"},
            icon = "__advanced-furnaces-2-updated__/graphics/icons/underground-belt-pro2.png",
            icon_size = 32,
            flags = {"placeable-neutral", "player-creation"},
            minable = {hardness = 0.2, mining_time = 0.1, result = "underground-belt-pro2"},
            max_health = 300,
            corpse = "small-remnants",
            max_distance = 20,
            underground_sprite =
            {
                filename = "__core__/graphics/arrows/underground-lines.png",
                priority = "high",
                width = 64,
                height = 64,
                x = 64,
                scale = 0.5
            },
            underground_remove_belts_sprite =
            {
                filename = "__core__/graphics/arrows/underground-lines-remove.png",
                priority = "high",
                width = 64,
                height = 64,
                x = 64,
                scale = 0.5
            },
            resistances =
            {
                {
                    type = "fire",
                    percent = 60
                },
                {
                    type = "impact",
                    percent = 30
                }
            },
            collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
            selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
            animation_speed_coefficient = 32,
            belt_animation_set = transport_belt_pro2_animation_set,
            fast_replaceable_group = "transport-belt",
            next_upgrade = nil,
            speed = data.raw['transport-belt']['transport-belt'].speed*7,
            structure =
        {
            direction_in =
            {
            sheet =
            {
                filename = "__advanced-furnaces-2-updated__/graphics/entity/underground-belt-pro2.png",
                priority = "extra-high",
                width = 192,
                height = 192,
                y = 192,
                scale = 0.5
            }
            },
            direction_out =
            {
            sheet =
            {
                filename = "__advanced-furnaces-2-updated__/graphics/entity/underground-belt-pro2.png",
                priority = "extra-high",
                width = 192,
                height =192,
                scale = 0.5
            }
            },
            direction_in_side_loading =
            {
            sheet =
            {
                filename = "__advanced-furnaces-2-updated__/graphics/entity/underground-belt-pro2.png",
                priority = "extra-high",
                width = 192,
                height = 192,
                y = 192*3,
                scale = 0.5
            }
            },
            direction_out_side_loading =
            {
            sheet =
            {
                filename = "__advanced-furnaces-2-updated__/graphics/entity/underground-belt-pro2.png",
                priority = "extra-high",
                width = 192,
                height = 192,
                y = 192*2,
                scale = 0.5
            }
            },
            back_patch =
            {
            sheet =
            {
                filename = "__base__/graphics/entity/fast-underground-belt/fast-underground-belt-structure-back-patch.png",
                priority = "extra-high",
                width = 192,
                height = 192,
                scale = 0.5
            }
            },
            front_patch =
            {
            sheet =
            {
                filename = "__base__/graphics/entity/fast-underground-belt/fast-underground-belt-structure-front-patch.png",
                priority = "extra-high",
                width = 192,
                height = 192,
                scale = 0.5
            }
            }
        }
        },
            {
            type = "splitter",
            name = "splitter-pro",
            localised_name = {"",{"entity-name.express-splitter"}, " PRO-1"},
            icon = "__advanced-furnaces-2-updated__/graphics/icons/splitter-pro.png",
            icon_size = 32,
            flags = {"placeable-neutral", "player-creation"},
            minable = {hardness = 0.2, mining_time = 0.1, result = "splitter-pro"},
            max_health = 300,
            corpse = "medium-remnants",
            resistances =
            {
                {
                    type = "fire",
                    percent = 60
                }
            },
            collision_box = {{-0.9, -0.4}, {0.9, 0.4}},
            selection_box = {{-0.9, -0.5}, {0.9, 0.5}},
            animation_speed_coefficient = 32,
            structure_animation_speed_coefficient = 1.2,
            structure_animation_movement_cooldown = 10,
            belt_animation_set = transport_belt_pro_animation_set,
            fast_replaceable_group = "transport-belt",
            next_upgrade = "splitter-pro2",
            speed = data.raw['splitter']['splitter'].speed*5,
            structure =
        {
            north =
            {
                filename = "__advanced-furnaces-2-updated__/graphics/entity/splitter-north-pro.png",
                frame_count = 32,
                line_length = 8,
                priority = "extra-high",
                width = 160,
                height = 70,
                shift = util.by_pixel(7, 0),
                scale = 0.5
            },
            east =
            {
                filename = "__advanced-furnaces-2-updated__/graphics/entity/splitter-east-pro.png",
                frame_count = 32,
                line_length = 8,
                priority = "extra-high",
                width = 90,
                height = 160,
                shift = util.by_pixel(4, -6),
                scale = 0.5
            },
            south =
            {
                filename = "__advanced-furnaces-2-updated__/graphics/entity/splitter-south-pro.png",
                frame_count = 32,
                line_length = 8,
                priority = "extra-high",
                width = 164,
                height = 64,
                shift = util.by_pixel(4, 0),
                scale = 0.5
            },
            west =
            {
                filename = "__advanced-furnaces-2-updated__/graphics/entity/splitter-west-pro.png",
                frame_count = 32,
                line_length = 8,
                priority = "extra-high",
                width = 90,
                height = 150,
                shift = util.by_pixel(6, -4),
                scale = 0.5
            }
        }
        },
             {
            type = "splitter",
            name = "splitter-pro2",
            localised_name = {"",{"entity-name.express-splitter"}, " PRO-2"},
            icon = "__advanced-furnaces-2-updated__/graphics/icons/splitter-pro2.png",
            icon_size = 32,
            flags = {"placeable-neutral", "player-creation"},
            minable = {hardness = 0.2, mining_time = 0.1, result = "splitter-pro2"},
            max_health = 190,
            corpse = "medium-remnants",
            resistances =
            {
                {
                    type = "fire",
                    percent = 60
                }
            },
            collision_box = {{-0.9, -0.4}, {0.9, 0.4}},
            selection_box = {{-0.9, -0.5}, {0.9, 0.5}},
            animation_speed_coefficient = 32,
            structure_animation_speed_coefficient = 1.2,
            structure_animation_movement_cooldown = 10,
            belt_animation_set = transport_belt_pro2_animation_set,
            fast_replaceable_group = "transport-belt",
            next_upgrade = nil,
            speed = data.raw['transport-belt']['transport-belt'].speed*7,
            structure =
        {
            north =
            {
                filename = "__advanced-furnaces-2-updated__/graphics/entity/splitter-north-pro2.png",
                frame_count = 32,
                line_length = 8,
                priority = "extra-high",
                width = 160,
                height = 70,
                shift = util.by_pixel(7, 0),
                scale = 0.5
            },
            east =
            {
                filename = "__advanced-furnaces-2-updated__/graphics/entity/splitter-east-pro2.png",
                frame_count = 32,
                line_length = 8,
                priority = "extra-high",
                width = 90,
                height = 160,
                shift = util.by_pixel(4, -6),
                scale = 0.5
            },
            south =
            {
                filename = "__advanced-furnaces-2-updated__/graphics/entity/splitter-south-pro2.png",
                frame_count = 32,
                line_length = 8,
                priority = "extra-high",
                width = 164,
                height = 64,
                shift = util.by_pixel(4, 0),
                scale = 0.5
            },
            west =
            {
                filename = "__advanced-furnaces-2-updated__/graphics/entity/splitter-west-pro2.png",
                frame_count = 32,
                line_length = 8,
                priority = "extra-high",
                width = 90,
                height = 150,
                shift = util.by_pixel(6, -4),
                scale = 0.5
            }
        }
        },
        {
            type = "transport-belt",
            name = "transport-belt-pro",
            related_underground_belt = "underground-belt-pro",
            localised_name = {"",{"entity-name.express-transport-belt"}, " PRO-1"},
            icon = "__advanced-furnaces-2-updated__/graphics/icons/transport-belt-pro.png",
            icon_size = 32,
            flags = {"placeable-neutral", "player-creation"},
            minable = {hardness = 0.2, mining_time = 0.1, result = "transport-belt-pro"},
            max_health = 300,
            corpse = "small-remnants",
            resistances =
            {
                {
                    type = "fire",
                    percent = 50
                }
            },
            collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
            selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
            working_sound =
            {
                sound =
                {
                    filename = "__base__/sound/express-transport-belt.ogg",
                    volume = 0.4
                },
                max_sounds_per_type = 3
            },
            animation_speed_coefficient = 32,
            belt_animation_set = transport_belt_pro_animation_set,
            fast_replaceable_group = "transport-belt",
            next_upgrade = "transport-belt-pro2",
            speed = data.raw['transport-belt']['transport-belt'].speed*5,
            connector_frame_sprites = transport_belt_connector_frame_sprites,
            circuit_connector = table.deepcopy(circuit_connector_definitions["belt"]),
            circuit_wire_max_distance = transport_belt_circuit_wire_max_distance
        },
         {
            type = "transport-belt",
            name = "transport-belt-pro2",
            related_underground_belt = "underground-belt-pro2",
            localised_name = {"",{"entity-name.express-transport-belt"}, " PRO-2"},
            icon = "__advanced-furnaces-2-updated__/graphics/icons/transport-belt-pro2.png",
            icon_size = 32,
            flags = {"placeable-neutral", "player-creation"},
            minable = {hardness = 0.2, mining_time = 0.1, result = "transport-belt-pro2"},
            max_health = 300,
            corpse = "small-remnants",
            resistances =
            {
                {
                    type = "fire",
                    percent = 50
                }
            },
            collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
            selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
            working_sound =
            {
                sound =
                {
                    filename = "__base__/sound/express-transport-belt.ogg",
                    volume = 0.4
                },
                max_sounds_per_type = 3
            },
            animation_speed_coefficient = 32,
            belt_animation_set = transport_belt_pro2_animation_set,
            fast_replaceable_group = "transport-belt",
            next_upgrade = nil,
            speed = data.raw['transport-belt']['transport-belt'].speed*7,
            connector_frame_sprites = transport_belt_connector_frame_sprites,
            circuit_connector = table.deepcopy(circuit_connector_definitions["belt"]),
            circuit_wire_max_distance = transport_belt_circuit_wire_max_distance
        }
    })
end
