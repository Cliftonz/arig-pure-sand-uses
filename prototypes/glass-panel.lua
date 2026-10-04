data:extend({
  {
    type = "recipe",
    name = "arig-pure-sand-glass-panel",
    category = "compressing",
    energy_required = 3,
    enabled = false,
    auto_recycle = false,
    allow_productivity = true,
    ingredients = {
      { type = "fluid", name = "planetaris-pure-sand", amount = 150 },
    },
    results = { { type = "item", name = "planetaris-glass-panel", amount = 5 } },
  },
})

table.insert(data.raw.technology["planetaris-glass"].effects,
  { type = "unlock-recipe", recipe = "arig-pure-sand-glass-panel" })
