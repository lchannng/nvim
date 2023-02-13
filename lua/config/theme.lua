--[[--
File  : theme.lua
Author: lchannng <l.channng@gmail.com>
Date  : 2022/04/03 10:42:26
--]]--

local vim = vim
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
  local no_italic = {
    underline = false,
    undercurl = false,
    italic = false
  }
  require('bufferline').setup({
      options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        indicator = {
          icon = '',
          style = 'none',
        },
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
end

function M.lualine()
  local file_component = {
    'filename',
    path = 1,
  }
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
        lualine_c = {
          file_component,
        },
      },
      inactive_sections = {
        lualine_c = {
          file_component,
        },
      }
    })
end

function M.nvim_tree()
  require'nvim-tree'.setup {
    update_focused_file = {
      enable = true,
    },
    renderer = {
      icons = {
        webdev_colors = false,
        show = {
          file = false,
          folder = false,
          folder_arrow = false,
          git = true,
        }
      }
    },
  }
end

return M
