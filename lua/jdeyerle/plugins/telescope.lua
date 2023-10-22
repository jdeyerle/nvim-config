return {
  'nvim-telescope/telescope.nvim',

  tag = '0.1.3', -- preview error with 0.1.4

  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },

  config = function()
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'
    local themes = require 'telescope.themes'

    telescope.setup {}

    telescope.load_extension 'fzf'

    local function nmap(key, fn, desc)
      vim.keymap.set('n', '<leader>' .. key, fn, { desc = desc })
    end

    nmap('?', builtin.oldfiles, '[?] Find recently opened files')
    nmap('<space>', builtin.buffers, '[ ] Find existing buffers')
    nmap('/', function()
      builtin.current_buffer_fuzzy_find(themes.get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, '[/] Fuzzily search in current buffer')
    nmap('gf', builtin.git_files, 'Search [G]it [F]iles')
    nmap('sf', builtin.find_files, '[S]earch [F]iles')
    nmap('sh', builtin.help_tags, '[S]earch [H]elp')
    nmap('sw', builtin.grep_string, '[S]earch current [W]ord')
    nmap('sg', builtin.live_grep, '[S]earch by [G]rep')
    nmap('sd', builtin.diagnostics, '[S]earch [D]iagnostics')
    nmap('sr', builtin.resume, '[S]earch [R]esume')
    nmap('sk', builtin.keymaps, '[S]earch [K]eymaps')
  end,
}
