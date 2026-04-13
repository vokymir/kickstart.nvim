return {
  lsp = "clangd",
  mason = "clangd",

  config = {
    filetypes = { "c", "cpp", "objc", "objcpp" },
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--completion-style=detailed",
      "--header-insertion=never",
    },
  }
}
