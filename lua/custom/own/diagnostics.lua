-- Duper Diagnostics: show all diagnostics in a bottom split quickfix
vim.keymap.set('n', '<leader>dd', function()
  -- Populate the quickfix list with diagnostics from all buffers
  vim.diagnostic.setqflist { open = true, all_buffers = true }
  -- Move the quickfix window to the bottom
  vim.cmd 'botright copen'
end, { desc = '[D]uper [D]iagnostics: show all in bottom split' })
