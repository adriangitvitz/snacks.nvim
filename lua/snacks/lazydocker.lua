---@class snacks.lazydocker
---@overload fun(opts?: snacks.lazydocker.Config): snacks.win
local M = setmetatable({}, {
  __call = function(t, ...)
    return t.open(...)
  end,
})

M.meta = {
  desc = "Open LazyDocker in a float",
}

---@class snacks.lazydocker.Config: snacks.terminal.Opts
---@field args? string[] # extra CLI args to pass to lazydocker

--- Default config for LazyDocker
local defaults = {
  -- see snacks.terminal.Opts for possible window sizing/styling
  win = {
    style = "float", -- or "lazydocker" if you prefer the same naming
  },
}

--- Opens lazydocker in a floating window
---@param opts? snacks.lazydocker.Config
function M.open(opts)
  opts = Snacks.config.get("lazydocker", defaults, opts)
  local cmd = { "lazydocker" }
  if opts.args then
    vim.list_extend(cmd, opts.args)
  end
  return Snacks.terminal(cmd, opts)
end

--- Example function: opens lazydocker with a different set of arguments
---@param opts? snacks.lazydocker.Config
function M.some_custom_command(opts)
  opts = opts or {}
  -- opts.args = { "--some-arg" } -- replace with real lazydocker flags
  return M.open(opts)
end

---@private
function M.health()
  local ok = vim.fn.executable("lazydocker") == 1
  Snacks.health[ok and "ok" or "error"](("{lazydocker} %sinstalled"):format(ok and "" or "not "))
end

return M
