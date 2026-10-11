if not mods["Krastorio2"] then return end

local roboport = table.deepcopy(data.raw.roboport["kr-big-roboport"])
roboport.name = "arig-kr-big-roboport"
roboport.minable.result = "arig-kr-big-roboport"
roboport.icon = nil
roboport.icons = {
  {
    icon = "__Krastorio2Assets__/icons/entities/big-roboport.png",
    tint = { 0.871, 0.788, 0.627 },
  },
}
roboport.logistics_radius = 80
roboport.construction_radius = 182
roboport.energy_source.buffer_capacity = "800MJ"
roboport.energy_source.input_flow_limit = "80MW"
roboport.surface_conditions = {
  { property = "planetaris-dust-concentration", min = 50, max = 100 },
}

local item = table.deepcopy(data.raw.item["kr-big-roboport"])
item.name = "arig-kr-big-roboport"
item.place_result = "arig-kr-big-roboport"
item.icon = nil
item.icons = {
  {
    icon = "__Krastorio2Assets__/icons/entities/big-roboport.png",
    tint = { 0.871, 0.788, 0.627 },
  },
}
item.order = "c[signal]-c[big-roboport]-arig"

data:extend({
  roboport,
  item,
  {
    type = "recipe",
    name = "arig-kr-big-roboport",
    energy_required = 30,
    enabled = false,
    ingredients = {
      { type = "item", name = "steel-plate", amount = 20 },
      { type = "item", name = "planetaris-heavy-glass", amount = 50 },
      { type = "item", name = "kr-rare-metals", amount = 80 },
      { type = "item", name = "planetaris-arig-roboport", amount = 1 },
    },
    results = {
      { type = "item", name = "arig-kr-big-roboport", amount = 1 },
    },
  },
})

table.insert(
  data.raw.technology["planetaris-arig-roboport"].effects,
  { type = "unlock-recipe", recipe = "arig-kr-big-roboport" }
)
