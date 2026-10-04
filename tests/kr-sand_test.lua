local harness = require("tests.harness")

harness.stage({})
harness.load("prototypes.kr-sand")
assert(
  data.raw.recipe["arig-pure-sand-kr-sand"] == nil,
  "without Krastorio2 the kr-sand recipe should not exist"
)
assert(
  #data.raw.technology["planetaris-compression"].effects == 0,
  "without Krastorio2 planetaris-compression should gain no effects"
)

harness.stage({ Krastorio2 = "2.0.19" })
harness.load("prototypes.kr-sand")

local recipe = data.raw.recipe["arig-pure-sand-kr-sand"]
assert(recipe ~= nil, "with Krastorio2 the kr-sand recipe should exist")
assert(recipe.type == "recipe", "type should be recipe")
assert(recipe.name == "arig-pure-sand-kr-sand", "name should be arig-pure-sand-kr-sand")
assert(recipe.category == "compressing", "category should be compressing")
assert(recipe.energy_required == 2, "energy_required should be 2")
assert(recipe.enabled == false, "enabled should be false")
assert(recipe.auto_recycle == false, "auto_recycle should be false")
assert(recipe.allow_productivity == true, "allow_productivity should be true")

assert(#recipe.ingredients == 1, "there should be exactly one ingredient")
local ingredient = recipe.ingredients[1]
assert(ingredient.type == "fluid", "ingredient type should be fluid")
assert(ingredient.name == "planetaris-pure-sand", "ingredient should be planetaris-pure-sand")
assert(ingredient.amount == 50, "ingredient amount should be 50")

assert(#recipe.results == 1, "there should be exactly one result")
local result = recipe.results[1]
assert(result.type == "item", "result type should be item")
assert(result.name == "kr-sand", "result should be kr-sand")
assert(result.amount == 5, "result amount should be 5")

local field_counts = {
  { "recipe", recipe, 9 },
  { "ingredient", ingredient, 3 },
  { "result", result, 3 },
}
for _, entry in ipairs(field_counts) do
  local count = 0
  for _ in pairs(entry[2]) do
    count = count + 1
  end
  assert(count == entry[3], entry[1] .. " should have exactly " .. entry[3] .. " fields, has " .. count)
end

local effects = data.raw.technology["planetaris-compression"].effects
assert(#effects == 1, "planetaris-compression should gain exactly one effect")
assert(effects[1].type == "unlock-recipe", "effect type should be unlock-recipe")
assert(effects[1].recipe == "arig-pure-sand-kr-sand", "effect should unlock arig-pure-sand-kr-sand")

for _, tech in ipairs({ "planetaris-glass", "kr-advanced-chemistry", "planetaris-polishing" }) do
  assert(#data.raw.technology[tech].effects == 0, tech .. " should gain no effects")
end
