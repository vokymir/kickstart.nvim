vim.pack.add({
  { -- Oil: file explorer
    src = "https://github.com/stevearc/oil.nvim",
    name = "oil.nvim",
  },
  { -- Tokyonight: colorscheme
    src = 'https://github.com/folke/tokyonight.nvim',
  },
  { -- Wakatime: time tracking
    src = 'https://github.com/wakatime/vim-wakatime',
  },
  { -- Which key: keymap helper
    src = 'https://github.com/folke/which-key.nvim',
  },

  { -- LspConfig: LSP - data only, server-specific configs
    src = 'https://github.com/neovim/nvim-lspconfig',
  },
  { -- Mason: install LS
    src = 'https://github.com/mason-org/mason.nvim',
  },

  { -- Plenary: requirement for telescope, TEEJs funny files
    src = "https://github.com/nvim-lua/plenary.nvim"
  },
  { -- FZF for Telescope: recommended dependency
    src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim'
  },
  { -- Telescope: Fuzzy finder
    src = "https://github.com/nvim-telescope/telescope.nvim"
  },

})
