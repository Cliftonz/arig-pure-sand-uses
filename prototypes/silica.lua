data:extend({
  {
    type = "recipe",
    name = "arig-pure-sand-silica",
    category = "compressing",
    energy_required = 6,
    enabled = false,
    auto_recycle = false,
    allow_productivity = true,
    ingredients = {
      { type = "fluid", name = "planetaris-pure-sand", amount = 400 },
      { type = "fluid", name = "sulfuric-acid", amount = 20 },
      { type = "item", name = "calcite", amount = 1 },
    },
    results = { { type = "item", name = "planetaris-silica", amount = 1 } },
  },
})

table.insert(data.raw.technology["planetaris-silica-processing"].effects,
  { type = "unlock-recipe", recipe = "arig-pure-sand-silica" })
