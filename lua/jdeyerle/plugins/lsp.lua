return {
  {
    'folke/neodev.nvim',
    priority = 1000, -- neodev must load before lsp setup
    config = true,
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

      require('neodev').setup {}

      lsp_zero.on_attach(function(_, bufnr)
        -- see :help lsp-zero-keybindings
        lsp_zero.default_keymaps { buffer = bufnr }

        local map = function(mode, keys, fn, desc)
          vim.keymap.set(mode, keys, fn, { buffer = bufnr, desc = 'LSP: ' .. desc })
        end

        -- lsp-zero overrides
        map('n', 'K', vim.lsp.buf.hover, 'Show hover')
        map('n', 'gi', telescope.lsp_implementations, '[G]oto [I]mplementations')
        map('n', 'gr', telescope.lsp_references, '[G]oto [R]eferences')

        -- extras
        map('n', '<leader>gS', telescope.lsp_document_symbols, '[G]oto document [S]ymbols')
        map('n', '<leader>gS', telescope.lsp_dynamic_workspace_symbols, '[G]oto workspace [S]ymbols')
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
      -- stylua ignore
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
