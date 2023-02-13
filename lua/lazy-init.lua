--[[--
File  : lazy.lua
Author: lchannng <l.channng@gmail.com>
Date  : 2023/02/13 00:30:43
--]]--

local vim = vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
  },

  {
    'nathom/filetype.nvim',
    config = function()
      require("filetype").setup({})
    end
  },

  {
    "kazhala/close-buffers.nvim",
    cmd = "BDelete",
  },

  {
    'navarasu/onedark.nvim',
    config = require("config.theme").onedark,
  },

  {
    'akinsho/bufferline.nvim',
    config = require("config.theme").bufferline,
  },

  {
    'nvim-lualine/lualine.nvim',
    after = 'onedark.nvim',
    config = require("config.theme").lualine,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = "BufReadPre",
    config = function()
      require("indent_blankline").setup({})
    end,
  },

  {
    'kyazdani42/nvim-tree.lua',
    cmd = { "NvimTreeToggle", "NvimTreeRefresh", },
    config = require("config.theme").nvim_tree,
  },

  {
    'sheerun/vim-polyglot',
    event = "BufReadPost",
  },

  {
    'lewis6991/gitsigns.nvim',
    event = "BufReadPre",
    config = function()
      require('gitsigns').setup({})
    end
  },

  {
    'ludovicchabant/vim-gutentags',
    event = "BufReadPre",
    config = function()
      vim.cmd([[
        " gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
        let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

        " 所生成的数据文件的名称
        let g:gutentags_ctags_tagfile = '.tags'

        " 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
        let s:vim_tags = expand('~/.cache/tags')
        let g:gutentags_cache_dir = s:vim_tags

        " 配置 ctags 的参数
        let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
        let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
        let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

        " 检测 ~/.cache/tags 不存在就新建
        if !isdirectory(s:vim_tags)
        silent! call mkdir(s:vim_tags, 'p')
        endif
      ]])
    end,
  },

  {
    'lchannng/vim-header',
    config = function()
      vim.cmd([[
        let g:header_auto_add_header = 1
        let g:header_field_author = 'lchannng'
        let g:header_field_author_email = 'l.channng@gmail.com'
        let g:header_field_filename_path = 0
        let g:header_field_modified_timestamp = 0
        let g:header_field_modified_by = 0
        let g:header_field_timestamp_format = '%Y/%m/%d %H:%M:%S'
      ]])
    end
  },

  -- telescope begin
  { 'nvim-lua/plenary.nvim', lazy = true, },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    lazy = true,
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  },

  {
    'nvim-telescope/telescope.nvim',
    cmd = { "Telescope" },
    dependencies = {
      'plenary.nvim',
      'telescope-fzf-native.nvim',
    },
  },
  -- telescope end

  -- lsp begin
  { 'hrsh7th/cmp-nvim-lsp', lazy = true, },
  { 'neovim/nvim-lspconfig', lazy = true, },

  {
    'williamboman/mason.nvim',
    lazy = true,
    config = function() require("mason").setup() end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    event = { "BufReadPre", "InsertEnter", },
    config = function()
      require("config.lsp")
    end,
    dependencies = {
      "cmp-nvim-lsp",
      "nvim-lspconfig",
      "mason.nvim",
    },
  },

  -- lsp end

  -- completion begin
  { 'hrsh7th/cmp-nvim-lua', lazy = true, },
  { 'hrsh7th/cmp-path', lazy = true, },
  { 'hrsh7th/cmp-buffer', lazy = true, },
  { 'L3MON4D3/LuaSnip', lazy = true, },
  { 'saadparwaiz1/cmp_luasnip', lazy = true, },
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    config = function() require("config.completion") end,
    dependencies = {
      "cmp-nvim-lsp",
      "cmp-nvim-lua",
      "cmp-path",
      "cmp-buffer",
      "LuaSnip",
      "cmp_luasnip",
    }
  },
  -- completion end

  {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function() require("config.keys") end,
  },
},
{
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
}
)
