if not mods["Krastorio2"] then return end

data:extend({
  {
    type = "recipe",
    name = "arig-pure-sand-kr-sand",
    category = "compressing",
    energy_required = 2,
    enabled = false,
    auto_recycle = false,
    allow_productivity = true,
    ingredients = { { type = "fluid", name = "planetaris-pure-sand", amount = 50 } },
    results = { { type = "item", name = "kr-sand", amount = 5 } },
  },
})

table.insert(
  data.raw.technology["planetaris-compression"].effects,
  { type = "unlock-recipe", recipe = "arig-pure-sand-kr-sand" }
)
