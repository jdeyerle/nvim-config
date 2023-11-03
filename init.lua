vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('jdeyerle.lazy').setup()
require('jdeyerle.commands').setup()
-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- tabs & indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
-- vim.opt.cindent = true
vim.opt.breakindent = true

-- search
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- appearance
vim.opt.termguicolors = true
vim.wo.signcolumn = 'yes'

-- scrolling
vim.opt.scrolloff = 8

-- windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- turn off swapfile
vim.opt.swapfile = false

-- save undo history
vim.opt.undofile = true

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
})

-- default remaps
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set({ 'n', 'x' }, '<BS>', '<C-^>')
vim.keymap.set({ 'n', 'x' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', 'i', function()
  if #vim.fn.getline '.' == 0 then
    return '"_cc'
  else
    return 'i'
  end
end, { expr = true })

-- custom mappings
vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('n', '<leader>w', '<C-w><C-w>', { desc = '[W]indow next' })
vim.keymap.set('x', '<leader>y', '"+y', { desc = '[Y]ank to system clipboard' })
