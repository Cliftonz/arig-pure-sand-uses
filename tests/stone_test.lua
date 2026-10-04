local harness = require("tests.harness")

for _, present_mods in ipairs({ {}, { Krastorio2 = "2.0.0" } }) do
  harness.stage(present_mods)
  harness.load("prototypes.stone")

  local recipe = data.raw.recipe["arig-pure-sand-stone"]
  assert(recipe.type == "recipe", "stone recipe should be a recipe prototype")
  assert(recipe.name == "arig-pure-sand-stone", "stone recipe should carry its own name")
  assert(recipe.category == "compressing", "stone recipe should be crafted by compressing")
  assert(recipe.energy_required == 1, "stone recipe should take 1 second")
  assert(recipe.enabled == false, "stone recipe should start locked")
  assert(recipe.auto_recycle == false, "stone recipe should not generate a recycling recipe")
  assert(recipe.allow_productivity == true, "stone recipe should allow productivity")

  assert(#recipe.ingredients == 1, "stone recipe should have exactly one ingredient")
  assert(recipe.ingredients[1].type == "fluid", "stone ingredient should be a fluid")
  assert(recipe.ingredients[1].name == "planetaris-pure-sand", "stone ingredient should be pure sand")
  assert(recipe.ingredients[1].amount == 20, "stone recipe should consume 20 pure sand")

  assert(#recipe.results == 1, "stone recipe should have exactly one result")
  assert(recipe.results[1].type == "item", "stone result should be an item")
  assert(recipe.results[1].name == "stone", "stone result should be stone")
  assert(recipe.results[1].amount == 1, "stone recipe should produce 1 stone")

  local effects = data.raw.technology["planetaris-compression"].effects
  assert(#effects == 1, "compression technology should gain exactly one effect")
  assert(effects[1].type == "unlock-recipe", "compression effect should unlock a recipe")
  assert(effects[1].recipe == "arig-pure-sand-stone", "compression effect should unlock the stone recipe")
end
