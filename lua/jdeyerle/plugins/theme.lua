return {
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      require('onedark').setup {
        style = 'darker',
        transparent = true,
        lualine = {
          transparent = true, -- center bar (c) transparency
        },
      }
      vim.cmd.colorscheme 'onedark'
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'navarasu/onedark.nvim',
    },
    priority = 1000,
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'onedark',
          component_separators = '|',
          section_separators = '',
        },
      }

      vim.opt.showmode = false
    end,
  },

  {
    'nvimdev/dashboard-nvim',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    event = 'VimEnter',
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
              action = [[Telescope find_files find_command=rg,--hidden,--files,-g,!.git]],
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
  },
}
