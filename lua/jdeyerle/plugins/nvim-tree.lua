return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  priority = 1001, -- see :help nvim-tree-netrw
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.opt.termguicolors = true

    require('nvim-tree').setup {
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      update_focused_file = { enable = true },
    }

    vim.keymap.set('n', '<leader>t', vim.cmd.NvimTreeToggle, { desc = 'File [T]ree' })
  end,
}
