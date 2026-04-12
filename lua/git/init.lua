require("gitsigns").setup({
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 500,
    virt_text_pos = "eol",
  },
})

vim.keymap.set("n", "<leader>gl", "<CMD>LazyGit<CR>", { desc = "LazyGit" })

vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", {
  desc = "Toggle git blame",
})
