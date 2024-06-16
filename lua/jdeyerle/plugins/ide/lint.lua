return {
  'mfussenegger/nvim-lint',
  events = { 'BufNewFile', 'BufReadPre' },
  dependencies = { 'williamboman/mason.nvim' },
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
}
