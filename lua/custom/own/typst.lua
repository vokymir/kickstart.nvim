-- Get Git root directory
local function git_root()
  local git_dir = vim.fn.finddir('.git', ';')
  if git_dir == '' then
    return nil
  end
  return vim.fn.fnamemodify(git_dir, ':h')
end

-- Compile Typst document on write
local function typst_watch()
  vim.cmd 'vsp' -- vertical split
  vim.cmd 'vertical resize 24' -- resize split
  local cmd = string.format('terminal typst watch --root %s %s', git_root(), vim.fn.expand '%:')
  vim.cmd(cmd) -- open terminal and run typst watch
  vim.cmd 'wincmd h' -- move cursor to left window
end

-- Key mappings
vim.keymap.set('n', '<leader>tw', typst_watch, { silent = true })

vim.keymap.set('n', '<leader>tp', function()
  local pdf = vim.fn.expand '%:p:r' .. '.pdf'
  vim.cmd('silent !zathura --fork ' .. pdf)
end, { silent = true })
