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
]])
