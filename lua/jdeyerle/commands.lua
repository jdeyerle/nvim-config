local M = {}

function M.setup()
  local util = require 'jdeyerle.util'

  local command = function(name, fn, opts)
    vim.api.nvim_create_user_command(name, fn, opts or {})
  end

  local bind = function(fn, args)
    return function()
      fn(args)
    end
  end

  command('Config', bind(util.find_all_files, '~/.config/nvim'))
  command('Dotfiles', bind(util.find_all_files, '~/.dotfiles'))

  command('CD', function()
    local path = require('jdeyerle.util').git_dir() or vim.expand '%:p:h'
    vim.cmd(':cd ' .. path)
    vim.cmd 'NvimTreeFocus'
    vim.cmd [[wincmd p]]
  end)

  command('SO', function()
    local cmds = {
      ['javascript'] = '!bun %',
      ['typescript'] = '!bun %',
      ['rust'] = '!cargo run %',
      ['markdown'] = 'MarkdownPreview',
    }

    local cmd = cmds[vim.bo.filetype]

    if cmd and vim.bo.modified then
      local input = vim.fn.input 'Save changes and continue? (y/n) '
      if input:gsub('%s+', ''):lower() ~= 'y' then
        return
      end
      vim.cmd 'w'
    end

    vim.cmd(cmd or 'so')
  end)

  command('ConventionalCommit', function()
    vim.fn.system {
      'open',
      'https://github.com/angular/angular/blob/22b96b9/CONTRIBUTING.md#-commit-message-guidelines',
    }
  end)
end

return M
