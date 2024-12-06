return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup {
        ui = {
          icons = {
            package_installed = '✔︎',
            package_pending = '?',
            package_uninstalled = '×',
          },
        },
      }
    end,
  },

  {

    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'bashls',
          'elixirls',
          'lua_ls',
          'marksman',
          'pylsp',
          'rust_analyzer',
          'tailwindcss',
          'ts_ls',
        },
      }
    end,
  },

  {

    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
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
}
