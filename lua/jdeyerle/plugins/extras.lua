return {
  {
    'numToStr/Comment.nvim',
    config = true,
  },

  -- {
  --   'mbbill/undotree',
  --   config = function()
  --     vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndotree' })
  --   end,
  -- },

  -- trying prebuild to see if it prevents update conflicts
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },

  { 'github/copilot.vim' },
}
