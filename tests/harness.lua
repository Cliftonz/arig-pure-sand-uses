local harness = {}

local builtin = {}
for name in pairs(package.loaded) do
  builtin[name] = true
end

function table.deepcopy(value)
  if type(value) ~= "table" then
    return value
  end
  local copy = {}
  for key, child in pairs(value) do
    copy[key] = table.deepcopy(child)
  end
  return copy
end

function harness.stage(present_mods)
  mods = present_mods
  data = {
    raw = {
      recipe = {},
      item = {},
      roboport = {},
      technology = {
        ["planetaris-compression"] = { effects = {} },
        ["planetaris-silica-processing"] = { effects = {} },
        ["planetaris-space-facilities-1"] = { effects = {} },
        ["planetaris-glass"] = { effects = {} },
        ["kr-advanced-chemistry"] = { effects = {} },
        ["planetaris-polishing"] = { effects = {} },
        ["planetaris-arig-roboport"] = { effects = {} },
      },
    },
  }
  function data:extend(prototypes)
    for _, prototype in ipairs(prototypes) do
      self.raw[prototype.type][prototype.name] = prototype
    end
  end
end

function harness.load(module)
  for name in pairs(package.loaded) do
    if not builtin[name] then
      package.loaded[name] = nil
    end
  end
  return require(module)
end

return harness
