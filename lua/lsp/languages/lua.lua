return {
  lsp = "lua_ls",
  mason = "lua-language-server",

  config = {
    filetypes = { "lua" },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
        },
    },
  }
}
