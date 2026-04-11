require("mason").setup()
local registry = require("mason-registry")

-- prepare
local languages = vim.fn.readdir(
  vim.fn.stdpath("config") .. "/lua/lsp/languages"
)

for _, name in ipairs(languages) do
  local modname = name:gsub("%.lua$", "")
  local lang = require("lsp.languages." .. modname)

  -- install via Mason
  if lang.mason then
    local ok, pkg = pcall(registry.get_package, lang.mason)
    if ok and not pkg:is_installed() then
      pkg:install()
    end
  end

  local config = lang.config or {}

  vim.lsp.config(lang.lsp, config)
  vim.lsp.enable(lang.lsp)
end

require("lsp.diagnostics")
require("lsp.keymaps")
