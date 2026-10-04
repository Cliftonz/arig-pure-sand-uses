data:extend({
  {
    type = "recipe",
    name = "arig-pure-sand-stone",
    category = "compressing",
    energy_required = 1,
    enabled = false,
    auto_recycle = false,
    allow_productivity = true,
    ingredients = { { type = "fluid", name = "planetaris-pure-sand", amount = 20 } },
    results = { { type = "item", name = "stone", amount = 1 } },
  },
})

table.insert(
  data.raw.technology["planetaris-compression"].effects,
  { type = "unlock-recipe", recipe = "arig-pure-sand-stone" }
)
