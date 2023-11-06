return {
  {
    'folke/neodev.nvim',
    priority = 100, -- neodev must load before lsp setup
    config = function()
      require('neodev').setup {}
    end,
  },

  {
    'VonHeikemen/lsp-zero.nvim',

    branch = 'v3.x',

    dependencies = {
      --- Uncomment these if you want to manage LSP servers from neovim
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },

      -- Telescope for custom keymaps
      { 'nvim-telescope/telescope.nvim' },
    },

    config = function()
      local lsp_zero = require 'lsp-zero'
      local telescope = require 'telescope.builtin'

      lsp_zero.on_attach(function(_, bufnr)
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
        nmap('<F3>', function()
          vim.lsp.buf.format { async = true }
        end, 'Format buffer')
        nmap('<F4>', vim.lsp.buf.code_action, 'Code Action')

        nmap('<leader>gd', telescope.lsp_document_symbols, '[G]oto [D]ocument symbols')
        nmap('<leader>gw', telescope.lsp_dynamic_workspace_symbols, '[G]oto [W]orkspace symbols')
      end)

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      -- lsp_zero.get_capabilities() might be better?
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      local servers = {
        bashls = {},
        lua_ls = lsp_zero.nvim_lua_ls().settings,
        marksman = {},
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
    end,
  },

  {
    'jay-babu/mason-null-ls.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'nvim-lua/plenary.nvim',
      'nvimtools/none-ls.nvim',
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('mason-null-ls').setup {
        ensure_installed = { 'prettier', 'shellcheck', 'stylua' },
        handlers = {},
      }

      local autocmd_group =
        vim.api.nvim_create_augroup('Custom auto-commands for formatting', { clear = true })

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
        pattern = { '*.js', '*.jsx', '*.ts', '*.tsx', '*.json' },
        desc = 'Auto-format js/ts files after saving',
        callback = function()
          local fileName = vim.api.nvim_buf_get_name(0)
          local jobid = vim.fn.jobstart([[grep -E '"prettier"\s*:\s*".+"' package.json]], {
            on_exit = function(_, exitcode)
              if exitcode == 0 then
                vim.cmd(':silent !npx prettier -w ' .. fileName)
              else
                vim.cmd(':silent !prettier -w ' .. fileName)
              end
            end,
          })
          vim.fn.jobwait { jobid }
        end,
        group = autocmd_group,
      })
    end,
  },
}
