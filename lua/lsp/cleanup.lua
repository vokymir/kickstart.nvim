local M = {}

--- servers: { [lspconfig_name] = mason_package_name }
--- tools:   { mason_package_name, ... }
function M.clean(servers, tools)
	local registry = require("mason-registry")

	local desired = {}
	for _, mason_name in pairs(servers) do
		desired[mason_name] = true
	end
	for _, name in ipairs(tools) do
		desired[name] = true
	end

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
