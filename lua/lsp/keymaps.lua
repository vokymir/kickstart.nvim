-- NOTE: another language-specific keymaps might be set inside languages dir

vim.api.nvim_create_augroup("LspKeymaps", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspKeymaps",
  callback = function(args)
    local buf = args.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
    end

    -- NAVIGATION
    map("n", "gd", vim.lsp.buf.definition, "[g]o to [d]efinition")
    map("n", "gD", vim.lsp.buf.declaration, "[g]o to [D]eclaration")
    map("n", "gi", vim.lsp.buf.implementation, "[g]o to [i]mplementation")
    map("n", "gr", vim.lsp.buf.references, "[g]oto [r]eference (might open quicklist)")
    map("n", "gt", vim.lsp.buf.type_definition, "[g]o to [t]ype definition")

    -- INFORMATION
    map("n", "K", vim.lsp.buf.hover, "Hover documentation")
    map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

    -- REFACTORING
    map("n", "<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame symbol")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")

    -- WORKSPACE
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "[w]orkspace: [a]dd folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "[w]orkspace: [r]emove folder")
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[w]orkspace: [l]ist folders")
  end,
})

-- RESTORE gq
vim.keymap.set("n", "<leader>gq", "<CMD>set formatexpr=nil<CR>", { desc = "Restore gq functionality" })

-- AUTO FORMATTING
vim.api.nvim_create_augroup("AutoFormatting", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "AutoFormatting",
  callback = function()
    vim.lsp.buf.format({ async = true })
  end,
})
