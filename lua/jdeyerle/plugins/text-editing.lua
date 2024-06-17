return {
  {
    'smjonas/inc-rename.nvim',
    opts = {},
    keys = { { '<leader>rn', ':IncRename ', '[R]e[n]ame' } },
  },

  {
    'tpope/vim-commentary',
    config = function()
      vim.cmd 'autocmd FileType gleam setlocal commentstring=//%s'
    end,
  },

  { 'tpope/vim-surround' },
}
