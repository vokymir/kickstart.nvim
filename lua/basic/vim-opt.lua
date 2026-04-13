-- SYSTEM
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.o.signcolumn = 'yes:1'
vim.opt.statusline = '[%n] %<%f %h%w%m%r%=%-14.(%l,%c%V%) %P'

-- SEARCH
vim.opt.ignorecase = true
vim.opt.smartcase = true               -- don't ignore case if contains capitalized letter
vim.opt.wildoptions:append { 'fuzzy' } -- better default search
vim.opt.hlsearch = true                -- highlight after search
vim.opt.incsearch = true               -- live search

-- EDITING (visual helper)
vim.opt.colorcolumn = '81'
vim.opt.textwidth = 80
vim.opt.scrolloff = 999

-- FILES
vim.opt.swapfile = false
vim.opt.confirm = true

-- INDENTATION
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.breakindent = true

-- WRAPPING
vim.opt.textwidth = 80
vim.opt.wrap = true
vim.opt.linebreak = true

-- UX
vim.opt.termguicolors = true
vim.opt.smoothscroll = true
vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy" } -- LSP completion

-- SPEED
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
