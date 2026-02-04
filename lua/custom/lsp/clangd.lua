vim.lsp.config['clangd'] = {
  cmd = { 'clangd' },

  -- attach clangd only to C/C++ files
  filetypes = { 'c', 'cpp', 'cxx', 'cc' },

  -- set fallback flags depending on language
  on_new_config = function(new_config, root_dir, client)
    if client.config.filetypes then
      for _, ft in ipairs(client.config.filetypes) do
        if ft == 'c' then
          new_config.init_options = { fallbackFlags = { '-std=c99' } }
        else
          new_config.init_options = { fallbackFlags = { '-std=c++23' } }
        end
      end
    end
  end,
}

vim.lsp.enable 'clangd'

-- local lspconfig = require 'lspconfig'
--
-- -- C++
-- lspconfig.clangd.setup {
--   cmd = { 'clangd' },
--   filetypes = { 'cpp', 'cxx', 'cc' },
--   init_options = {
--     fallbackFlags = { '-std=c++23' },
--   },
-- }
--
-- -- C
-- lspconfig.clangd.setup {
--   cmd = { 'clangd' },
--   filetypes = { 'c' },
--   init_options = {
--     fallbackFlags = { '-std=c99' },
--   },
-- }
--
--
--
--// original version
--
-- vim.lsp.config['clangd'] = {
--   cmd = { 'clangd' },
--
--   on_new_config = function(new_config, root_dir)
--     local bufnr = vim.api.nvim_get_current_buf()
--     local bufname = vim.api.nvim_buf_get_name(bufnr)
--
--     if bufname:match '%.c$' then
--       new_config.init_options = { fallbackFlags = { '-std=c99' } }
--     elseif bufname:match '%.cpp$' or bufname:match '%.cc$' or bufname:match '%.cxx$' then
--       new_config.init_options = {
--         fallbackFlags = { '-std=c++23' },
--       }
--     end
--   end,
-- }
--
-- vim.lsp.enable 'clangd'
