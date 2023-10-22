local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- TODO: investigate dense-analysis/ale and sbdchd/neoformat
-- TODO: investigate mfussenegger/nvim-treehopper and textobjects
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    requires = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update { with_sync = true }
      ts_update()
    end,
  }

  use {
    'hiphish/rainbow-delimiters.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' },
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      --- Uncomment these if you want to manage LSP servers from neovim
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
    },
  }

  use 'folke/neodev.nvim'

  use {
    'jay-babu/mason-null-ls.nvim',
    requires = {
      'williamboman/mason.nvim',
      'nvim-lua/plenary.nvim',
      'nvimtools/none-ls.nvim',
    },
  }

  use 'lewis6991/gitsigns.nvim'

  use 'akinsho/toggleterm.nvim'
  use 'willothy/flatten.nvim'

  use 'numToStr/Comment.nvim'

  use 'mbbill/undotree'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
  }

  use 'ellisonleao/gruvbox.nvim'
  use 'navarasu/onedark.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
