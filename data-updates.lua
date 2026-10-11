if not mods["Krastorio2"] then return end

for _, name in ipairs({ "kr-big-roboport", "kr-small-roboport" }) do
  local roboport = data.raw.roboport[name]
  roboport.surface_conditions = roboport.surface_conditions or {}
  table.insert(roboport.surface_conditions, { property = "planetaris-dust-concentration", max = 50 })
end
