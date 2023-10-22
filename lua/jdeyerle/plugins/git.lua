return {
  {
    'lewis6991/gitsigns.nvim',
    config = true,
  },

  -- setup lazygit using toggleterm
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup {}
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new {
        cmd = 'lazygit',
        dir = 'git_dir',
        direction = 'float',
        float_opts = { border = 'curved' },
        hidden = true,
      }

      vim.keymap.set('n', '<leader>gg', function()
        lazygit:toggle()
      end, { desc = 'Lazy[G]it' })
    end,
  },

  -- allow lazygit to edit files in the current vim session
  {
    'willothy/flatten.nvim',
    config = true,
  },
}
