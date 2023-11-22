require('plugins')
require('mason-config')
require('lualine-config')
require('lsp')
require('auto-completion')
require('treesitter')
require('autotag')
require('autopair')
require('telecope')
require('bufline')
require('git-config')

require("one_monokai").setup({
    transparent = true,
    colors = {},
    themes = function(colors)
        return {}
    end,
    italics = true,
})

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end

  set number
  set tabstop=2               " number of columns occupied by a tab 
  set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
  set expandtab               " converts tabs to white space
  set shiftwidth=2            " width for autoindents
  set cursorline              " highlight current cursorline
  set ignorecase              " case insensitive
  set hlsearch                " highlight search
  set autoindent              " indent a new line the same amount as the line just typed
]])
