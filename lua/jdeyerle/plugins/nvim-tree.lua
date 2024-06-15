return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  -- default priority is 50 and colorscheme plugins are generally loaded
  -- with priority 1000, so we want to use a higher priority to hijack netrw
  -- see `nvim-tree-netrw` and `lazy.nvim.txt` :help pages for more info
  priority = 1001,
  config = function()
    local nvim_tree = require 'nvim-tree'
    local api = require 'nvim-tree.api'

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.opt.termguicolors = true

    nvim_tree.setup {
      hijack_cursor = true,
      update_focused_file = { enable = true },
      view = {
        width = {}, -- dynamic width - see :h nvim-tree-opts
        relativenumber = true,
      },
      renderer = {
        indent_markers = { enable = true },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = '→',
              arrow_open = '↓',
            },
          },
        },
      },
      actions = { open_file = { quit_on_open = true } },
      filters = { custom = { '.DS_Store' } },
      -- git = { ignore = false },
      on_attach = function(bufnr)
        local nmap = function(keys, fn, desc)
          vim.keymap.set('n', keys, fn, { buffer = bufnr, desc = 'nvim-tree: ' .. desc })
        end

        api.config.mappings.default_on_attach(bufnr)

        nmap('<leader>t', '<cmd>wincmd p<cr>', 'File [T]ree')
        nmap('t', '<cmd>wincmd p<cr>', 'File [T]ree')
        nmap('?', api.tree.toggle_help, '[?] Help')
      end,
    }

    vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeFocus<cr>', { desc = 'File [T]ree' })

    vim.api.nvim_create_autocmd('DirChanged', {
      pattern = 'global',
      group = vim.api.nvim_create_augroup('NvimTreeChangeDir', { clear = true }),
      callback = function()
        nvim_tree.change_dir(vim.v.event.cwd)
      end,
    })
  end,
}
