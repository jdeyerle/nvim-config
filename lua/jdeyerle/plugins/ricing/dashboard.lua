return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        project = {
          enable = true,
        },
        disable_move = true,
        shortcut = {
          {
            desc = 'Lazy',
            icon = ' ',
            group = 'Include',
            action = 'Lazy',
            key = 'l',
          },
          {
            icon = ' ',
            desc = 'Files',
            group = 'Function',
            action = 'Telescope find_files find_command=rg,--hidden,--files,-g,!.git',
            key = 'f',
          },
          {
            icon = ' ',
            desc = 'Config',
            group = 'String',
            action = 'Config',
            key = 'c',
          },
          {
            icon = ' ',
            desc = 'Dotfiles',
            group = 'Constant',
            action = 'Dotfiles',
            key = 'd',
          },
        },
      },
    }
  end,
}
