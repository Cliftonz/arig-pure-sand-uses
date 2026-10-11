if not mods["Krastorio2"] then return end

local roboport = table.deepcopy(data.raw.roboport["kr-small-roboport"])
roboport.name = "arig-kr-small-roboport"
roboport.minable.result = "arig-kr-small-roboport"
roboport.icon = nil
roboport.icons = {
  {
    icon = "__Krastorio2Assets__/icons/entities/small-roboport.png",
    tint = { 0.871, 0.788, 0.627 },
  },
}
roboport.logistics_radius = 14
roboport.construction_radius = 31
roboport.energy_source.buffer_capacity = "240MJ"
roboport.energy_source.input_flow_limit = "19.2MW"
roboport.surface_conditions = {
  { property = "planetaris-dust-concentration", min = 50, max = 100 },
}

local item = table.deepcopy(data.raw.item["kr-small-roboport"])
item.name = "arig-kr-small-roboport"
item.place_result = "arig-kr-small-roboport"
item.icon = nil
item.icons = {
  {
    icon = "__Krastorio2Assets__/icons/entities/small-roboport.png",
    tint = { 0.871, 0.788, 0.627 },
  },
}
item.order = "c[signal]-b[small-roboport]-arig"

data:extend({
  roboport,
  item,
  {
    type = "recipe",
    name = "arig-kr-small-roboport",
    energy_required = 5,
    enabled = false,
    ingredients = {
      { type = "item", name = "steel-plate", amount = 10 },
      { type = "item", name = "planetaris-heavy-glass", amount = 4 },
      { type = "item", name = "kr-rare-metals", amount = 20 },
      { type = "item", name = "kr-electronic-components", amount = 5 },
    },
    results = {
      { type = "item", name = "arig-kr-small-roboport", amount = 2 },
    },
  },
})

table.insert(
  data.raw.technology["planetaris-arig-roboport"].effects,
  { type = "unlock-recipe", recipe = "arig-kr-small-roboport" }
)
