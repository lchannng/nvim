--[[--
File  : theme.lua
Author: lchannng <l.channng@gmail.com>
Date  : 2022/04/03 10:42:26
--]]--

local M = {}

function M.onedark()
  local onedark = require("onedark")
  onedark.setup({
      style = "darker",
      term_colors = true,

      -- Options are italic, bold, underline, none
      code_style = {
        comments = 'none',
      },
    })
  onedark.load()

  vim.cmd([[
    if has("gui_running")
        set guioptions-=T
        set guioptions+=e
        set guitablabel=%M\ %t
        set lines=36 columns=108    " 设定窗口大小
        if has("win32")
            set guifont=Dejavu_Sans_Mono:h10     " 字体 && 字号
        else
            set guifont=Dejavu\ Sans\ Mono\ 11     " 字体 && 字号
        endif
    endif
  ]])
end

function M.bufferline()
  local no_italic = {gui = "none", }
  require('bufferline').setup({
      options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        indicator_icon = "",
        show_buffer_icons = false, -- disable filetype icons for buffers
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
      highlights = {
        buffer_selected = no_italic,
        duplicate_selected = no_italic,
        duplicate_visible = no_italic,
        duplicate = no_italic,
      },
    })
  local keymaps = require("keymaps")
  for i = 0, 9 do
    local lhs = string.format("<leader>%d", i)
    local rhs = string.format("<cmd>BufferLineGoToBuffer %d<CR>", i)
    keymaps.noremap(lhs, rhs)
  end
end

function M.lualine()
  require('lualine').setup({
      options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
      },
      sections = {
        lualine_b = {
          'branch',
          {
            'diff',
            diff_color = {
              removed = {fg = '#ff0000', },
            },
          },
          'diagnostics'
        },
      },
    })
end

function M.nvim_tree()
  vim.g.nvim_tree_show_icons = {
    git= 1,
    folders= 0,
    files = 1,
    folder_arrows = 1,
  }
  require'nvim-tree'.setup {}
  local keymaps = require("keymaps")
  keymaps.noremap('<F2>', ':NvimTreeToggle<CR>')
  keymaps.noremap('<F3>', ':NvimTreeRefresh<CR>')
end

return M
