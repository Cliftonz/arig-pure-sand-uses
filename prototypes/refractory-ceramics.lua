if not mods["planetaris-hyarion"] then return end

data:extend({
  {
    type = "recipe",
    name = "arig-pure-sand-refractory-ceramics",
    category = "compressing",
    energy_required = 3,
    enabled = false,
    auto_recycle = false,
    allow_productivity = true,
    ingredients = {
      { type = "fluid", name = "planetaris-pure-sand", amount = 1000 },
      { type = "fluid", name = "planetaris-aluminium", amount = 10 },
      { type = "item", name = "planetaris-beryllium-nitride", amount = 3 },
      { type = "item", name = "planetaris-silica", amount = 20 },
    },
    results = { { type = "item", name = "planetaris-refractory-ceramics", amount = 1 } },
  },
})

table.insert(data.raw.technology["planetaris-space-facilities-1"].effects,
  { type = "unlock-recipe", recipe = "arig-pure-sand-refractory-ceramics" })
