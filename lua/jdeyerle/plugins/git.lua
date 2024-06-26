return {
  { 'github/copilot.vim' },

  {
    'lewis6991/gitsigns.nvim',
    config = true,
  },

  {
    'akinsho/git-conflict.nvim',
    config = true,
  },

  {
    'f-person/git-blame.nvim',
    config = function()
      vim.g.gitblame_enabled = false
      vim.keymap.set('n', '<leader>gb', '<cmd>GitBlameToggle<cr>', { desc = '[G]it [B]lame' })
    end,
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
        float_opts = {
          border = 'curved',
          height = function()
            return vim.o.lines - 4
          end,
          width = function()
            return vim.o.columns - 4
          end,
        },
        hidden = true,
      }

      vim.keymap.set('n', '<leader>gg', function()
        local git_dir = require('jdeyerle.util').git_dir()
        if git_dir then
          lazygit.dir = git_dir
          lazygit:toggle()
        else
          print 'Not a git repository.'
        end
      end, { desc = 'Lazy[G]it' })
    end,
  },

  -- allow lazygit to edit files in the current vim session
  {
    'willothy/flatten.nvim',
    config = true,
  },
}
