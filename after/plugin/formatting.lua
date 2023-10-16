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
