if not mods["Igrys"] then return end

data:extend({
  {
    type = "recipe",
    name = "arig-pure-sand-igrys-glass",
    category = "crafting-with-fluid",
    energy_required = 2,
    enabled = false,
    auto_recycle = false,
    allow_productivity = true,
    ingredients = {
      { type = "fluid", name = "planetaris-pure-sand", amount = 20 },
      { type = "item", name = "stone", amount = 5 },
    },
    results = {
      { type = "item", name = "igrys-glass", amount = 1 },
    },
  },
})

table.insert(
  data.raw.technology["planetaris-glass"].effects,
  { type = "unlock-recipe", recipe = "arig-pure-sand-igrys-glass" }
)
