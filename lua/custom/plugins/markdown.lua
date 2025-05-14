-- return {}
return {
  {
    'ixru/nvim-markdown',
    ft = { 'markdown' },
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    config = function()
      vim.keymap.set('n', '<Leader>mp', '<Plug>MarkdownPreview', { desc = 'Markdown Preview' })
    end,
  },
}
