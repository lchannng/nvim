-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = true
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/lchannng/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/lchannng/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/lchannng/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/lchannng/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/lchannng/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\n�\2\0\0\5\0\r\0\0165\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\5\0005\4\4\0=\4\6\0035\4\a\0=\0\b\4=\0\t\4=\0\n\4=\0\v\4=\4\f\3B\1\2\1K\0\1\0\15highlights\14duplicate\22duplicate_visible\23duplicate_selected\20buffer_selected\1\0\0\foptions\1\0\0\1\0\5\22show_buffer_icons\1\19indicator_icon\5\tmode\fbuffers\20show_close_icon\1\28show_buffer_close_icons\1\nsetup\15bufferline\frequire\1\0\1\bgui\tnone\0" },
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["close-buffers.nvim"] = {
    commands = { "BDelete" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/opt/close-buffers.nvim",
    url = "https://github.com/kazhala/close-buffers.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nB\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\21indent_blankline\frequire\0" },
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n�\2\0\0\b\0\19\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\16\0005\4\n\0005\5\v\0005\6\r\0005\a\f\0=\a\14\6=\6\15\5>\5\2\4=\4\17\3=\3\18\2B\0\2\1K\0\1\0\rsections\14lualine_b\1\0\0\15diff_color\fremoved\1\0\0\1\0\1\afg\f#ff0000\1\2\0\0\tdiff\1\4\0\0\vbranch\0\16diagnostics\foptions\1\0\0\23section_separators\1\0\2\tleft\5\nright\5\25component_separators\1\0\2\tleft\5\nright\5\1\0\2\ntheme\tauto\18icons_enabled\1\nsetup\flualine\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-cmp"] = {
    after = { "nvim-lspconfig" },
    loaded = true,
    only_config = true
  },
  ["nvim-lspconfig"] = {
    config = { 'require("config.lsp")' },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n�\1\0\0\3\0\a\0\v6\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14nvim-tree\frequire\1\0\4\18folder_arrows\3\1\ffolders\3\0\nfiles\3\1\bgit\3\1\25nvim_tree_show_icons\6g\bvim\0" },
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["onedark.nvim"] = {
    after = { "lualine.nvim" },
    loaded = true,
    only_config = true
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { 'require("config.telescope")' },
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["vim-gutentags"] = {
    config = { "\27LJ\2\n�\a\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0�\6        \" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归\n        let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']\n\n        \" 所生成的数据文件的名称\n        let g:gutentags_ctags_tagfile = '.tags'\n\n        \" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录\n        let s:vim_tags = expand('~/.cache/tags')\n        let g:gutentags_cache_dir = s:vim_tags\n\n        \" 配置 ctags 的参数\n        let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']\n        let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']\n        let g:gutentags_ctags_extra_args += ['--c-kinds=+px']\n\n        \" 检测 ~/.cache/tags 不存在就新建\n        if !isdirectory(s:vim_tags)\n        silent! call mkdir(s:vim_tags, 'p')\n        endif\n      \bcmd\bvim\0" },
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/vim-gutentags",
    url = "https://github.com/ludovicchabant/vim-gutentags"
  },
  ["vim-header"] = {
    config = { "\27LJ\2\n�\3\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0�\2        let g:header_auto_add_header = 1\n        let g:header_field_author = 'lchannng'\n        let g:header_field_author_email = 'l.channng@gmail.com'\n        let g:header_field_filename_path = 0\n        let g:header_field_modified_timestamp = 0\n        let g:header_field_modified_by = 0\n        let g:header_field_timestamp_format = '%Y/%m/%d %H:%M:%S'\n      \bcmd\bvim\0" },
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/vim-header",
    url = "https://github.com/lchannng/vim-header"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/vim-polyglot",
    url = "https://github.com/sheerun/vim-polyglot"
  },
  ["vim-startuptime"] = {
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["which-key.nvim"] = {
    config = { 'require("config.keys")' },
    loaded = true,
    path = "/home/lchannng/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
require("config.keys")
time([[Config for which-key.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
require("config.completion")
time([[Config for nvim-cmp]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n�\1\0\0\3\0\a\0\v6\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14nvim-tree\frequire\1\0\4\18folder_arrows\3\1\ffolders\3\0\nfiles\3\1\bgit\3\1\25nvim_tree_show_icons\6g\bvim\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\nB\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\21indent_blankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
try_loadstring("\27LJ\2\n�\2\0\0\5\0\r\0\0165\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\5\0005\4\4\0=\4\6\0035\4\a\0=\0\b\4=\0\t\4=\0\n\4=\0\v\4=\4\f\3B\1\2\1K\0\1\0\15highlights\14duplicate\22duplicate_visible\23duplicate_selected\20buffer_selected\1\0\0\foptions\1\0\0\1\0\5\22show_buffer_icons\1\19indicator_icon\5\tmode\fbuffers\20show_close_icon\1\28show_buffer_close_icons\1\nsetup\15bufferline\frequire\1\0\1\bgui\tnone\0", "config", "bufferline.nvim")
time([[Config for bufferline.nvim]], false)
-- Config for: vim-gutentags
time([[Config for vim-gutentags]], true)
try_loadstring("\27LJ\2\n�\a\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0�\6        \" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归\n        let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']\n\n        \" 所生成的数据文件的名称\n        let g:gutentags_ctags_tagfile = '.tags'\n\n        \" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录\n        let s:vim_tags = expand('~/.cache/tags')\n        let g:gutentags_cache_dir = s:vim_tags\n\n        \" 配置 ctags 的参数\n        let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']\n        let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']\n        let g:gutentags_ctags_extra_args += ['--c-kinds=+px']\n\n        \" 检测 ~/.cache/tags 不存在就新建\n        if !isdirectory(s:vim_tags)\n        silent! call mkdir(s:vim_tags, 'p')\n        endif\n      \bcmd\bvim\0", "config", "vim-gutentags")
time([[Config for vim-gutentags]], false)
-- Config for: vim-header
time([[Config for vim-header]], true)
try_loadstring("\27LJ\2\n�\3\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0�\2        let g:header_auto_add_header = 1\n        let g:header_field_author = 'lchannng'\n        let g:header_field_author_email = 'l.channng@gmail.com'\n        let g:header_field_filename_path = 0\n        let g:header_field_modified_timestamp = 0\n        let g:header_field_modified_by = 0\n        let g:header_field_timestamp_format = '%Y/%m/%d %H:%M:%S'\n      \bcmd\bvim\0", "config", "vim-header")
time([[Config for vim-header]], false)
-- Config for: onedark.nvim
time([[Config for onedark.nvim]], true)
try_loadstring("\27LJ\2\n�\4\0\0\5\0\n\0\0156\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\3B\1\2\0019\1\6\0B\1\1\0016\1\a\0009\1\b\1'\3\t\0B\1\2\1K\0\1\0�\2    if has(\"gui_running\")\n        set guioptions-=T\n        set guioptions+=e\n        set guitablabel=%M\\ %t\n        set lines=36 columns=108    \" 设定窗口大小\n        if has(\"win32\")\n            set guifont=Dejavu_Sans_Mono:h10     \" 字体 && 字号\n        else\n            set guifont=Dejavu\\ Sans\\ Mono\\ 11     \" 字体 && 字号\n        endif\n    endif\n  \bcmd\bvim\tload\15code_style\1\0\1\rcomments\tnone\1\0\2\16term_colors\2\nstyle\vdarker\nsetup\fonedark\frequire\0", "config", "onedark.nvim")
time([[Config for onedark.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require("config.telescope")
time([[Config for telescope.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-lspconfig ]]

-- Config for: nvim-lspconfig
require("config.lsp")

vim.cmd [[ packadd lualine.nvim ]]

-- Config for: lualine.nvim
try_loadstring("\27LJ\2\n�\2\0\0\b\0\19\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\16\0005\4\n\0005\5\v\0005\6\r\0005\a\f\0=\a\14\6=\6\15\5>\5\2\4=\4\17\3=\3\18\2B\0\2\1K\0\1\0\rsections\14lualine_b\1\0\0\15diff_color\fremoved\1\0\0\1\0\1\afg\f#ff0000\1\2\0\0\tdiff\1\4\0\0\vbranch\0\16diagnostics\foptions\1\0\0\23section_separators\1\0\2\tleft\5\nright\5\25component_separators\1\0\2\tleft\5\nright\5\1\0\2\ntheme\tauto\18icons_enabled\1\nsetup\flualine\frequire\0", "config", "lualine.nvim")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file BDelete lua require("packer.load")({'close-buffers.nvim'}, { cmd = "BDelete", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

if should_profile then save_profiles(0) end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
