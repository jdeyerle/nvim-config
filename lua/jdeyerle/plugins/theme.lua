return {
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
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
      vim.opt.showmode = false

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'onedark',
          component_separators = '|',
          section_separators = '',
        },
      }
    end,
  },
}
