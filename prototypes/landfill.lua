data:extend({
  {
    type = "recipe",
    name = "arig-pure-sand-landfill",
    category = "compressing",
    energy_required = 0.5,
    enabled = false,
    auto_recycle = false,
    allow_productivity = true,
    ingredients = { { type = "fluid", name = "planetaris-pure-sand", amount = 400 } },
    results = { { type = "item", name = "landfill", amount = 1 } },
  },
})

table.insert(
  data.raw.technology["planetaris-compression"].effects,
  { type = "unlock-recipe", recipe = "arig-pure-sand-landfill" }
)
