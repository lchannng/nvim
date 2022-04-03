--[[--
File  : telescope.lua
Author: lchannng <l.channng@gmail.com>
Date  : 2022/04/02 19:54:47
--]]--

require('telescope').setup {
  defaults = {
    sorting_strategy = "ascending",
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
}

local keymaps = require("keymaps")
keymaps.noremap('<leader>ff', '<cmd>Telescope find_files<CR>')
keymaps.noremap('<leader>fg', '<cmd>Telescope live_grep<CR>')
keymaps.noremap('<leader>fb', '<cmd>Telescope buffers<CR>')
keymaps.noremap('<leader>fh', '<cmd>Telescope help_tags<CR>')
keymaps.noremap('<leader>fl', '<cmd>Telescope current_buffer_fuzzy_find<CR>')
keymaps.noremap('<leader>km', '<cmd>Telescope keymaps<CR>')
keymaps.noremap('<leader>fr', '<cmd>Telescope lsp_references<CR>')
keymaps.noremap('<leader>fd', '<cmd>Telescope lsp_document_symbols<CR>')
keymaps.noremap('<leader>fw', '<cmd>Telescope lsp_workspace_symbols<CR>')
