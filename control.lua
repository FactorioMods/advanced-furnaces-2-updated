--[[ Copyright (c) 2017 Optera
 * Part of Loader Redux. See LICENSE.md.
--]]
local snapping = require("snapping")
local direction = defines.direction
local opposite = {
  [direction.north] = direction.south, [direction.south] = direction.north,
  [direction.east] = direction.west, [direction.west] = direction.east
}
local supported_loaders, supported_loader_names = {}, {}
local use_train
local update_tick, rebuild

local function rebuild_names()
  supported_loaders, supported_loader_names = {}, {}
  if settings.startup["logist"].value then
    for _, name in ipairs({"loader-pro-001", "loader-pro-002", "loader-pro-01", "loader-pro-02", "loader-pro-03"}) do
      supported_loaders[name] = true
    end
  end
  -- Explicit removals override built-ins, too. Never write storage from on_load.
  for name, enabled in pairs(storage.loader_registrations or {}) do
    supported_loaders[name] = enabled or nil
  end
  for name in pairs(supported_loaders) do supported_loader_names[#supported_loader_names + 1] = name end
  table.sort(supported_loader_names)
  use_train = settings.global["loader-pro-use-trains"].value
end

remote.add_interface("loader-pro", {
  add_loader = function(name)
    if type(name) ~= "string" then return end
    storage.loader_registrations = storage.loader_registrations or {}
    storage.loader_registrations[name] = true
    rebuild()
  end,
  remove_loader = function(name)
    if type(name) ~= "string" then return end
    storage.loader_registrations = storage.loader_registrations or {}
    storage.loader_registrations[name] = false
    rebuild()
  end
})

local function wagon_valid(wagon)
  if use_train == "disabled" or not wagon or not wagon.valid then return false end
  local train = wagon.train
  return train and (train.state == defines.train_state.wait_station or
    (use_train == "all trains" and train.state == defines.train_state.manual_control and train.speed == 0))
end

local function sorted_keys(values)
  local keys = {}
  for key in pairs(values) do keys[#keys + 1] = key end
  table.sort(keys)
  return keys
end

local function quality_matches(quality, filter)
  if not filter.quality then return true end
  local expected = type(filter.quality) == "string" and prototypes.quality[filter.quality] or filter.quality
  local actual = prototypes.quality[quality or "normal"]
  if not actual or not expected then return false end
  local a, b = actual.level, expected.level
  local comparator = filter.comparator or "="
  if comparator == "=" then return actual.name == expected.name end
  if comparator == "≠" or comparator == "!=" then return actual.name ~= expected.name end
  if comparator == ">" then return a > b end
  if comparator == "<" then return a < b end
  if comparator == "≥" or comparator == ">=" then return a >= b end
  if comparator == "≤" or comparator == "<=" then return a <= b end
  return false
end

local function get_filters(loader)
  local filters = {}
  for slot = 1, loader.filter_slot_count do
    local filter = loader.get_filter(slot)
    if filter then filters[#filters + 1] = type(filter) == "string" and {name = filter} or filter end
  end
  return filters
end

local function accepts(loader, filters, item)
  if loader.filter_slot_count == 0 then return true end
  local matched = false
  for _, filter in ipairs(filters) do
    if (not filter.name or filter.name == item.name) and quality_matches(item.quality, filter) then
      matched = true
      break
    end
  end
  if loader.loader_filter_mode == "blacklist" then return not matched end
  -- Preserve unfiltered loader behavior when no slots are configured.
  return #filters == 0 or matched
end

local function wagon_transfer(wagon_data)
  local inventory = wagon_data.wagon_inv
  local scratch = storage.loader_transfer_inventory[1]
  for _, number in ipairs(sorted_keys(wagon_data.loaders)) do
    local data = wagon_data.loaders[number]
    local loader = data.loader
    local filters = get_filters(loader)
    for lane = 1, 2 do
      local line = data[lane]
      if loader.loader_type ~= "output" or line.can_insert_at_back() then
        local source = loader.loader_type == "output" and inventory or line
        -- Copy an actual stack, not get_contents(): preserve spoilage, durability,
        -- ammo, tags and other item metadata while moving only one item per lane.
        for index = 1, #source do
          local stack = source[index]
          if stack.valid_for_read and accepts(loader, filters, {name = stack.name, quality = stack.quality.name}) then
            scratch.set_stack(stack)
            scratch.count = 1
            local inserted
            if loader.loader_type == "output" then inserted = line.insert_at_back(scratch)
            else inserted = inventory.insert(scratch) == 1 end
            scratch.clear()
            if inserted then
              stack.count = stack.count - 1
              break
            end
          end
        end
      end
    end
  end
end
local function forget_wagon(number)
  local data = storage.wagons[number]
  if data then
    for loader_number in pairs(data.loaders) do storage.loader_wagon_map[loader_number] = nil end
    storage.wagons[number] = nil
  end
end

local function loader_active(data)
  local loader = data.loader
  return loader and loader.valid and supported_loaders[loader.name] and
    (loader.loader_type == "output" and loader.direction or opposite[loader.direction]) == data.direction
end

local function find_loader(wagon)
  if not wagon or not wagon.valid then return end
  local number = wagon.unit_number
  forget_wagon(number)
  if not wagon_valid(wagon) or #supported_loader_names == 0 then return end
  local orientation = wagon.orientation
  -- BoundingBox corners are local to its orientation, not world-axis extents.
  -- Rotate all four prototype corners so asymmetric collision boxes work too.
  local box = wagon.prototype.collision_box
  local a = {x = math.huge, y = math.huge}
  local b = {x = -math.huge, y = -math.huge}
  for _, corner in ipairs({
    box.left_top, {x = box.right_bottom.x, y = box.left_top.y},
    box.right_bottom, {x = box.left_top.x, y = box.right_bottom.y}
  }) do
    local x, y = corner.x, corner.y
    if orientation == 0.25 then x, y = -y, x
    elseif orientation == 0.5 then x, y = -x, -y
    elseif orientation == 0.75 then x, y = y, -x end
    x, y = x + wagon.position.x, y + wagon.position.y
    a.x, a.y = math.min(a.x, x), math.min(a.y, y)
    b.x, b.y = math.max(b.x, x), math.max(b.y, y)
  end
  local searches
  if orientation == 0 or orientation == 0.5 then
    searches = {
      {direction.west, {{a.x - 0.9, a.y + 0.2}, {a.x + 0.1, b.y - 0.2}}},
      {direction.east, {{b.x - 0.1, a.y + 0.2}, {b.x + 0.9, b.y - 0.2}}}
    }
  elseif orientation == 0.25 or orientation == 0.75 then
    searches = {
      {direction.north, {{a.x + 0.2, a.y - 0.9}, {b.x - 0.2, a.y + 0.1}}},
      {direction.south, {{a.x + 0.2, b.y - 0.1}, {b.x - 0.2, b.y + 0.9}}}
    }
  else return end
  for _, search in ipairs(searches) do
    for _, loader in ipairs(wagon.surface.find_entities_filtered{
      type = "loader-1x1", name = supported_loader_names, area = search[2], force = wagon.force
    }) do
      local data = {loader = loader, direction = search[1],
        [1] = loader.get_transport_line(1), [2] = loader.get_transport_line(2)}
      if loader_active(data) then
        local old = storage.loader_wagon_map[loader.unit_number]
        if old and storage.wagons[old] then storage.wagons[old].loaders[loader.unit_number] = nil end
        storage.wagons[number] = storage.wagons[number] or {
          wagon = wagon, wagon_inv = wagon.get_inventory(defines.inventory.cargo_wagon), loaders = {}
        }
        storage.wagons[number].loaders[loader.unit_number] = data
        storage.loader_wagon_map[loader.unit_number] = number
      end
    end
  end
end

local function OnTick()
  for _, number in ipairs(sorted_keys(storage.wagons)) do
    local data = storage.wagons[number]
    if wagon_valid(data.wagon) then
      for loader_number, loader_data in pairs(data.loaders) do
        if not loader_active(loader_data) then
          storage.loader_wagon_map[loader_number] = nil
          data.loaders[loader_number] = nil
        end
      end
      if next(data.loaders) then wagon_transfer(data) else forget_wagon(number) end
    else forget_wagon(number) end
  end
  if not next(storage.wagons) then update_tick() end
end

update_tick = function()
  script.on_event(defines.events.on_tick, use_train ~= "disabled" and storage.wagons and next(storage.wagons) and OnTick or nil)
end

rebuild = function()
  rebuild_names()
  if not storage.loader_transfer_inventory or not storage.loader_transfer_inventory.valid then
    storage.loader_transfer_inventory = game.create_inventory(1)
  end
  storage.loader_transfer_inventory.clear()
  storage.wagons, storage.loader_wagon_map = {}, {}
  if use_train ~= "disabled" then
    for _, surface in pairs(game.surfaces) do
      for _, wagon in ipairs(surface.find_entities_filtered{type = "cargo-wagon"}) do find_loader(wagon) end
    end
  end
  update_tick()
end

local function refresh_near(entity)
  if use_train == "disabled" then return end
  if entity.type == "cargo-wagon" then find_loader(entity) end
  local box = entity.bounding_box
  for _, wagon in ipairs(entity.surface.find_entities_filtered{type = "cargo-wagon", area = {
    {box.left_top.x - 2, box.left_top.y - 2}, {box.right_bottom.x + 2, box.right_bottom.y + 2}
  }}) do find_loader(wagon) end
  update_tick()
end

local function built(event)
  local entity = event.destination or event.entity or event.created_entity
  if not entity or not entity.valid then return end
  if supported_loaders[entity.name] then
    -- A clone already has its source configuration.
    if not event.destination then snapping.snap_loader(entity, event) end
  else snapping.check_for_loaders({entity = entity}, supported_loader_names) end
  refresh_near(entity)
end
script.on_event({defines.events.on_built_entity, defines.events.on_robot_built_entity,
  defines.events.script_raised_built, defines.events.script_raised_revive, defines.events.on_entity_cloned}, built)
script.on_event(defines.events.on_player_rotated_entity, function(event)
  snapping.check_for_loaders(event, supported_loader_names)
  refresh_near(event.entity)
end)
script.on_event({defines.events.on_train_changed_state, defines.events.on_train_created}, function(event)
  if use_train == "disabled" then return end
  for _, wagon in ipairs(event.train.cargo_wagons) do find_loader(wagon) end
  update_tick()
end)
script.on_event({defines.events.on_entity_died, defines.events.on_pre_player_mined_item,
  defines.events.on_robot_pre_mined, defines.events.script_raised_destroy}, function(event)
  local entity = event.entity
  if entity.type == "cargo-wagon" then forget_wagon(entity.unit_number)
  elseif entity.type == "loader-1x1" then
    local number = storage.loader_wagon_map[entity.unit_number]
    if number and storage.wagons[number] then
      storage.wagons[number].loaders[entity.unit_number] = nil
      storage.loader_wagon_map[entity.unit_number] = nil
      if not next(storage.wagons[number].loaders) then forget_wagon(number) end
    end
  end
  update_tick()
end)
script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
  if event.setting == "loader-pro-use-trains" then rebuild() end
end)
script.on_init(rebuild)
script.on_configuration_changed(rebuild)
script.on_load(function()
  rebuild_names()
  update_tick()
end)
