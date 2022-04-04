--[[--
File  : init.lua
Author: lchannng <l.channng@gmail.com>
Date  : 2022/03/27 23:06:24
--]]--

pcall(function() require("impatient").enable_profile() end)
require("options")
-- require("plugins")

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end

  command! PackerInstall lua require('plugins').install()
  command! PackerUpdate lua require('plugins').update()
  command! PackerSync lua require('plugins').sync()
  command! PackerClean lua require('plugins').clean()
  command! PackerCompile lua require('plugins').compile()
  command! PackerStatus lua require('plugins').status()
]])

