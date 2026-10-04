local harness = require("tests.harness")

harness.stage({})
harness.load("prototypes.dirty-water-sand-filter")
assert(
  data.raw.recipe["arig-pure-sand-dirty-water-filtration"] == nil,
  "without Krastorio2 there should be no dirty water filtration recipe"
)
assert(
  #data.raw.technology["kr-advanced-chemistry"].effects == 0,
  "without Krastorio2 kr-advanced-chemistry should gain no effects"
)

harness.stage({ Krastorio2 = "2.0.19" })
harness.load("prototypes.dirty-water-sand-filter")

local recipe = data.raw.recipe["arig-pure-sand-dirty-water-filtration"]
assert(recipe ~= nil, "with Krastorio2 the dirty water filtration recipe should exist")
assert(recipe.type == "recipe", "type should be recipe")
assert(recipe.name == "arig-pure-sand-dirty-water-filtration", "name should match its key")
assert(recipe.category == "kr-fluid-filtration", "category should be kr-fluid-filtration")
assert(recipe.subgroup == "raw-material", "subgroup should be raw-material")
assert(recipe.energy_required == 2, "energy_required should be 2")
assert(recipe.enabled == false, "recipe should start disabled")
assert(recipe.auto_recycle == false, "recipe should not auto recycle")
assert(recipe.allow_productivity == true, "recipe should allow productivity")

assert(#recipe.icons == 2, "recipe should have two icon layers")
assert(
  recipe.icons[1].icon == "__Krastorio2Assets__/icons/fluids/dirty-water.png",
  "first icon layer should be dirty water"
)
assert(recipe.icons[1].scale == nil, "dirty water layer should have no scale")
assert(recipe.icons[1].shift == nil, "dirty water layer should have no shift")
assert(
  recipe.icons[2].icon == "__planetaris-arig__/graphics/icons/fluid/pure-sand.png",
  "second icon layer should be pure sand"
)
assert(recipe.icons[2].scale == 0.25, "pure sand layer should be scaled to 0.25")
assert(#recipe.icons[2].shift == 2, "pure sand layer shift should have two coordinates")
assert(recipe.icons[2].shift[1] == 8, "pure sand layer should shift 8 on x")
assert(recipe.icons[2].shift[2] == 8, "pure sand layer should shift 8 on y")

assert(#recipe.ingredients == 2, "recipe should have two ingredients")
assert(recipe.ingredients[1].type == "fluid", "first ingredient should be a fluid")
assert(recipe.ingredients[1].name == "kr-dirty-water", "first ingredient should be dirty water")
assert(recipe.ingredients[1].amount == 100, "recipe should consume 100 dirty water")
assert(recipe.ingredients[2].type == "item", "second ingredient should be an item")
assert(
  recipe.ingredients[2].name == "planetaris-pure-sand-barrel",
  "second ingredient should be the pure sand barrel"
)
assert(recipe.ingredients[2].amount == 1, "recipe should consume 1 pure sand barrel")

assert(#recipe.results == 3, "recipe should have three results")
assert(recipe.results[1].type == "fluid", "first result should be a fluid")
assert(recipe.results[1].name == "water", "first result should be water")
assert(recipe.results[1].amount == 100, "recipe should produce 100 water")
assert(recipe.results[2].type == "item", "second result should be an item")
assert(recipe.results[2].name == "stone", "second result should be stone")
assert(recipe.results[2].amount == 1, "recipe should produce 1 stone")
assert(recipe.results[2].ignored_by_stats == nil, "stone should count in stats")
assert(recipe.results[2].ignored_by_productivity == nil, "stone should gain productivity")
assert(recipe.results[3].type == "item", "third result should be an item")
assert(recipe.results[3].name == "barrel", "third result should be the empty barrel")
assert(recipe.results[3].amount == 1, "recipe should return 1 barrel")
assert(recipe.results[3].ignored_by_stats == 1, "returned barrel should be ignored by stats")
assert(
  recipe.results[3].ignored_by_productivity == 1,
  "returned barrel should be ignored by productivity"
)

local effects = data.raw.technology["kr-advanced-chemistry"].effects
assert(#effects == 1, "kr-advanced-chemistry should gain exactly one effect")
assert(effects[1].type == "unlock-recipe", "the effect should unlock a recipe")
assert(
  effects[1].recipe == "arig-pure-sand-dirty-water-filtration",
  "the effect should unlock the dirty water filtration recipe"
)
