vim.diagnostic.config({
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

local map_n = function(lhs, rhs, desc)
  map("n", lhs, rhs, desc)
end

map_n("<leader>ql", vim.diagnostic.setloclist, "Diagnostics list")
map_n("[d", vim.diagnostic.get_prev, "Prev diagnostic")
map_n("]d", vim.diagnostic.get_next, "Next diagnostic")

map_n("qf", vim.diagnostic.open_float, "Diagnostics floating window")
