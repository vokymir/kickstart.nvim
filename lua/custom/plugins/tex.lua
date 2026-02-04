local M = {}

-- List of files for which diagnostics should be disabled
local disable_diagnostics_files = { 'doc.tex', '*.tex' }

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'FileType' }, {
  pattern = '*.tex',
  callback = function()
    local fname = vim.fn.expand '%:t'
    for _, f in ipairs(disable_diagnostics_files) do
      if fname == f then
        vim.diagnostic.enable(false)
        break
      end
    end
  end,
})

-- Autoformat on save without moving cursor
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = 'doc.tex',
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd 'normal! gggqG'
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

return M
