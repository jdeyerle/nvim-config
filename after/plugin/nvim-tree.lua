vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

local nvimtree = require 'nvim-tree'

nvimtree.setup {
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  update_focused_file = { enable = true },
}

vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeToggle<cr>', { desc = 'File [T]ree' })
