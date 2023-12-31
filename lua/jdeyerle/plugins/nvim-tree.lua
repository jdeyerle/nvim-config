return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  priority = 1001, -- see :help nvim-tree-netrw
  config = function()
    local nvim_tree = require 'nvim-tree'
    local api = require 'nvim-tree.api'

    vim.go.loaded_netrw = 1
    vim.go.loaded_netrwPlugin = 1

    vim.opt.termguicolors = true

    nvim_tree.setup {
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      update_focused_file = { enable = true },
      view = {
        width = {}, -- dynamic width - see :h nvim-tree-opts
      },
      live_filter = {
        prefix = '[FILTER]: ',
        always_show_folders = false,
      },
      actions = { open_file = { quit_on_open = true } },
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
