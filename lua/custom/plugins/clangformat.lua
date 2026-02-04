return {
  -- Mason to manage tools
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'clang-format', 'clangd' })
    end,
  },

  -- LSP integration
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      ensure_installed = { 'clangd' },
    },
  },

  -- Conform for formatting
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        cpp = { 'clang-format' },
        c = { 'clang-format' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
