data:extend({
  {
    type = "recipe",
    name = "arig-pure-sand-concrete",
    category = "compressing",
    energy_required = 10,
    enabled = false,
    auto_recycle = false,
    allow_productivity = true,
    ingredients = {
      { type = "fluid", name = "planetaris-pure-sand", amount = 100 },
      { type = "item", name = "iron-ore", amount = 1 },
      { type = "fluid", name = "water", amount = 50 },
    },
    results = {
      { type = "item", name = "concrete", amount = 10 },
    },
  },
})

table.insert(
  data.raw.technology["planetaris-compression"].effects,
  { type = "unlock-recipe", recipe = "arig-pure-sand-concrete" }
)
