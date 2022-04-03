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

