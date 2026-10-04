if not mods["Krastorio2"] then return end

data:extend({
  {
    type = "recipe",
    name = "arig-pure-sand-dirty-water-filtration",
    category = "kr-fluid-filtration",
    subgroup = "raw-material",
    energy_required = 2,
    enabled = false,
    auto_recycle = false,
    allow_productivity = true,
    icons = {
      { icon = "__Krastorio2Assets__/icons/fluids/dirty-water.png" },
      {
        icon = "__planetaris-arig__/graphics/icons/fluid/pure-sand.png",
        scale = 0.25,
        shift = { 8, 8 },
      },
    },
    ingredients = {
      { type = "fluid", name = "kr-dirty-water", amount = 100 },
      { type = "item", name = "planetaris-pure-sand-barrel", amount = 1 },
    },
    results = {
      { type = "fluid", name = "water", amount = 100 },
      { type = "item", name = "stone", amount = 1 },
      {
        type = "item",
        name = "barrel",
        amount = 1,
        ignored_by_stats = 1,
        ignored_by_productivity = 1,
      },
    },
  },
})

table.insert(
  data.raw.technology["kr-advanced-chemistry"].effects,
  { type = "unlock-recipe", recipe = "arig-pure-sand-dirty-water-filtration" }
)
