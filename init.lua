require('plugins')
require('mason-config')
require('lualine')
require('lsp')
require('auto-completion')
require('treesitter')
require('autotag')
require('autopair')
require('telecope')
require('bufline')
require('git-config')

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end

  set number
]])
