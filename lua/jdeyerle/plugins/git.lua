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

      vim.keymap.set('n', '<leader>gs', function()
        lazygit:toggle()
      end, { desc = '[G]it [S]tatus' })
    end,
  },

  -- allow lazygit to edit files in the current vim session
  {
    'willothy/flatten.nvim',
    config = true,
  },
}
