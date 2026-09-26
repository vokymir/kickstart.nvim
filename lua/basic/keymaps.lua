vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete buffer (not only close)" })

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- WINDOW NAVIGATION
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- MOVE SELECTED LINES UP/DOWN
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- KEEP SELECTION AFTER INDENTING
vim.keymap.set("v", "<", "<gv", { desc = "Indent left, keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right, keep selection" })

-- BUFFER NAVIGATION (matches your [d/]d diagnostic style)
vim.keymap.set("n", "]b", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", ":bprevious<CR>", { desc = "Previous buffer" })

-- PASTE WITHOUT OVERWRITING THE UNNAMED REGISTER
vim.keymap.set("v", "<leader>p", '"_dP', { desc = "[p]aste without yanking replaced text" })
