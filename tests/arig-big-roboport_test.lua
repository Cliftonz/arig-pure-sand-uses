local harness = require("tests.harness")

local function same(actual, expected)
  if type(actual) ~= "table" or type(expected) ~= "table" then
    return actual == expected
  end
  for key, value in pairs(expected) do
    if not same(actual[key], value) then
      return false
    end
  end
  for key in pairs(actual) do
    if expected[key] == nil then
      return false
    end
  end
  return true
end

local function source_roboport()
  return {
    type = "roboport",
    name = "kr-big-roboport",
    icon = "__Krastorio2Assets__/icons/entities/big-roboport.png",
    minable = { mining_time = 1, result = "kr-big-roboport" },
    logistics_radius = 100,
    construction_radius = 200,
    robot_slots_count = 20,
    material_slots_count = 10,
    max_health = 3500,
    energy_usage = "1MW",
    recharge_minimum = "50MJ",
    charging_energy = "5MW",
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      input_flow_limit = "100MW",
      buffer_capacity = "1GJ",
    },
  }
end

local function source_item()
  return {
    type = "item",
    name = "kr-big-roboport",
    icon = "__Krastorio2Assets__/icons/entities/big-roboport.png",
    subgroup = "logistic-network",
    order = "c[signal]-c[big-roboport]",
    place_result = "kr-big-roboport",
    stack_size = 50,
  }
end

harness.stage({})
harness.load("prototypes.arig-big-roboport")
assert(next(data.raw.roboport) == nil, "no roboport should exist without Krastorio2")
assert(next(data.raw.item) == nil, "no item should exist without Krastorio2")
assert(next(data.raw.recipe) == nil, "no recipe should exist without Krastorio2")
assert(
  #data.raw.technology["planetaris-arig-roboport"].effects == 0,
  "planetaris-arig-roboport should gain no effects without Krastorio2"
)

harness.stage({ Krastorio2 = "2.0.19" })
data.raw.roboport["kr-big-roboport"] = source_roboport()
data.raw.item["kr-big-roboport"] = source_item()
harness.load("prototypes.arig-big-roboport")

assert(
  same(data.raw.roboport["arig-kr-big-roboport"], {
    type = "roboport",
    name = "arig-kr-big-roboport",
    icons = {
      {
        icon = "__Krastorio2Assets__/icons/entities/big-roboport.png",
        tint = { 0.871, 0.788, 0.627 },
      },
    },
    minable = { mining_time = 1, result = "arig-kr-big-roboport" },
    logistics_radius = 80,
    construction_radius = 182,
    robot_slots_count = 20,
    material_slots_count = 10,
    max_health = 3500,
    energy_usage = "1MW",
    recharge_minimum = "50MJ",
    charging_energy = "5MW",
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      input_flow_limit = "80MW",
      buffer_capacity = "800MJ",
    },
    surface_conditions = {
      { property = "planetaris-dust-concentration", min = 50, max = 100 },
    },
  }),
  "arig roboport should be the source roboport with only the specified changes"
)
assert(
  same(data.raw.roboport["kr-big-roboport"], source_roboport()),
  "source roboport should be left unchanged"
)

assert(
  same(data.raw.item["arig-kr-big-roboport"], {
    type = "item",
    name = "arig-kr-big-roboport",
    icons = {
      {
        icon = "__Krastorio2Assets__/icons/entities/big-roboport.png",
        tint = { 0.871, 0.788, 0.627 },
      },
    },
    subgroup = "logistic-network",
    order = "c[signal]-c[big-roboport]-arig",
    place_result = "arig-kr-big-roboport",
    stack_size = 50,
  }),
  "arig item should be the source item with only the specified changes"
)
assert(same(data.raw.item["kr-big-roboport"], source_item()), "source item should be left unchanged")

assert(
  same(data.raw.recipe["arig-kr-big-roboport"], {
    type = "recipe",
    name = "arig-kr-big-roboport",
    energy_required = 30,
    enabled = false,
    ingredients = {
      { type = "item", name = "steel-plate", amount = 20 },
      { type = "item", name = "planetaris-heavy-glass", amount = 50 },
      { type = "item", name = "kr-rare-metals", amount = 80 },
      { type = "item", name = "planetaris-arig-roboport", amount = 1 },
    },
    results = {
      { type = "item", name = "arig-kr-big-roboport", amount = 1 },
    },
  }),
  "recipe should have exactly the specified fields"
)

assert(
  same(data.raw.technology["planetaris-arig-roboport"].effects, {
    { type = "unlock-recipe", recipe = "arig-kr-big-roboport" },
  }),
  "planetaris-arig-roboport should gain exactly the unlock effect"
)
