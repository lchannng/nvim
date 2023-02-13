--[[--
File  : completion.lua
Author: lchannng <l.channng@gmail.com>
Date  : 2022/04/02 19:19:43
--]] --

local vim = vim

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.complete(),
    -- ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer',
      option = {
        get_bufnrs = function()
          local bufs = {}
          local api = vim.api
          for _, win in ipairs(api.nvim_list_wins()) do
            local buf = api.nvim_win_get_buf(win)
            if buf then
              local byte_size = api.nvim_buf_get_offset(buf, api.nvim_buf_line_count(buf))
              if byte_size < 1024 * 1024 then -- 1 Megabyte max
                bufs[buf] = true
              end
            end
          end
          return vim.tbl_keys(bufs)
        end
      }
    },
    { name = 'nvim_lua' },
  },
}
