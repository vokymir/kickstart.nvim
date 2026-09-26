vim.api.nvim_create_augroup("LspKeymaps", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspKeymaps",
  callback = function(args)
    local buf = args.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
    end

    -- LSP CONTROL
    map("n", "<leader>lr", "<Cmd>lsp restart<CR>", "[l]sp: [r]estart")

    -- NAVIGATION
    map("n", "gd", vim.lsp.buf.definition, "[g]o to [d]efinition")
    map("n", "gD", vim.lsp.buf.declaration, "[g]o to [D]eclaration")

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

    -- FORMATTING
    map("n", "<leader>F", vim.lsp.buf.format, "[F]ormat")

    -- INLAY HINTS
    if vim.lsp.inlay_hint then
      map("n", "<leader>th", function()
        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = buf })
      end, "[t]oggle [h]ints (inlay)")
    end

    -- CALL HIERARCHY
    map("n", "<leader>ci", vim.lsp.buf.incoming_calls, "[c]alls: [i]ncoming")
    map("n", "<leader>co", vim.lsp.buf.outgoing_calls, "[c]alls: [o]utgoing")

    -- HIGHLIGHT REFERENCES UNDER CURSOR
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/documentHighlight") then
      local hl_group = vim.api.nvim_create_augroup("LspHighlight-" .. buf, { clear = true })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = hl_group,
        buffer = buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = hl_group,
        buffer = buf,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = "LspKeymaps",
        callback = function(detach_args)
          vim.lsp.buf.clear_references()
          pcall(vim.api.nvim_clear_autocmds, { group = "LspHighlight-" .. detach_args.buf })
        end,
      })
    end
  end,
})

-- AUTO FORMATTING
vim.api.nvim_create_augroup("AutoFormatting", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspFormatting", {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

    if not client:supports_method("textDocument/formatting") then
      return
    end

    if client:supports_method("textDocument/willSaveWaitUntil") then
      return
    end

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormatting", { clear = false }),
      buffer = ev.buf,
      callback = function()
        vim.lsp.buf.format({
          bufnr = ev.buf,
          id = client.id,
          timeout_ms = 1000,
        })
      end,
    })
  end,
})
