local harness = require("tests.harness")

local function field_count(t)
  local count = 0
  for _ in pairs(t) do
    count = count + 1
  end
  return count
end

harness.stage({})
harness.load("prototypes.kr-glass")
assert(next(data.raw.recipe) == nil, "no recipe should exist without Krastorio2")
assert(
  #data.raw.technology["planetaris-glass"].effects == 0,
  "planetaris-glass should gain no effects without Krastorio2"
)

harness.stage({ Krastorio2 = "2.0.19" })
harness.load("prototypes.kr-glass")

local recipe = data.raw.recipe["arig-pure-sand-kr-glass"]
assert(recipe ~= nil, "recipe should exist with Krastorio2")
assert(recipe.type == "recipe", "type")
assert(recipe.name == "arig-pure-sand-kr-glass", "name")
assert(recipe.category == "compressing", "category")
assert(recipe.energy_required == 2, "energy_required")
assert(recipe.enabled == false, "enabled")
assert(recipe.auto_recycle == false, "auto_recycle")
assert(recipe.allow_productivity == true, "allow_productivity")
assert(field_count(recipe) == 9, "recipe should have exactly the nine specified fields")

assert(#recipe.ingredients == 1, "ingredient count")
assert(recipe.ingredients[1].type == "fluid", "first ingredient type")
assert(recipe.ingredients[1].name == "planetaris-pure-sand", "first ingredient name")
assert(recipe.ingredients[1].amount == 20, "first ingredient amount")
assert(field_count(recipe.ingredients[1]) == 3, "first ingredient field count")


assert(#recipe.results == 1, "result count")
assert(recipe.results[1].type == "item", "result type")
assert(recipe.results[1].name == "kr-glass", "result name")
assert(recipe.results[1].amount == 1, "result amount")
assert(field_count(recipe.results[1]) == 3, "result field count")

local effects = data.raw.technology["planetaris-glass"].effects
assert(#effects == 1, "planetaris-glass should gain exactly one effect")
assert(effects[1].type == "unlock-recipe", "effect type")
assert(effects[1].recipe == "arig-pure-sand-kr-glass", "effect recipe")
assert(field_count(effects[1]) == 2, "effect field count")

for _, tech in ipairs({ "planetaris-compression", "kr-advanced-chemistry", "planetaris-polishing" }) do
  assert(#data.raw.technology[tech].effects == 0, tech .. " should gain no effects")
end
