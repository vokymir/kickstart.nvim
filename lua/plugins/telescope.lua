require('plenary')
require('telescope')
local ts = require('telescope.builtin')

local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

local map_n = function(lhs, rhs, desc)
  map("n", lhs, rhs, desc)
end

map_n("<leader>fd", ts.lsp_definitions, "[f]ind [d]efinitions")
map_n("<leader>fr", ts.lsp_references, "[f]ind [r]eferences")
map_n("<leader>fi", ts.lsp_implementations, "[f]ind [i]mplementations")
map_n("<leader>ft", ts.lsp_type_definitions, "[f]ind [t]ype definitions")

map_n("<leader>fq", ts.diagnostics, "[f]ind diagnostiqs")

map_n("<leader>ff", ts.find_files, "[f]ind [f]iles")
map_n("<leader>fg", ts.live_grep, "[f]ind via [g]rep")
map_n("<leader>fb", ts.buffers, "[f]ind [b]uffers")
map_n("<leader>fh", ts.help_tags, "[f]ind [h]elp tags")
map_n("<leader>fs", ts.lsp_document_symbols, "[f]ind document [s]ymbols")
map_n("<leader>fS", ts.lsp_workspace_symbols, "[f]ind workspace [S]ymbols")
