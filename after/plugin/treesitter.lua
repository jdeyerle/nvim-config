require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim' },

  sync_install = false,

  auto_install = true,

  highlight = { enable = true },

  indent = { enable = true },

  -- remap these, they interfere with default jumps
  -- see top of help.txt
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'gnn', 
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
}
