vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'jdeyerle.packer'

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- tabs & indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.o.breakindent = true

-- search
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true

-- appearance
vim.opt.termguicolors = true
vim.wo.signcolumn = 'number'

-- scrolling
vim.opt.scrolloff = 8

-- windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- turn off swapfile
vim.opt.swapfile = false

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_winsize = 25

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- default remaps
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set({ 'n', 'v' }, '<BS>', '<C-^>')

-- leader maps
vim.keymap.set('n', '<leader>w', '<C-w><C-w>')
vim.keymap.set('n', '<leader>dd', '<cmd>Lexplore %:p:h<cr>')
vim.keymap.set('n', '<leader>da', vim.cmd.Lexplore)
