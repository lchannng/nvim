--[[--
File  : keys.lua
Author: lchannng <l.channng@gmail.com>
Date  : 2022/04/03 14:44:54
--]]--

local wk = require("which-key")
local util = require("util")

-- Move to window using the <ctrl> movement keys
util.nmap("<C-Left>", "<C-w>h")
util.nmap("<C-Down>", "<C-w>j")
util.nmap("<C-Up>", "<C-w>k")
util.nmap("<C-Right>", "<C-w>l")

-- Resize window using <ctrl> arrow keys
util.nnoremap("<S-Up>", ":resize +4<CR>")
util.nnoremap("<S-Down>", ":resize -4<CR>")
util.nnoremap("<S-Left>", ":vertical resize -4<CR>")
util.nnoremap("<S-Right>", ":vertical resize +4<CR>")

-- Clear search with <esc>
util.map("", "<esc>", ":noh<cr>")
util.nnoremap("gw", "*N")
util.xnoremap("gw", "*N")

-- buffers
util.nmap("<leader>e", ':e <c-r>=expand("%:p:h")<cr>/')
wk.register({
  ['<Left>'] = {'<cmd>bprev<cr>', "Previous Buffer"},
  ['<Right>'] = {'<cmd>bnext<cr>', "Next Buffer"},

  ["<leader>b"] = { name = "+buffer" },
  ["<leader>bd"] = { '<cmd>BDelete this<cr>', "Delete Buffer" },
  ["<leader>ba"] = { '<cmd>BDelete all<cr>', "Delete All Buffer" },
})

for i = 0, 9 do
  local lhs = string.format("<leader>%d", i)
  local rhs = string.format("<cmd>BufferLineGoToBuffer %d<CR>", i)
  util.nnoremap(lhs, rhs)
end

-- tabs
wk.register({
  ['<F7>'] = { '<cmd>tabprev<cr>', "Previous Tab" },
  ['<F8>'] = { '<cmd>tabnext<cr>', "Next Tab" },

  ['<leader>t'] = { name = "+tab" },
  ['<leader>tn'] = { '<cmd>tabnew<cr>', "New Tab" },
  ['<leader>to'] = { '<cmd>tabonly<cr>', "Merge to One Tab" },
  ['<leader>tc'] = { '<cmd>tabclose<cr>', "Close Tab" },
})

-- searching
wk.register({
    ['<leader>s'] = { name = "+searching" },
    ['<leader>sf'] = { '<cmd>Telescope find_files<CR>', "Fine files" },
    ['<leader>sg'] = { '<cmd>Telescope live_grep<CR>', "Grep in files" },
    ['<leader>sb'] = { '<cmd>Telescope buffers<CR>', "List Buffers" },
    ['<leader>sh'] = { '<cmd>Telescope help_tags<CR>', "Find tags" },
    ['<leader>sl'] = { '<cmd>Telescope current_buffer_fuzzy_find<CR>', "Find in current buffer" },
    ['<leader>sm'] = { '<cmd>Telescope keymaps<CR>', "List keymaps" },
    ['<leader>sr'] = { '<cmd>Telescope lsp_references<CR>', "Find refrences" },
    ['<leader>ss'] = { '<cmd>Telescope lsp_document_symbols<CR>', "List symbols in current file" },
    ['<leader>sw'] = { '<cmd>Telescope lsp_workspace_symbols<CR>', "List symbles in workspace" },
})

-- lsp

-- gitsigns
wk.register({
  ['<leader>g'] = { name = "+gitsigns" },
  ['<leader>gb'] = { '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', "Git Blame"},
})

-- misc
wk.register({
  ['0'] = { '^', "Remap VIM 0 to first non-blank character" },
  ['<F3>'] = { '<cmd>NvimTreeToggle<cr>', "nvim-tree toggle" },
  ['<F4>'] = { '<cmd>NvimTreeRefresh<cr>', "nvim-tree refresh" },
  ['<F9>'] = { '<cmd>PackerCompile<cr>', "" },
  ['<F10>'] = { '<cmd>PackerSync<cr>', "" },
  ['<F12>'] = { '<cmd>call DeleteTrailingWS()<cr>', "Delete trailing white space" },
  ['<leader>h'] = { "<cmd>nohlsearch<cr>", "Cancel Highlight" },
})

wk.register({
  ['<leader>r'] = { "<cmd>call g:VReplace()<cr>", "Replace the selected text" },
}, {mode = "v", })

-- ignore
local ignore = {}
for i = 0, 10 do
  ignore[tostring(i)] = "which_key_ignore"
end
wk.register(ignore)

-- delete trailing white space on save, useful for Python and CoffeeScript ;)
vim.cmd([[
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
]])

-- pairing
vim.cmd([[
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf
]])

-- makes * and # work on visual mode too.
vim.api.nvim_exec(
  [[
  function! g:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction
  xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
]],
  false
)

vim.cmd([[
function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! g:VReplace()
   let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    call CmdLine("%s" . '/'. l:pattern . '/')
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
]])
