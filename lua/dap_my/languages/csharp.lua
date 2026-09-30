return {
	setup = function()
		local dap = require("dap")

		dap.adapters.coreclr = {
			type = "executable",
			command = "netcoredbg",
			args = { "--interpreter=vscode" },
		}

		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "Launch .NET",
				request = "launch",

				program = function()
					local dll = vim.fn.input("Path to DLL: ", vim.fn.getcwd() .. "/bin/Debug/", "file")

					return dll
				end,

				cwd = "${workspaceFolder}",
			},
		}
	end,
}
