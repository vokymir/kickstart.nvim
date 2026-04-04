local typst = require 'custom.own.typst'

vim.keymap.set('n', '<leader>tw', typst.watch, { desc = '[t]ypst [w]atch' })
vim.keymap.set('n', '<leader>tl', typst.enforce_layout, { desc = '[t]ypst fix [l]ayout' })
vim.keymap.set('n', '<leader>tp', typst.preview, { desc = '[t]ypst [p]review PDF' })
