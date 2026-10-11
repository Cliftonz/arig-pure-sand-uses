local harness = require("tests.harness")

local kr_roboports = { "kr-big-roboport", "kr-small-roboport" }

local function field_count(t)
  local count = 0
  for _ in pairs(t) do
    count = count + 1
  end
  return count
end

local function assert_dust_condition(condition, label)
  assert(condition.property == "planetaris-dust-concentration", label .. " dust condition property")
  assert(condition.max == 50, label .. " dust condition max")
  assert(field_count(condition) == 2, label .. " dust condition field count")
end

local function add_bystanders()
  data.raw.roboport["roboport"] = {
    type = "roboport",
    name = "roboport",
    surface_conditions = { { property = "planetaris-dust-concentration", max = 50 } },
  }
  data.raw.roboport["arig-kr-big-roboport"] = {
    type = "roboport",
    name = "arig-kr-big-roboport",
    surface_conditions = { { property = "planetaris-dust-concentration", min = 50 } },
  }
end

local function assert_bystanders_unchanged()
  local vanilla = data.raw.roboport["roboport"]
  assert(field_count(vanilla) == 3, "roboport field count")
  assert(#vanilla.surface_conditions == 1, "roboport condition count")
  assert(vanilla.surface_conditions[1].property == "planetaris-dust-concentration", "roboport condition property")
  assert(vanilla.surface_conditions[1].max == 50, "roboport condition max")
  assert(field_count(vanilla.surface_conditions[1]) == 2, "roboport condition field count")

  local arig = data.raw.roboport["arig-kr-big-roboport"]
  assert(field_count(arig) == 3, "arig-kr-big-roboport field count")
  assert(#arig.surface_conditions == 1, "arig-kr-big-roboport condition count")
  assert(
    arig.surface_conditions[1].property == "planetaris-dust-concentration",
    "arig-kr-big-roboport condition property"
  )
  assert(arig.surface_conditions[1].min == 50, "arig-kr-big-roboport condition min")
  assert(field_count(arig.surface_conditions[1]) == 2, "arig-kr-big-roboport condition field count")
end

harness.stage({})
add_bystanders()
harness.load("data-updates")
assert(field_count(data.raw.roboport) == 2, "no roboport should appear without Krastorio2")
assert_bystanders_unchanged()

harness.stage({ Krastorio2 = "2.0.19" })
add_bystanders()
for _, name in ipairs(kr_roboports) do
  data.raw.roboport[name] = { type = "roboport", name = name }
end
harness.load("data-updates")
for _, name in ipairs(kr_roboports) do
  local conditions = data.raw.roboport[name].surface_conditions
  assert(conditions ~= nil, name .. " should gain surface_conditions")
  assert(#conditions == 1, name .. " should hold exactly one condition")
  assert(field_count(conditions) == 1, name .. " surface_conditions should hold nothing but the list entry")
  assert_dust_condition(conditions[1], name)
  assert(field_count(data.raw.roboport[name]) == 3, name .. " should gain no other field")
end
assert(field_count(data.raw.roboport) == 4, "no roboport should be added")
assert_bystanders_unchanged()

data.raw.roboport["kr-big-roboport"].surface_conditions[1].max = 1
assert(
  data.raw.roboport["kr-small-roboport"].surface_conditions[1].max == 50,
  "the two roboports should not share one dust condition"
)

harness.stage({ Krastorio2 = "2.0.19", ["Krastorio2-spaced-out"] = "1.0.0" })
add_bystanders()
for _, name in ipairs(kr_roboports) do
  data.raw.roboport[name] = {
    type = "roboport",
    name = name,
    surface_conditions = { { property = "pressure", min = 10 } },
  }
end
harness.load("data-updates")
for _, name in ipairs(kr_roboports) do
  local conditions = data.raw.roboport[name].surface_conditions
  assert(#conditions == 2, name .. " should hold exactly two conditions")
  assert(field_count(conditions) == 2, name .. " surface_conditions should hold nothing but the two entries")
  assert(conditions[1].property == "pressure", name .. " pressure condition should stay first")
  assert(conditions[1].min == 10, name .. " pressure condition min should be unchanged")
  assert(field_count(conditions[1]) == 2, name .. " pressure condition field count")
  assert_dust_condition(conditions[2], name)
  assert(field_count(data.raw.roboport[name]) == 3, name .. " should gain no other field")
end
assert(field_count(data.raw.roboport) == 4, "no roboport should be added")
assert_bystanders_unchanged()

data.raw.roboport["kr-big-roboport"].surface_conditions[2].max = 1
assert(
  data.raw.roboport["kr-small-roboport"].surface_conditions[2].max == 50,
  "the two roboports should not share one dust condition when conditions already exist"
)
