-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local vim = vim
local cmd = vim.cmd
local g = vim.g
local o = vim.o

g.do_filetype_lua = 1
-- g.did_load_filetypes = 0

-- don't load the plugins below
-- g.loaded_gzip = 1
-- g.loaded_fzf = 1
-- g.loaded_tar = 1
-- g.loaded_tarPlugin = 1
-- g.loaded_zipPlugin = 1
-- g.loaded_2html_plugin = 1
-- g.loaded_netrw = 1
-- g.loaded_netrwPlugin = 1
-- g.loaded_matchit = 1
--g.loaded_matchparen = 1

-- 自动缩进
o.autoindent = true
o.smartindent = true
o.cindent = true

-- Disable mouse mode
o.mouse = ""

-- 设置 Backspace 键模式
o.backspace = "eol,start,indent"

-- 设置缩进宽度
o.shiftwidth = 4

-- 设置 TAB 宽度
o.tabstop = 4

-- 如果后面设置了 expandtab 那么展开 tab 为多少字符
o.softtabstop = 4

-- Use spaces instead of tabs
o.expandtab = true

-- Be smart when using tabs ;)
o.smarttab = true

-- Wrap lines
o.wrap = true

-- Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
o.winaltkeys = "no"

-- 打开功能键超时检测（终端下功能键为一串 ESC 开头的字符串）
o.ttimeout = true

-- 功能键超时检测 50 毫秒
o.ttimeoutlen = 30

-- 显示光标位置
o.ruler = true

-- 在处理未保存或只读文件的时候，弹出确认
o.confirm = true

-- o.to auto read when a file is changed from the outside
o.autoread = true

-- No annoying sound on errors
o.errorbells = false
o.visualbell = true

-- 搜索时忽略大小写
o.ignorecase = true

-- 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写字母
o.smartcase = true

-- 高亮搜索内容
o.hlsearch = true

-- 查找输入时动态增量显示查找结果
o.incsearch = true

-- 内部工作编码
o.encoding = "utf-8"

-- 文件默认编码
o.fileencoding = "utf-8"

-- 打开文件时自动尝试下面顺序的编码
o.fileencodings = "ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin"

-- 文件换行符，默认使用 unix 换行符
o.fileformats = "unix,dos,mac"

-- 允许备份
o.backup = true

-- 保存时备份
o.writebackup = true

-- 设置 tags：当前文件所在目录往上向根目录搜索直到碰到 .tags 文件
-- 或者 Vim 当前目录包含 .tags 文件
o.tags = "./.tags;,.tags"

-- 备份文件地址，统一管理
o.backupdir = vim.fn.stdpath("data") .. "/tmp"

vim.fn.mkdir(o.backupdir, "p", "0700")

-- 备份文件扩展名
o.backupext = ".bak"

-- 禁用交换文件
o.swapfile = false

-- enable undo file
o.undofile = true
o.undolevels = 1000

-- 显示匹配的括号
o.showmatch = true

-- 显示括号匹配的时间
o.matchtime = 2

-- 显示最后一行
o.display = "lastline"

-- 允许下方显示目录
o.wildmenu = true

-- 延迟绘制（提升性能）
o.lazyredraw = true

-- Specify the behavior when switching between buffers
o.switchbuf = "useopen,usetab,newtab"
o.showtabline = 2

-- The last window always have a status line
o.laststatus = 2

-- Show line number
o.number = true

-- Show (partial) command in the last line of the screen
o.showcmd = true

-- Put new windows right of current
o.splitright = true

-- Put new windows below current
o.splitbelow = true

-- Highlight the text line of the cursor
o.cursorline = true

vim.cmd([[
" Remember info about open buffers on close
set viminfo^=%

" 允许 Vim 自带脚本根据文件类型自动设置缩进等
if has('autocmd')
  filetype plugin indent on
endif

if has('syntax')
  syntax enable
  syntax on
endif

" 设置分隔符可视
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<

"----------------------------------------------------------------------
" 文件搜索和补全时忽略下面扩展名
"----------------------------------------------------------------------
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class

set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz    " MacOSX/Linux
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android
]])
