local harness = require("tests.harness")

local always = {
  "arig-pure-sand-stone",
  "arig-pure-sand-concrete",
  "arig-pure-sand-landfill",
}

local optional = {
  "arig-pure-sand-kr-glass",
  "arig-pure-sand-kr-sand",
  "arig-pure-sand-dirty-water-filtration",
  "arig-pure-sand-igrys-glass",
  "arig-pure-sand-polishing-compound",
}

local roboports = {
  "arig-kr-big-roboport",
  "arig-kr-small-roboport",
}

harness.stage({ Krastorio2 = "2.0.0", Igrys = "1.0.0", ["planetaris-hyarion"] = "1.0.0" })
for _, name in ipairs({ "kr-big-roboport", "kr-small-roboport" }) do
  data.raw.roboport[name] = { type = "roboport", name = name, minable = {}, energy_source = {} }
  data.raw.item[name] = { type = "item", name = name }
end
harness.load("data")
for _, name in ipairs(always) do
  assert(data.raw.recipe[name], name .. " should exist with all optional mods present")
end
for _, name in ipairs(optional) do
  assert(data.raw.recipe[name], name .. " should exist with all optional mods present")
end
for _, name in ipairs(roboports) do
  for _, kind in ipairs({ "recipe", "item", "roboport" }) do
    assert(data.raw[kind][name], kind .. " " .. name .. " should exist with all optional mods present")
  end
end

harness.stage({})
harness.load("data")
for _, name in ipairs(always) do
  assert(data.raw.recipe[name], name .. " should exist with no optional mods present")
end
for _, name in ipairs(optional) do
  assert(data.raw.recipe[name] == nil, name .. " should not exist with no optional mods present")
end
for _, name in ipairs(roboports) do
  for _, kind in ipairs({ "recipe", "item", "roboport" }) do
    assert(data.raw[kind][name] == nil, kind .. " " .. name .. " should not exist with no optional mods present")
  end
end
