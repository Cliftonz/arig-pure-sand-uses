local harness = require("tests.harness")

local function assert_same(actual, expected, path)
  if type(expected) ~= "table" then
    assert(
      actual == expected,
      path .. " should be " .. tostring(expected) .. " but was " .. tostring(actual)
    )
    return
  end
  assert(type(actual) == "table", path .. " should be a table but was " .. tostring(actual))
  for key, value in pairs(expected) do
    assert_same(actual[key], value, path .. "." .. tostring(key))
  end
  for key in pairs(actual) do
    assert(expected[key] ~= nil, path .. "." .. tostring(key) .. " should not exist")
  end
end

local function source_roboport()
  return {
    type = "roboport",
    name = "kr-small-roboport",
    icon = "__Krastorio2Assets__/icons/entities/small-roboport.png",
    minable = { mining_time = 0.5, result = "kr-small-roboport" },
    max_health = 350,
    recharge_minimum = "50MJ",
    charging_energy = "3MW",
    energy_usage = "50kW",
    logistics_radius = 18,
    construction_radius = 34,
    robot_slots_count = 0,
    material_slots_count = 0,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      input_flow_limit = "24MW",
      buffer_capacity = "300MJ",
    },
  }
end

local function source_item()
  return {
    type = "item",
    name = "kr-small-roboport",
    icon = "__Krastorio2Assets__/icons/entities/small-roboport.png",
    subgroup = "logistic-network",
    order = "c[signal]-b[small-roboport]",
    place_result = "kr-small-roboport",
    stack_size = 50,
  }
end

harness.stage({})
harness.load("prototypes.arig-small-roboport")
assert(next(data.raw.roboport) == nil, "no roboport should exist without Krastorio2")
assert(next(data.raw.item) == nil, "no item should exist without Krastorio2")
assert(next(data.raw.recipe) == nil, "no recipe should exist without Krastorio2")
assert(
  #data.raw.technology["planetaris-arig-roboport"].effects == 0,
  "planetaris-arig-roboport should gain no effects without Krastorio2"
)

harness.stage({ Krastorio2 = "2.0.19" })
data.raw.roboport["kr-small-roboport"] = source_roboport()
data.raw.item["kr-small-roboport"] = source_item()
harness.load("prototypes.arig-small-roboport")

assert_same(data.raw.roboport["arig-kr-small-roboport"], {
  type = "roboport",
  name = "arig-kr-small-roboport",
  icons = {
    {
      icon = "__Krastorio2Assets__/icons/entities/small-roboport.png",
      tint = { 0.871, 0.788, 0.627 },
    },
  },
  minable = { mining_time = 0.5, result = "arig-kr-small-roboport" },
  max_health = 350,
  recharge_minimum = "50MJ",
  charging_energy = "3MW",
  energy_usage = "50kW",
  logistics_radius = 14,
  construction_radius = 31,
  robot_slots_count = 0,
  material_slots_count = 0,
  energy_source = {
    type = "electric",
    usage_priority = "secondary-input",
    input_flow_limit = "19.2MW",
    buffer_capacity = "240MJ",
  },
  surface_conditions = {
    { property = "planetaris-dust-concentration", min = 50, max = 100 },
  },
}, "arig roboport")
assert_same(data.raw.roboport["kr-small-roboport"], source_roboport(), "source roboport")

assert_same(data.raw.item["arig-kr-small-roboport"], {
  type = "item",
  name = "arig-kr-small-roboport",
  icons = {
    {
      icon = "__Krastorio2Assets__/icons/entities/small-roboport.png",
      tint = { 0.871, 0.788, 0.627 },
    },
  },
  subgroup = "logistic-network",
  order = "c[signal]-b[small-roboport]-arig",
  place_result = "arig-kr-small-roboport",
  stack_size = 50,
}, "arig item")
assert_same(data.raw.item["kr-small-roboport"], source_item(), "source item")

assert_same(data.raw.recipe["arig-kr-small-roboport"], {
  type = "recipe",
  name = "arig-kr-small-roboport",
  energy_required = 5,
  enabled = false,
  ingredients = {
    { type = "item", name = "steel-plate", amount = 10 },
    { type = "item", name = "planetaris-heavy-glass", amount = 4 },
    { type = "item", name = "kr-rare-metals", amount = 20 },
    { type = "item", name = "kr-electronic-components", amount = 5 },
  },
  results = {
    { type = "item", name = "arig-kr-small-roboport", amount = 2 },
  },
}, "arig recipe")

assert_same(data.raw.technology["planetaris-arig-roboport"].effects, {
  { type = "unlock-recipe", recipe = "arig-kr-small-roboport" },
}, "planetaris-arig-roboport effects")

local roboport_icons = data.raw.roboport["arig-kr-small-roboport"].icons
local item_icons = data.raw.item["arig-kr-small-roboport"].icons
assert(roboport_icons ~= item_icons, "roboport and item should not share one icons table")
roboport_icons[1].tint[1] = 0
assert(
  item_icons[1].tint[1] == 0.871,
  "mutating the roboport icon tint should leave the item icon tint unchanged"
)
