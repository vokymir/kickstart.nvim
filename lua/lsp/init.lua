-- lua/lsp/init.lua
--
-- lspconfig name -> Mason package name. Explicit and static on purpose:
-- mason-lspconfig's own name-mapping table is now sourced from registry
-- data that loads lazily, so resolving it synchronously right after
-- setup() is unreliable. Look up new names once at mason-registry.dev
-- and add them here.
local servers = {
  lua_ls = "lua-language-server",
  clangd = "clangd",
  marksman = "marksman",
  superhtml = "superhtml",
  tinymist = "tinymist",
  ols = "ols",
}
local tools = { "stylua" }

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = vim.tbl_keys(servers),
})

require("mason-tool-installer").setup({
  ensure_installed = vim.list_extend(vim.deepcopy(vim.tbl_values(servers)), tools),
})

require("lsp.cleanup").clean(servers, tools)

require("lsp.diagnostics")
require("lsp.keymaps")

--[[
-- local servers = { "clangd", "lua-language-server", "lua_ls", "marksman", "superhtml", "tinymist" }
local servers = { "clangd", "lua_ls", "marksman", "superhtml", "tinymist", "ols" }
local tools = { "stylua" }

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = servers,
  -- automatic_enable defaults to true: leave it, don't set false
})

require("mason-tool-installer").setup({
  ensure_installed = vim.list_extend(vim.deepcopy(servers), tools),
})

require("lsp.cleanup").clean(servers, tools)

require("lsp.diagnostics")
require("lsp.keymaps")

--]]

--[[
local servers = { "clangd", "lua_ls", "marksman", "superhtml", "tinymist" }

require("mason").setup()

require("mason-lspconfig").setup { ensure_installed = servers, automatic_enable = false }

require("mason-tool-installer").setup {
  ensure_installed = {
    "stylua"
  }
}

vim.lsp.enable(servers)

require("lsp.diagnostics")
require("lsp.keymaps")

--]]

--[[

require("mason").setup()

-- server names = every file in lsp/, minus extension
local servers = {}
for _, file in ipairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
  table.insert(servers, vim.fn.fnamemodify(file, ":t:r"))
end

require("mason-lspconfig").setup({
  ensure_installed = servers, -- installs missing servers, then vim.lsp.enable()s them
})

require("lsp.diagnostics")
require("lsp.keymaps")

--]]
