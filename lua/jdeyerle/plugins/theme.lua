return {
  'navarasu/onedark.nvim',
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    require('onedark').setup {
      style = 'darker',
      transparent = true,
      -- lualine = {
      --   transparent = true, -- center bar (c) transparency
      -- },
    }
    vim.cmd.colorscheme 'onedark'
  end,
}
