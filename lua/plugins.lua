local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer = require('packer')

packer.init({
  git = {
    default_url_format = 'https://github.com/%s'
    -- default_url_format = 'https://doc.fastgit.org/%s'
  }
})

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins here
  
  use 'williamboman/mason.nvim'   
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'

  use 'nvim-lualine/lualine.nvim'

  use 'onsails/lspkind-nvim'
  use 'L3MON4D3/LuaSnip'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'

  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-treesitter/nvim-treesitter'
  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' },
  }

  use 'windwp/nvim-ts-autotag'
  use 'windwp/nvim-autopairs'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'nvim-telescope/telescope-file-browser.nvim'
  use {
      "imNel/monorepo.nvim",
      config = function()
        require("monorepo").setup({
          silent = false, -- Supresses vim.notify messages
          autoload_telescope = true, -- Automatically loads the telescope extension at setup
          data_path = vim.fn.stdpath("data"), -- Path that monorepo.json gets saved to
        })
      end,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
  }

  use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }

  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim'

  use 'cpea2506/one_monokai.nvim'

  use 'rcarriga/nvim-notify'

  use 'LudoPinelli/comment-box.nvim'

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
