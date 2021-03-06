--[[--
File  : plugins.lua
Author: lchannng <l.channng@gmail.com>
Date  : 2022/04/01 11:24:31
--]] --

local config = {
  profile = {
    enable = true,
    threshold = 0 -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}

local function startup()
  local runtime_dir = get_runtime_dir()
  local rtp_addition = runtime_dir .. '/site/pack/*/start/*'
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. ',' .. vim.o.runtimepath
  end

  local fn = vim.fn
  local packer_dir = runtime_dir .. '/site/pack/packer/opt/packer.nvim'
  if fn.empty(fn.glob(packer_dir)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_dir })
  end

  vim.cmd([[packadd packer.nvim]])

  local packer = require("packer")
  packer.reset()
  packer.init(config)
  local use = packer.use

  use 'lewis6991/impatient.nvim'

  use {
    'wbthomason/packer.nvim',
    opt = true
  }

  use {
    'dstein64/vim-startuptime',
    cmd = { "StartupTime" }
  }

  use {
    'sheerun/vim-polyglot',
    event = "BufRead",
  }

  use {
    "kazhala/close-buffers.nvim",
    cmd = "BDelete"
  }

  use {
    'nathom/filetype.nvim',
    config = function()
      require("filetype").setup({})
    end
  }

  use {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = [[require("config.keys")]],
  }

  local theme = require("config.theme")
  use {
    'navarasu/onedark.nvim',
    config = theme.onedark,
  }

  use {
    'akinsho/bufferline.nvim',
    config = theme.bufferline,
  }

  use {
    'nvim-lualine/lualine.nvim',
    after = 'onedark.nvim',
    config = theme.lualine,
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    event = "BufReadPre",
    config = function()
      require("indent_blankline").setup({})
    end,
  }

  use {
    'kyazdani42/nvim-tree.lua',
    opt = true,
    cmd = { "NvimTreeToggle", "NvimTreeRefresh", },
    config = theme.nvim_tree,
  }

  use {
    'lewis6991/gitsigns.nvim',
    event = "BufReadPre",
    config = function()
      require('gitsigns').setup({})
    end
  }

  use {
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
  }

  use {
    'nvim-telescope/telescope.nvim',
    opt = true,
    cmd = { "Telescope" },
    module = { "telescope" },
    wants = {
      'plenary.nvim',
      'telescope-fzf-native.nvim',
    },
    requires = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    },
    config = [[require("config.telescope")]]
  }

  use {
    'ludovicchabant/vim-gutentags',
    event = "BufReadPre",
    config = function()
      vim.cmd([[
        " gutentags ????????????????????????????????????????????????/??????????????????????????????????????????
        let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

        " ?????????????????????????????????
        let g:gutentags_ctags_tagfile = '.tags'

        " ?????????????????? tags ?????????????????? ~/.cache/tags ????????????????????????????????????
        let s:vim_tags = expand('~/.cache/tags')
        let g:gutentags_cache_dir = s:vim_tags

        " ?????? ctags ?????????
        let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
        let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
        let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

        " ?????? ~/.cache/tags ??????????????????
        if !isdirectory(s:vim_tags)
        silent! call mkdir(s:vim_tags, 'p')
        endif
      ]])
    end,
  }

  use {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    opt = true,
    wants = { "LuaSnip" },
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
    },
    config = [[require("config.completion")]],
  }

  use {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "InsertEnter" },
    opt = true,
    wants = {
      "cmp-nvim-lsp",
      "nvim-lsp-installer",
    },
    requires = {
      'williamboman/nvim-lsp-installer',
    },
    config = [[require("config.lsp")]],
  }

  return packer
end

local M = setmetatable({}, {
  __index = function(_, key)
    local packer = startup()
    return packer[key]
  end
})

return M
