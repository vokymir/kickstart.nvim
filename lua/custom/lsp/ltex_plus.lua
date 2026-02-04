require('lspconfig').ltex_plus.setup {
  settings = {
    ltex = {
      language = 'cs',
      additionalRules = {
        motherTongue = 'cs',
      },
      enabledLanguages = { 'cs', 'en-US' },
    },
  },
}
