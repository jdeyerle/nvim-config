return {
  'neovim/nvim-lspconfig',
  event = { 'BufNewFile', 'BufReadPre' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'folke/neodev.nvim', config = true },
  },

  config = function()
    local lspconfig = require 'lspconfig'
    local mason_lspconfig = require 'mason-lspconfig'
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'
    local telescope = require 'telescope.builtin'

    local capabilities = cmp_nvim_lsp.default_capabilities()

    local settings = {
      ['lua_ls'] = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        lspconfig[server_name].setup {
          capabilities = capabilities,
          settings = settings[server_name] or {},
        }
      end,
    }

    lspconfig.gleam.setup { capabilities = capabilities }

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(args)
        local nmap = function(keys, fn, desc)
          vim.keymap.set('n', keys, fn, { buffer = args.buf, desc = 'LSP: ' .. desc })
        end

        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('gi', telescope.lsp_implementations, '[G]oto [I]mplementations')
        nmap('gr', telescope.lsp_references, '[G]oto [R]eferences')

        nmap('<F2>', vim.lsp.buf.rename, 'Rename')
        nmap('<F4>', vim.lsp.buf.code_action, 'Code Action')

        nmap('<leader>gd', telescope.lsp_document_symbols, '[G]oto [D]ocument symbols')
        nmap('<leader>gw', telescope.lsp_dynamic_workspace_symbols, '[G]oto [W]orkspace symbols')
      end,
    })
  end,
}
