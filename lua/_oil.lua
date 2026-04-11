require("oil").setup()

vim.keymap.set("n", "<leader><leader>", "<CMD>Oil<CR>", {
  desc = "Open Oil",
  silent = true,
})
