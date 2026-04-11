
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

})
