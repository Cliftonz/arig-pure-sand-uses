if not mods["Krastorio2"] then return end

data:extend({
  {
    type = "recipe",
    name = "arig-pure-sand-kr-glass",
    category = "compressing",
    energy_required = 2,
    enabled = false,
    auto_recycle = false,
    allow_productivity = true,
    ingredients = {
      { type = "fluid", name = "planetaris-pure-sand", amount = 20 },
    },
    results = {
      { type = "item", name = "kr-glass", amount = 1 },
    },
  },
})

table.insert(
  data.raw.technology["planetaris-glass"].effects,
  { type = "unlock-recipe", recipe = "arig-pure-sand-kr-glass" }
)
