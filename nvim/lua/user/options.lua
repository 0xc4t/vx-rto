local opt = vim.opt

-- Indentation
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.smartindent = true

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.splitright = true
opt.splitbelow = true
opt.shortmess:append("I") -- Disable intro message
opt.shortmess:append("c") -- Don't give ins-completion-menu messages

-- System
opt.clipboard = "unnamedplus"
opt.updatetime = 50
opt.completeopt = { "menuone", "noselect" }

vim.g.mapleader = " "
