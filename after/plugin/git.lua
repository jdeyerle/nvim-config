require('gitsigns').setup {}

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
