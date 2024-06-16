local function nmap(key, fn, desc)
  vim.keymap.set('n', key, fn, { desc = 'Debug: ' .. desc })
end

return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'

      nmap('<F5>', dap.continue, 'Start/Continue')
      nmap('<F10>', dap.step_over, 'Step Over')
      nmap('<F11>', dap.step_into, 'Step Into')
      nmap('<F12>', dap.step_out, 'Step Out')
      nmap('<leader>db', dap.toggle_breakpoint, 'Toggle Breakpoint')
      nmap('<leader>dB', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, 'Set Breakpoint')
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      local dap, dapui = require 'dap', require 'dapui'

      dapui.setup()
      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      nmap('<leader>du', dapui.toggle, 'Toggle UI')
      nmap('<leader>dr', function()
        dapui.open { reset = true }
      end, 'Reset UI')
    end,
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = { 'mfussenegger/nvim-dap', 'jdeyerle.plugins.treesitter' },
    config = true,
  },

  {
    'mxsdev/nvim-dap-vscode-js',

    dependencies = {
      'mfussenegger/nvim-dap',
      {
        'microsoft/vscode-js-debug',
        build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
      },
    },

    config = function()
      local dap = require 'dap'

      ---@diagnostic disable-next-line: missing-fields
      require('dap-vscode-js').setup {
        debugger_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug',
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge' },
      }

      for _, language in ipairs { 'typescript', 'javascript', 'typescriptreact' } do
        dap.configurations[language] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = '${workspaceFolder}',
          },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach Program',
            processId = function()
              return require('dap.utils').pick_process { filter = 'node' }
            end,
            skipFiles = { '<node_internals>/**' },
            -- resolveSourceMapLocations = {
            --   '${workspaceFolder}/**',
            --   '!**/node_modules/**',
            -- },
          },
          {
            name = 'Attach Program (port 9229)',
            port = 9229,
            request = 'attach',
            skipFiles = { '<node_internals>/**' },
            type = 'pwa-node',
          },
          {
            type = 'pwa-chrome',
            request = 'launch',
            name = 'Start Chrome with "localhost"',
            url = 'http://localhost:3000',
            webRoot = '${workspaceFolder}',
            userDataDir = '${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir',
          },
        }
      end

      require('dap.ext.vscode').load_launchjs(nil, {
        ['pwa-node'] = { 'javascript', 'typescript' },
        ['node'] = { 'javascript', 'typescript' },
      })
    end,
  },
}
