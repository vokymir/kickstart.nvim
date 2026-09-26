return {
  filetypes = { "typst" },

  on_attach = function(_, bufnr)
    local typst = require("lsp.typst")

    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("<leader>tw", typst.watch, "[t]ypst [w]atch")
    map("<leader>tl", typst.enforce_layout, "[t]ypst fix [l]ayout")
    map("<leader>tp", typst.preview, "[t]ypst [p]review PDF")
  end,
}
