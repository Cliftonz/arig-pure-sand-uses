local harness = require("tests.harness")

harness.stage({})
harness.load("prototypes.concrete")

local recipe = data.raw.recipe["arig-pure-sand-concrete"]
assert(recipe ~= nil, "arig-pure-sand-concrete should exist with no optional mods present")
assert(recipe.type == "recipe", "type should be recipe")
assert(recipe.name == "arig-pure-sand-concrete", "name should be arig-pure-sand-concrete")
assert(recipe.category == "compressing", "category should be compressing")
assert(recipe.energy_required == 10, "energy_required should be 10")
assert(recipe.enabled == false, "enabled should be false")
assert(recipe.auto_recycle == false, "auto_recycle should be false")
assert(recipe.allow_productivity == true, "allow_productivity should be true")

local expected_ingredients = {
  { type = "fluid", name = "planetaris-pure-sand", amount = 100 },
  { type = "item", name = "iron-ore", amount = 1 },
  { type = "fluid", name = "water", amount = 50 },
}
assert(#recipe.ingredients == #expected_ingredients, "should have exactly three ingredients")
for position, expected in ipairs(expected_ingredients) do
  local ingredient = recipe.ingredients[position]
  assert(ingredient.type == expected.type, "ingredient " .. position .. " type should be " .. expected.type)
  assert(ingredient.name == expected.name, "ingredient " .. position .. " name should be " .. expected.name)
  assert(ingredient.amount == expected.amount, "ingredient " .. position .. " amount should be " .. expected.amount)
end

assert(#recipe.results == 1, "should have exactly one result")
assert(recipe.results[1].type == "item", "result type should be item")
assert(recipe.results[1].name == "concrete", "result name should be concrete")
assert(recipe.results[1].amount == 10, "result amount should be 10")

local field_count = 0
for _ in pairs(recipe) do
  field_count = field_count + 1
end
assert(field_count == 9, "recipe should carry only the nine specified fields, found " .. field_count)

local effects = data.raw.technology["planetaris-compression"].effects
assert(#effects == 1, "planetaris-compression should gain exactly one effect")
assert(effects[1].type == "unlock-recipe", "effect type should be unlock-recipe")
assert(effects[1].recipe == "arig-pure-sand-concrete", "effect should unlock arig-pure-sand-concrete")

harness.stage({ Krastorio2 = "2.0.0" })
harness.load("prototypes.concrete")
assert(
  data.raw.recipe["arig-pure-sand-concrete"] ~= nil,
  "arig-pure-sand-concrete should exist when other mods are present"
)
