return {
  {
    'nvim-telescope/telescope.nvim',

    dependencies = {
      'nvim-lua/plenary.nvim',
    },

    config = function()
      local telescope, builtin = require 'telescope', require 'telescope.builtin'

      telescope.setup {
        defaults = require('telescope.themes').get_ivy {
          -- winblend = 10, -- enable if not using transparent background
          dynamic_preview_title = true,
          layout_config = { height = 33 },
          path_display = function(_, path)
            local tail = require('telescope.utils').path_tail(path)
            return string.format('%s |> %s', tail, path)
          end,
        },
      }

      local nmap = function(key, fn, desc)
        vim.keymap.set('n', '<leader>' .. key, fn, { desc = desc })
      end

      local bind = function(fn, args)
        return function()
          fn(args)
        end
      end

      nmap('?', builtin.oldfiles, '[?] Find recently opened files')
      nmap('<space>', builtin.buffers, '[ ] Find existing buffers')
      nmap('/', builtin.current_buffer_fuzzy_find, '[/] Fuzzily search in current buffer')
      nmap('sf', builtin.find_files, '[S]earch [F]iles')
      nmap('sa', require('jdeyerle.util').find_all_files, '[S]earch [A]ll files')
      nmap('sh', builtin.help_tags, '[S]earch [H]elp')
      nmap('sw', builtin.grep_string, '[S]earch current [W]ord')
      nmap('sg', builtin.live_grep, '[S]earch by [G]rep')
      nmap('sd', builtin.diagnostics, '[S]earch [D]iagnostics')
      nmap('sr', builtin.resume, '[S]earch [R]esume')
      nmap('sk', builtin.keymaps, '[S]earch [K]eymaps')
      nmap('gf', bind(builtin.git_files, { cwd = '%:p:h' }), 'Search [G]it [F]iles')
      nmap('gs', bind(builtin.git_status, { cwd = '%:p:h' }), '[G]it [S]tatus')
    end,
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    config = function()
      require('telescope').load_extension 'fzf'
    end,
  },
}
