--[[--
File  : keybinds.lua
Author: lchannng <l.channng@gmail.com>
Date  : 2022/03/31 10:55:47
--]]--

local function mapper(mode, noremap)
  return function(lhs, rhs, opts)
    opts = opts or {}
    opts.noremap = noremap
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end

local nmap = mapper('n', false)
local noremap = mapper('n', true)
local vmap = mapper('v', false)
local vnoremap = mapper('v', true)

-- Paste mode
vim.o.pastetoggle="<F5>"

-- cancel highlight
noremap('<leader>h', ':nohlsearch<CR>')

-- Useful mappings for managing buffers
noremap('<leader>e', ':e <C-r>=expand("%:p:h")<CR>/')
noremap('<Left>', ':bprev<CR>')
noremap('<Right>', ':bnext<CR>')
-- noremap("<leader>bd", ":Bclose<CR>")
noremap("<leader>bd", ":bprev<CR>:bdelete #<CR>")
noremap("<leader>ba", ":1,$bdelete!<CR>")

-- Useful mappings for managing tabs
noremap('<leader>tn', ':tabnew<CR>')
noremap('<leader>to', ':tabonly<CR>')
noremap('<leader>tc', ":tabclose<CR>")
noremap('<F7>', ':tabprev<CR>')
noremap('<F8>', ':tabnext<CR>')
noremap('<leader>te', ':tabedit <C-r>=expand("%:p:h")<CR>/')

-- Delete trailing white space by pressing <F12>
noremap('<F12>', ":call DeleteTrailingWS()<CR>")

-- Remove the Windows ^M - when the encodings gets messed up
noremap('<leader>m', 'mmHmt:%s/<C-V><CR>//ge<CR>"tzt"m')

-- Replace "\t" with spaces
noremap('<Leader>t', ':%s/\t/    /ge')

-- Remap VIM 0 to first non-blank character
noremap('0', '^')

-- Search
vnoremap('*', ':call VisualSelection("f")<CR>')
vnoremap('#', ':call VisualSelection("b")<CR>')

-- Search and replace the selected text
vnoremap('<leader>r', ':call VisualSelection("replace")<CR>')

-- Vimgrep after the selected text
vnoremap('gv', ':call VisualSelection("gv")<CR>')

-- Delete trailing white space on save, useful for Python and CoffeeScript ;)
vim.cmd([[
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
]])

-- 插入匹配括号
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

vim.cmd([[
function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction) range
   let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
]])

return {
  nmap = nmap,
  noremap = noremap,
  vmap = vmap,
  vnoremap = vnoremap,
}
