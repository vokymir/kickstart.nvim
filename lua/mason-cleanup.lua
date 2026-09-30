local M = {}
local desired = {}

--- Register Mason package names (not lspconfig/dap-adapter names) as wanted.
--- Any domain (lsp, dap, ...) calls this after declaring what it installs.
function M.want(names)
	for _, name in ipairs(names) do
		desired[name] = true
	end
end

--- Uninstall anything installed that no domain has claimed via want().
--- Call once, after every domain has registered.
function M.run()
	local registry = require("mason-registry")
	local removed = {}

	for _, pkg in ipairs(registry.get_installed_packages()) do
		if not desired[pkg.name] then
			table.insert(removed, pkg.name)
			pkg:uninstall()
		end
	end

	if #removed == 0 then
		return
	end

	vim.notify(
		"Mason: removed packages no longer in config: " .. table.concat(removed, ", "),
		vim.log.levels.WARN,
		{ title = "mason-cleanup" }
	)

	local log_path = vim.fn.stdpath("config") .. "/mason-removed.log"
	local existing = vim.fn.filereadable(log_path) == 1 and vim.fn.readfile(log_path) or {}
	table.insert(existing, string.format("[%s] %s", os.date("%Y-%m-%d %H:%M:%S"), table.concat(removed, ", ")))
	vim.fn.writefile(existing, log_path)
end

return M
