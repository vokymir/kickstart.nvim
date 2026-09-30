local adapters = {
	codelldb = "codelldb",
	netcoredbg = "netcoredbg",
}

require("mason-nvim-dap").setup({
	ensure_installed = vim.tbl_keys(adapters),
	handlers = {
		function(config)
			require("mason-nvim-dap").default_setup(config)
		end,
	},
})

require("mason-cleanup").want(vim.tbl_values(adapters))

local lang_dir = vim.fn.stdpath("config") .. "/lua/dap_my/languages"
for _, name in ipairs(vim.fn.readdir(lang_dir)) do
	local modname = name:gsub("%.lua$", "")
	local lang = require("dap_my.languages." .. modname)
	if lang.setup then
		lang.setup()
	end
end

require("dap_my.keymaps")

local ok, dapui = pcall(require, "dapui")
if ok then
	dapui.setup()

	local dap = require("dap")
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end

	vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "[d]ap: toggle [u]i" })
end
