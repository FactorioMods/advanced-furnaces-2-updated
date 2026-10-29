--[[ Copyright (c) 2017 Optera
 * Part of Loader Redux
 *
 * See LICENSE.md in the project directory for license information.
--]]

local snapping = {}

local snapTypes = {
    ["loader-1x1"] = true,
    ["loader"] = true,
    ["splitter"] = true,
    ["underground-belt"] = true,
    ["transport-belt"] = true
}

-- set loader direction according to adjacent belts
local function snap_loader_to_target(loader, entity, event)
    if not entity or not entity.valid or not loader or not loader.valid then
        log("Entity or Loader were invalid.")
        return
    end

    if not snapTypes[entity.type] then
        log(entity.type.." not a valid entity for loader connection")
        return
    end
    -- local targetio = nil
    -- if entity.type == "loader" then targetio = entity.loader_type end
    -- if entity.type == "underground-belt" then targetio = entity.belt_to_ground_type end
    -- log("target: "..entity.name.." position: "..entity.position.x..","..entity.position.y.."    direction: "..entity.direction.." "..tostring(targetio))
    -- log("loader: "..loader.name.." position: "..loader.position.x..","..loader.position.y.."    direction: "..loader.direction.." "..loader.loader_type)

    -- loader facing
    -- north 0: Loader 0 output or 4 input
    -- east    2: Loader 2 output or 6 input
    -- south 4: Loader 4 output or 0 input
    -- west    6: Loader 6 output or 2 input

    local direction = loader.direction
    local loader_type = loader.loader_type

    if loader.direction == defines.direction.north or loader.direction == defines.direction.south then -- loader and entity are aligned vertically
        if loader.position.y > entity.position.y then
            if entity.direction == defines.direction.south then
                direction = defines.direction.south
                loader_type = "input"
            else
                direction = defines.direction.north
                loader_type = "output"
            end
        elseif loader.position.y < entity.position.y then
            if entity.direction == defines.direction.north then
                direction = defines.direction.north
                loader_type = "input"
            else
                direction = defines.direction.south
                loader_type = "output"
            end
        end
    else -- loader and entity are aligned horizontally
        if loader.position.x > entity.position.x then
            if entity.direction == defines.direction.east then
                direction = defines.direction.east
                loader_type = "input"
            else
                direction = defines.direction.west
                loader_type = "output"
            end
        elseif loader.position.x < entity.position.x then
            if entity.direction == defines.direction.west then
                direction = defines.direction.west
                loader_type = "input"
            else
                direction = defines.direction.east
                loader_type = "output"
            end
        end
    end

    -- set loader_type first or the loader will end up in different positions than intended
    if loader.direction ~= direction or loader.loader_type ~= loader_type then
        --loader.surface.create_entity{name="flying-text", position={loader.position.x-.25, loader.position.y-.5}, text = "^", color = {g=1}}
        loader.loader_type = loader_type
        loader.direction = direction
    end
end

-- returns loaders next to a given entity
local function find_loader_by_entity(entity, supported_loader_names)
    local position = entity.position
    local box = entity.prototype.selection_box
    local area = {
        {position.x + box.left_top.x-1, position.y + box.left_top.y-1},
        {position.x + box.right_bottom.x + 1, position.y + box.right_bottom.y + 1}
    }
    return entity.surface.find_entities_filtered{type="loader-1x1", name=supported_loader_names, area=area, force=entity.force}
end

-- returns entities in front and behind a given loader
local function find_entity_by_loader(loader)
    local lbox = loader.prototype.selection_box
    local check
    if loader.direction == defines.direction.north or loader.direction == defines.direction.south then
        check = {
            {loader.position.x -.4, loader.position.y + lbox.left_top.y -1},
            {loader.position.x +.4, loader.position.y + lbox.right_bottom.y +1}
        }
    else
        check = {
            {loader.position.x + lbox.left_top.x - 1, loader.position.y - .4},
            {loader.position.x + lbox.right_bottom.x + 1, loader.position.y + .4}
        }
    end
    return loader.surface.find_entities_filtered{area=check, force=loader.force}
end

-- called when entity was rotated or non loader was built
function snapping.check_for_loaders(event, supported_loader_names)
    local entity = event.created_entity or event.entity
    if not entity or not entity.valid or #supported_loader_names == 0 then return end
    if snapTypes[entity.type] then
        local loaders = find_loader_by_entity(entity, supported_loader_names)
        for _, loader in pairs(loaders) do
        local entities = find_entity_by_loader(loader)
            for _, ent in pairs(entities) do
                if ent == entity and ent ~= loader and snapTypes[ent.type] then
                    snap_loader_to_target(loader, ent, event)
                end
            end
        end

        -- also scan other exit of underground belt
        if entity.type == "underground-belt" and entity.underground_belt_neighbour then
            local loaders = find_loader_by_entity(entity.underground_belt_neighbour, supported_loader_names)
            for _, loader in pairs(loaders) do
            local entities = find_entity_by_loader(loader)
                for _, ent in pairs(entities) do
                    if ent == entity.underground_belt_neighbour and ent ~= loader and snapTypes[ent.type] then
                        snap_loader_to_target(loader, ent, event)
                    end
                end
            end
        end

    end
end

-- called when loader was built
function snapping.snap_loader(loader, event)
    local entities = find_entity_by_loader(loader)
    local snapped = false
    for _, ent in pairs(entities) do
        -- log("(snap_loader) target: "..ent.name.." position: "..ent.position.x..","..ent.position.y.."    direction: "..ent.direction)
        if ent.valid and ent ~= loader and snapTypes[ent.type] then
            snap_loader_to_target(loader, ent, event)
            snapped = true
        end
    end

end

return snapping
