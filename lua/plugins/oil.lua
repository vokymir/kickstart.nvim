require("oil").setup({
	view_options = {
		show_hidden = false,
	},
	is_hidden_file = function(name, bufnr)
		local m = name:match("^%.")
		return m ~= nil
	end,
})

vim.keymap.set("n", "<leader><leader>", "<CMD>Oil<CR>", {
	desc = "Open Oil",
	silent = true,
})
