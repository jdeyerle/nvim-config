vim.cmd.colorscheme 'onedark'

vim.opt.showmode = false

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
}
