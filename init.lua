--[[--
File  : init.lua
Author: lchannng <l.channng@gmail.com>
Date  : 2022/03/27 23:06:24
--]]--

require("options")
require("plugins")

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
