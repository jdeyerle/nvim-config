return {
  {
    'tpope/vim-commentary',
    config = function()
      vim.cmd 'autocmd FileType gleam setlocal commentstring=//%s'
    end,
  },
  { 'tpope/vim-surround' },
}
