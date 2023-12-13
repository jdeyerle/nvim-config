return {
  {
    'nvim-treesitter/nvim-treesitter',

    name = 'jdeyerle.plugins.treesitter',

    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },

    build = function()
      local ts_update = require('nvim-treesitter.install').update { with_sync = true }
      ts_update()
    end,

    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'c',
          'cpp',
          'go',
          'graphql',
          'hcl',
          'html',
          'javascript',
          'jsdoc',
          'json',
          'lua',
          'python',
          'rust',
          'toml',
          'tsx',
          'typescript',
          'vimdoc',
          'vim',
          'yaml',
        },

        sync_install = false,

        auto_install = true,

        highlight = { enable = true },

        indent = { enable = true },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'gnn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },

        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }
    end,
  },

  {
    'ckolkey/ts-node-action',
    dependencies = { 'jdeyerle.plugins.treesitter' },
    config = function()
      local ts_node = require 'ts-node-action'
      vim.keymap.set('n', 'ga', ts_node.node_action, { desc = 'Node [A]ction' })
    end,
  },

  {
    'hiphish/rainbow-delimiters.nvim',
    dependencies = { 'jdeyerle.plugins.treesitter' },
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
        blacklist = { 'lua' },
      }
    end,
  },
}
