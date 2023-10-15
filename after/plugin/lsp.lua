local lsp_zero = require 'lsp-zero'
local lspconfig = require 'lspconfig'

require('neodev').setup {}

lsp_zero.on_attach(function(_, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps { buffer = bufnr }
end)

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

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
