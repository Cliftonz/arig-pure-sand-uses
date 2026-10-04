local harness = require("tests.harness")

for _, present_mods in ipairs({ {}, { Krastorio2 = "2.0.0" } }) do
  harness.stage(present_mods)
  harness.load("prototypes.landfill")

  local recipe = data.raw.recipe["arig-pure-sand-landfill"]
  assert(recipe.type == "recipe", "landfill recipe should have type recipe")
  assert(recipe.name == "arig-pure-sand-landfill", "landfill recipe should carry its own name")
  assert(recipe.category == "compressing", "landfill recipe should be crafted by compressing")
  assert(recipe.energy_required == 0.5, "landfill recipe should take 0.5 seconds")
  assert(recipe.enabled == false, "landfill recipe should start locked")
  assert(recipe.auto_recycle == false, "landfill recipe should not be auto recycled")
  assert(recipe.allow_productivity == true, "landfill recipe should allow productivity")

  assert(#recipe.ingredients == 1, "landfill recipe should have exactly one ingredient")
  assert(recipe.ingredients[1].type == "fluid", "landfill ingredient should be a fluid")
  assert(recipe.ingredients[1].name == "planetaris-pure-sand", "landfill ingredient should be pure sand")
  assert(recipe.ingredients[1].amount == 400, "landfill recipe should consume 400 pure sand")

  assert(#recipe.results == 1, "landfill recipe should have exactly one result")
  assert(recipe.results[1].type == "item", "landfill result should be an item")
  assert(recipe.results[1].name == "landfill", "landfill result should be landfill")
  assert(recipe.results[1].amount == 1, "landfill recipe should produce 1 landfill")

  local effects = data.raw.technology["planetaris-compression"].effects
  assert(#effects == 1, "compression technology should gain exactly one effect")
  assert(effects[1].type == "unlock-recipe", "compression effect should unlock a recipe")
  assert(effects[1].recipe == "arig-pure-sand-landfill", "compression effect should unlock the landfill recipe")
end
