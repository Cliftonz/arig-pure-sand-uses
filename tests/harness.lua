local harness = {}

local builtin = {}
for name in pairs(package.loaded) do
  builtin[name] = true
end

function harness.stage(present_mods)
  mods = present_mods
  data = {
    raw = {
      recipe = {},
      technology = {
        ["planetaris-compression"] = { effects = {} },
        ["planetaris-silica-processing"] = { effects = {} },
        ["planetaris-space-facilities-1"] = { effects = {} },
        ["planetaris-glass"] = { effects = {} },
        ["kr-advanced-chemistry"] = { effects = {} },
        ["planetaris-polishing"] = { effects = {} },
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
