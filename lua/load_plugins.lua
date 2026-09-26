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

  -- ##### LSP #####
  { -- LspConfig: LSP - data only, server-specific configs
    src = 'https://github.com/neovim/nvim-lspconfig',
  },
  { -- Mason: install LS
    src = 'https://github.com/mason-org/mason.nvim',
  },
  { -- bridges mason installs to native vim.lsp.enable()
    src = 'https://github.com/mason-org/mason-lspconfig.nvim',
  },
  {
    src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  },

  -- ##### DAP #####
  {
    src = "https://github.com/mfussenegger/nvim-dap",
  },
  {
    src = "https://github.com/jay-babu/mason-nvim-dap.nvim",
  },

  -- ##### TELESCOPE #####
  { -- Plenary: requirement for telescope, TEEJs funny files
    src = "https://github.com/nvim-lua/plenary.nvim",
  },
  { -- FZF for Telescope: recommended dependency
    src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  },
  { -- Telescope: Fuzzy finder
    src = "https://github.com/nvim-telescope/telescope.nvim",
  },

  -- ##### GIT #####
  { -- GitMessenger: show history on line
    src = 'https://github.com/rhysd/git-messenger.vim',
  },
  { -- LazyGit: easily manage git
    src = 'https://github.com/kdheepak/lazygit.nvim',
  },
  { -- GitSigns: show git status in editor
    src = 'https://github.com/lewis6991/gitsigns.nvim',
  },

})
