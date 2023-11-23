require('plugins')

vim.g.mapleader = ';'
local keymap = vim.keymap.set;

--         ╭──────────────────────────────────────────────────────────╮
--         │                          theme                           │
--         ╰──────────────────────────────────────────────────────────╯
require("one_monokai").setup({
    transparent = true,
    colors = {},
    themes = function(colors)
        return {}
    end,
    italics = true,
})

--         ╭──────────────────────────────────────────────────────────╮
--         │                        nvim-tree                         │
--         ╰──────────────────────────────────────────────────────────╯
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true -- set termguicolors to enable highlight groups
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

--         ╭──────────────────────────────────────────────────────────╮
--         │                     auto-completions                     │
--         ╰──────────────────────────────────────────────────────────╯
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  }),
  formatting = {
    format = require('lspkind').cmp_format({ with_text = false, maxwidth = 50 })
  }
})
vim.cmd([[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]])

--         ╭──────────────────────────────────────────────────────────╮
--         │                   autopair and autotag                   │
--         ╰──────────────────────────────────────────────────────────╯
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})
require('nvim-ts-autotag').setup({})

--         ╭──────────────────────────────────────────────────────────╮
--         │                        bufferline                        │
--         ╰──────────────────────────────────────────────────────────╯
require('bufferline').setup({})

--         ╭──────────────────────────────────────────────────────────╮
--         │                           git                            │
--         ╰──────────────────────────────────────────────────────────╯
require('git').setup({
  keymaps = {
    -- Open blame window
    blame = "<Leader>gb",
    -- Open file/folder in git repository
    browse = "<Leader>go",
  }
})

--         ╭──────────────────────────────────────────────────────────╮
--         │                           lsp                            │
--         ╰──────────────────────────────────────────────────────────╯
local lspconfig = require('lspconfig');
lspconfig.tsserver.setup({
	--root_dir = function(...)
		--return require("lspconfig.util").root_pattern(".git")(...)
	--end,
	single_file_support = false,
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "literal",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
})
lspconfig.eslint.setup({})
lspconfig.thriftls.setup({})
lspconfig.cssls.setup({})

--         ╭──────────────────────────────────────────────────────────╮
--         │                         lualine                          │
--         ╰──────────────────────────────────────────────────────────╯
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'solarized_dark',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 0 -- 0 = just filename, 1 = relative path, 2 = absolute path
    } },
    lualine_x = {
      { 'diagnostics', sources = { "nvim_diagnostic" }, symbols = { error = ' ', warn = ' ', info = ' ',
        hint = ' ' } },
      'encoding',
      'filetype'
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
    } },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = { 'fugitive' }
})

-- mason
require('mason').setup()
require('mason-lspconfig').setup()

-- telescope
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions



require('telescope').setup({
  defaults = {
    --file_ignore_patterns = { 'node_modules', 'dist', 'output-i18n' }
  }
})


--         ╭──────────────────────────────────────────────────────────╮
--         │                        treesitter                        │
--         ╰──────────────────────────────────────────────────────────╯
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "toml",
    "json",
    "yaml",
    "css",
    "html",
    "lua",
    "markdown",
    "thrift"
  },
  sync_install = false,
  auto_install = true,

  autotag = {
    enable = true,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = true, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

--         ╭──────────────────────────────────────────────────────────╮
--         │                       comment-box                        │
--         ╰──────────────────────────────────────────────────────────╯
local cb = require('comment-box');
cb.setup({
  doc_width = 80, -- width of the document
  box_width = 60, -- width of the boxes
  borders = { -- symbols used to draw a box
    top = "─",
    bottom = "─",
    left = "│",
    right = "│",
    top_left = "╭",
    top_right = "╮",
    bottom_left = "╰",
    bottom_right = "╯",
  },
  line_width = 70, -- width of the lines
  line = { -- symbols used to draw a line
    line = "─",
    line_start = "─",
    line_end = "─",
  },
  outer_blank_lines = false, -- insert a blank line above and below the box
  inner_blank_lines = false, -- insert a blank line above and below the text
  line_blank_line_above = false, -- insert a blank line above the line
  line_blank_line_below = false, -- insert a blank line below the line
})

--         ╭──────────────────────────────────────────────────────────╮
--         │                       vim settings                       │
--         ╰──────────────────────────────────────────────────────────╯
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

--         ╭──────────────────────────────────────────────────────────╮
--         │                          keymap                          │
--         ╰──────────────────────────────────────────────────────────╯

keymap('n', '<leader>wd', '<C-W>v', {})
keymap('n', '<leader>ww', '<C-W>w', {})
vim.opt.clipboard = "unnamedplus"

-- comment-box
keymap({ 'n', 'v' }, "<leader>x1", cb.ccbox, {})
keymap({ 'n', 'v' }, "<leader>x2", function() cb.cbox(12) end, {})

-- nvim-tree
keymap('n', '<leader>b', ':NvimTreeToggle<Return>', {})

-- telescope
keymap('n', '<leader>ff', builtin.find_files, {})
keymap('n', '<leader>gg', builtin.git_files, {})
keymap('n', '<leader>fg', builtin.live_grep, {})
keymap('n', '<leader>fb', builtin.buffers, {})
keymap('n', '<leader>fh', builtin.help_tags, {})
keymap("n", "<leader>m", function() require("telescope").extensions.monorepo.monorepo() end)
keymap("n", "<leader>n", function() require("monorepo").toggle_project() end)

-- buffer-line
keymap('n', '<leader>j', ':BufferLineCycleNext<Return>', {})
keymap('n', '<leader>k', ':BufferLineCyclePrev<Return>', {})
keymap('n', '<leader>w', ':bdelete<Return>', {})
