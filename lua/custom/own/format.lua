vim.api.nvim_create_autocmd('FileType', {
  pattern = 'typst',
  callback = function()
    vim.opt_local.textwidth = 80
    -- 't' stands for "auto-wrap text using textwidth"
    -- 'q' allows formatting comments with "gq"
    -- 'n' recognizes numbered lists
    vim.opt_local.formatoptions:append 'tqn'
  end,
})
