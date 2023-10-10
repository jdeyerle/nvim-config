local lsp_zero = require 'lsp-zero'
local lspconfig = require 'lspconfig'

lsp_zero.on_attach(function(_, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps { buffer = bufnr }
end)

require('mason').setup {}
require('mason-lspconfig').setup {
  ensure_installed = { 'lua_ls', 'tsserver' },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      lspconfig.lua_ls.setup(lua_opts)
    end,
  },
}

require('mason-null-ls').setup {
  ensure_installed = { 'prettier', 'stylua' },
  handlers = {},
}

local autocmd_group = vim.api.nvim_create_augroup('Custom auto-commands for formatting', { clear = true })

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = { '*.lua' },
  desc = 'Auto-format lua files after saving',
  callback = function()
    local fileName = vim.api.nvim_buf_get_name(0)
    vim.cmd(':silent !stylua ' .. fileName)
  end,
  group = autocmd_group,
})

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = { '*.js', '*.jsx', '*.ts', '*.tsx' },
  desc = 'Auto-format js/ts files after saving',
  callback = function()
    local fileName = vim.api.nvim_buf_get_name(0)
    vim.cmd(':silent !prettier -w ' .. fileName)
  end,
  group = autocmd_group,
})
