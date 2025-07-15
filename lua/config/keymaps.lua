-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local vim = vim
local keymap = vim.keymap

keymap.set('n', '<C-a>', '<C-b>')

-- Move to window using the <ctrl> movement keys
keymap.set('n', '<C-Left>', '<C-w>h')
keymap.set('n', '<C-Down>', '<C-w>j')
keymap.set('n', '<C-Up>', '<C-w>k')
keymap.set('n', '<C-Right>', '<C-w>l')

-- Resize window using <shift> arrow keys
keymap.set('n', '<S-Up>', ':resize +4<CR>', { noremap = true })
keymap.set('n', '<S-Down>', ":resize -4<CR>", { noremap = true })
keymap.set('n', '<S-Left>', ":vertical resize -4<CR>", { noremap = true })
keymap.set('n', '<S-Right>', ":vertical resize +4<CR>", { noremap = true })

-- Clear search with <esc>
keymap.set('', '<esc>', ':noh<cr>')
keymap.set('n', 'gw', '*N', { noremap = true })
keymap.set('x', 'gw', '*N', { noremap = true })

keymap.set('n', '<Left>', '<cmd>bprev<cr>', { noremap = true })
keymap.set('n', '<Right>', '<cmd>bnext<cr>', { noremap = true })

-- Remap VIM 0 to first non-blank character
keymap.set('n', '0', '^', { noremap = true })

-- Edit file
keymap.set('n', '<leader>e', ':e <c-r>=expand("%:p:h")<cr>/')

-- Tabs
keymap.set('n', '<leader>tn', '<cmd>tabnew<cr>/')
keymap.set('n', '<leader>to', '<cmd>tabonly<cr>/')
keymap.set('n', '<leader>tc', '<cmd>tabclose<cr>/')

-- Delete trailing space
keymap.set('n', '<F12>', [[:%s/\s\+$//e<cr>]])

-- Pairing
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
