if not mods["planetaris-hyarion"] then return end

data:extend({
  {
    type = "recipe",
    name = "arig-pure-sand-polishing-compound",
    category = "polishing",
    energy_required = 10,
    enabled = false,
    auto_recycle = false,
    allow_productivity = true,
    ingredients = {
      { type = "fluid", name = "planetaris-pure-sand", amount = 50 },
      { type = "item", name = "iron-ore", amount = 10 },
    },
    results = {
      { type = "fluid", name = "planetaris-polishing-compound", amount = 50 },
    },
  },
})

table.insert(
  data.raw.technology["planetaris-polishing"].effects,
  { type = "unlock-recipe", recipe = "arig-pure-sand-polishing-compound" }
)
