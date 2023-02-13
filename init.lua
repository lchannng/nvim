--[[--
File  : init.lua
Author: lchannng <l.channng@gmail.com>
Date  : 2022/03/27 23:06:24
--]]--

local vim = vim
local fn = vim.fn

function _G.dump(...)
  print(vim.inspect(...))
end

function _G.profile(cmd, times)
  times = times or 100
  local args = {}
  if type(cmd) == "string" then
    args = { cmd }
    cmd = vim.cmd
  end
  local start = vim.loop.hrtime()
  for _ = 1, times, 1 do
    local ok = pcall(cmd, table.unpack(args))
    if not ok then
      error("Command failed: " .. tostring(ok) .. " " .. vim.inspect({ cmd = cmd, args = args }))
    end
  end
  print(((vim.loop.hrtime() - start) / 1000000 / times) .. "ms")
end

function _G.get_config_dir()
  return fn.stdpath("config")
end

function _G.get_runtime_dir()
  return fn.stdpath("data")
end

function _G.get_cache_dir()
  return fn.stdpath("cache")
end

-- pcall(function() require("impatient").enable_profile() end)
require("options")
require("plugins")

