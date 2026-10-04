local harness = require("tests.harness")

harness.stage({})
harness.load("prototypes.polishing-compound")
assert(
  data.raw.recipe["arig-pure-sand-polishing-compound"] == nil,
  "recipe should not exist without planetaris-hyarion"
)
assert(
  #data.raw.technology["planetaris-polishing"].effects == 0,
  "planetaris-polishing should gain no effects without planetaris-hyarion"
)

harness.stage({ ["planetaris-hyarion"] = "1.3.22" })
harness.load("prototypes.polishing-compound")

local recipe = data.raw.recipe["arig-pure-sand-polishing-compound"]
assert(recipe ~= nil, "recipe should exist with planetaris-hyarion")
assert(recipe.type == "recipe", "type should be recipe")
assert(recipe.name == "arig-pure-sand-polishing-compound", "name should match its key")
assert(recipe.category == "polishing", "category should be polishing")
assert(recipe.energy_required == 10, "energy_required should be 10")
assert(recipe.enabled == false, "enabled should be false")
assert(recipe.auto_recycle == false, "auto_recycle should be false")
assert(recipe.allow_productivity == true, "allow_productivity should be true")

local field_count = 0
for _ in pairs(recipe) do
  field_count = field_count + 1
end
assert(field_count == 9, "recipe should hold exactly the nine specified fields, got " .. field_count)

assert(#recipe.ingredients == 2, "recipe should have exactly two ingredients")
assert(recipe.ingredients[1].type == "fluid", "first ingredient should be a fluid")
assert(recipe.ingredients[1].name == "planetaris-pure-sand", "first ingredient should be pure sand")
assert(recipe.ingredients[1].amount == 50, "pure sand amount should be 50")
assert(recipe.ingredients[2].type == "item", "second ingredient should be an item")
assert(recipe.ingredients[2].name == "iron-ore", "second ingredient should be iron ore")
assert(recipe.ingredients[2].amount == 10, "iron ore amount should be 10")

assert(#recipe.results == 1, "recipe should have exactly one result")
assert(recipe.results[1].type == "fluid", "result should be a fluid")
assert(recipe.results[1].name == "planetaris-polishing-compound", "result should be polishing compound")
assert(recipe.results[1].amount == 50, "polishing compound amount should be 50")

local effects = data.raw.technology["planetaris-polishing"].effects
assert(#effects == 1, "planetaris-polishing should gain exactly one effect")
assert(effects[1].type == "unlock-recipe", "effect should unlock a recipe")
assert(effects[1].recipe == "arig-pure-sand-polishing-compound", "effect should unlock the new recipe")
