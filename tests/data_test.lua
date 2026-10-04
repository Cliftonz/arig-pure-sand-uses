local harness = require("tests.harness")

local always = {
  "arig-pure-sand-stone",
  "arig-pure-sand-concrete",
  "arig-pure-sand-landfill",
}

local optional = {
  "arig-pure-sand-kr-sand",
  "arig-pure-sand-dirty-water-filtration",
  "arig-pure-sand-igrys-glass",
  "arig-pure-sand-polishing-compound",
}

harness.stage({ Krastorio2 = "2.0.0", Igrys = "1.0.0", ["planetaris-hyarion"] = "1.0.0" })
harness.load("data")
for _, name in ipairs(always) do
  assert(data.raw.recipe[name], name .. " should exist with all optional mods present")
end
for _, name in ipairs(optional) do
  assert(data.raw.recipe[name], name .. " should exist with all optional mods present")
end

harness.stage({})
harness.load("data")
for _, name in ipairs(always) do
  assert(data.raw.recipe[name], name .. " should exist with no optional mods present")
end
for _, name in ipairs(optional) do
  assert(data.raw.recipe[name] == nil, name .. " should not exist with no optional mods present")
end
