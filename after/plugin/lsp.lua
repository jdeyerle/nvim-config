local lsp_zero = require 'lsp-zero'

require('neodev').setup {}

lsp_zero.on_attach(function(_, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps { buffer = bufnr }
end)

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- lsp_zero.get_capabilities() might be better?
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = {
  lua_ls = lsp_zero.nvim_lua_ls().settings,
  tsserver = {},
}

require('mason').setup {}
require('mason-lspconfig').setup {
  ensure_installed = vim.tbl_keys(servers),
  handlers = {
    function(server_name)
      require('lsp-zero.server').setup(server_name, {
        capabilities = capabilities,
        settings = servers[server_name],
      })
    end,
  },
}
