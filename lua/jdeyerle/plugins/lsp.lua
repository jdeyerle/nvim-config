return {
  {
    'williamboman/mason.nvim',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    config = function()
      require('mason').setup {}
      require('mason-tool-installer').setup {
        ensure_installed = {
          -- formatting
          'prettier',
          'stylua',

          -- linting
          'eslint_d',
          'selene',
          'hadolint',
        },
      }
    end,
  },

  {
    'VonHeikemen/lsp-zero.nvim',

    branch = 'v3.x',

    dependencies = {
      --- Uncomment these if you want to manage LSP servers from neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- LSP Support
      'neovim/nvim-lspconfig',

      -- Neovim Lua API
      -- make sure to setup neodev BEFORE lspconfig
      { 'folke/neodev.nvim', config = true },

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',

      -- Telescope for custom keymaps
      'nvim-telescope/telescope.nvim',
    },

    config = function()
      local lsp_zero = require 'lsp-zero'

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      -- lsp_zero.get_capabilities() might be better?
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      local servers = {
        bashls = {},
        lua_ls = lsp_zero.nvim_lua_ls().settings,
        marksman = {},
        rust_analyzer = {},
        tsserver = {},
      }

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

      lsp_zero.on_attach(function(_, bufnr)
        local telescope = require 'telescope.builtin'

        local nmap = function(keys, fn, desc)
          vim.keymap.set('n', keys, fn, { buffer = bufnr, desc = 'LSP: ' .. desc })
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
      end)
    end,
  },

  {
    'stevearc/conform.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    events = { 'BufNewFile', 'BufReadPre' },
    config = function()
      local conform = require 'conform'

      conform.setup {
        formatters_by_ft = {
          css = { 'prettier' },
          html = { 'prettier' },
          graphql = { 'prettier' },
          javascript = { 'prettier' },
          javascriptreact = { 'prettier' },
          json = { 'prettier' },
          markdown = { 'prettier' },
          svelte = { 'prettier' },
          typescript = { 'prettier' },
          typescriptreact = { 'prettier' },
          yaml = { 'prettier' },

          lua = { 'stylua' },
        },
        format_on_save = function(bufnr)
          if not vim.g.disable_autoformat and not vim.b[bufnr].disable_autoformat then
            return { lsp_fallback = true, async = false, timeout_ms = 500 }
          end
        end,
      }

      vim.api.nvim_create_user_command('FormatToggle', function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        if vim.g.disable_autoformat then
          print 'Autoformatting disabled'
        else
          print 'Autoformatting enabled'
        end
      end, {})

      vim.keymap.set({ 'n', 'x' }, '<F3>', function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        }
      end, { desc = 'Format file or range' })
    end,
  },

  {
    'mfussenegger/nvim-lint',
    dependencies = { 'williamboman/mason.nvim' },
    events = { 'BufNewFile', 'BufReadPre' },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = {
        javascript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescript = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        svelte = { 'eslint_d' },

        dockerfile = { 'hadolint' },

        lua = { 'selene' },
      }

      vim.api.nvim_create_user_command('LintToggle', function()
        vim.g.disable_autolint = not vim.g.disable_autolint
        if vim.g.disable_autolint then
          print 'Autolinting disabled'
        else
          print 'Autolinting enabled'
        end
      end, {})

      vim.api.nvim_create_user_command('Lint', function()
        lint.try_lint()
      end, {})

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        pattern = { '*.js', '*.jsx', '*.ts', '*.tsx', '*.svelte', '*.lua' },
        group = vim.api.nvim_create_augroup('Lint', { clear = true }),
        callback = function()
          if not vim.g.disable_autolint then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
