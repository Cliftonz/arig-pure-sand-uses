local harness = require("tests.harness")

local techs = {
  "planetaris-compression",
  "planetaris-glass",
  "kr-advanced-chemistry",
  "planetaris-polishing",
  "planetaris-arig-roboport",
}

package.preload["fixture.inner"] = function()
  data:extend({
    { type = "recipe", name = "fixture-recipe", seen_krastorio = mods["Krastorio2"] },
  })
  table.insert(
    data.raw.technology["planetaris-glass"].effects,
    { type = "unlock-recipe", recipe = "fixture-recipe" }
  )
end

package.preload["fixture.outer"] = function()
  require("fixture.inner")
end

package.preload["fixture.copy"] = function()
  local roboport = table.deepcopy(data.raw.roboport["fixture-source"])
  roboport.name = "fixture-roboport"
  roboport.energy_source.usage_priority = "primary-input"
  data:extend({ roboport, { type = "item", name = "fixture-item" } })
end

harness.stage({ Krastorio2 = "2.0.0" })
assert(mods["Krastorio2"] == "2.0.0", "mods should hold the requested mod version")
assert(mods["Igrys"] == nil, "mods should not hold an unrequested mod")
for _, tech in ipairs(techs) do
  assert(#data.raw.technology[tech].effects == 0, tech .. " should start with no effects")
end
assert(data.raw.recipe["fixture-recipe"] == nil, "fresh stage should hold no recipes")

harness.load("fixture.outer")
assert(
  data.raw.recipe["fixture-recipe"].seen_krastorio == "2.0.0",
  "extended recipe should be stored at data.raw.recipe[name]"
)
assert(
  data.raw.technology["planetaris-glass"].effects[1].recipe == "fixture-recipe",
  "module should be able to add a technology effect"
)

harness.stage({})
assert(mods["Krastorio2"] == nil, "new stage should drop mods from the previous stage")
assert(data.raw.recipe["fixture-recipe"] == nil, "new stage should drop previous prototypes")
assert(
  #data.raw.technology["planetaris-glass"].effects == 0,
  "new stage should drop previous technology effects"
)

harness.load("fixture.outer")
assert(
  data.raw.recipe["fixture-recipe"] ~= nil,
  "module and its nested requires should run again on a second load"
)
assert(
  data.raw.recipe["fixture-recipe"].seen_krastorio == nil,
  "second load should see the second stage's mods"
)
assert(
  #data.raw.technology["planetaris-glass"].effects == 1,
  "second load should add its effect exactly once"
)

harness.stage({})
assert(next(data.raw.item) == nil, "fresh stage should hold no items")
assert(next(data.raw.roboport) == nil, "fresh stage should hold no roboports")

data.raw.roboport["fixture-source"] = {
  type = "roboport",
  name = "fixture-source",
  energy_source = { usage_priority = "secondary-input" },
}
harness.load("fixture.copy")
assert(data.raw.item["fixture-item"].type == "item", "extended item should be stored at data.raw.item[name]")
assert(
  data.raw.roboport["fixture-roboport"].energy_source.usage_priority == "primary-input",
  "extended roboport should be stored at data.raw.roboport[name]"
)
assert(data.raw.roboport["fixture-source"].name == "fixture-source", "copy should not rename the original")
assert(
  data.raw.roboport["fixture-source"].energy_source.usage_priority == "secondary-input",
  "mutating a nested table of the copy should leave the original unchanged"
)

harness.stage({})
assert(next(data.raw.item) == nil, "new stage should drop previous items")
assert(next(data.raw.roboport) == nil, "new stage should drop previous roboports")

local original = { nested = { deeper = { value = 1 } } }
local copy = table.deepcopy(original)
assert(copy.nested.deeper.value == 1, "deepcopy should carry nested values")
copy.nested.deeper.value = 2
assert(original.nested.deeper.value == 1, "deepcopy should not share nested tables")
assert(table.deepcopy(5) == 5, "deepcopy should return a number as is")
assert(table.deepcopy("sand") == "sand", "deepcopy should return a string as is")
