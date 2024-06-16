return {
  'stevearc/conform.nvim',
  events = { 'BufNewFile', 'BufReadPre' },
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        css = { 'prettier' },
        html = { 'prettier' },
        graphql = { 'prettier' },
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        json = { 'prettier' },
        markdown = { 'prettier' },
        svelte = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        yaml = { 'prettier' },

        lua = { 'stylua' },
      },
      format_on_save = function(bufnr)
        if not vim.g.disable_autoformat and not vim.b[bufnr].disable_autoformat then
          return { lsp_fallback = true, async = false, timeout_ms = 500 }
        end
      end,
    }

    vim.api.nvim_create_user_command('FormatToggle', function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      if vim.g.disable_autoformat then
        print 'Autoformatting disabled'
      else
        print 'Autoformatting enabled'
      end
    end, {})

    vim.keymap.set({ 'n', 'x' }, '<F3>', function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      }
    end, { desc = 'Format file or range' })
  end,
}
