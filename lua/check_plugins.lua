local M = {}

local function repo_url_to_path(url)
  local owner, repo = url:match("github%.com/([^/]+)/([^/]+)")
  if not owner then
    owner, repo = url:match("([^/]+)/([^/]+)$")
  end
  if repo then
    repo = repo:gsub("%.git$", "")
  end
  return owner and repo and (owner .. "/" .. repo) or nil
end

local function extract_github_repos(plugins)
  local repos = {}
  local seen = {}
  for _, plugin in ipairs(plugins) do
    local url = plugin.url or plugin[1] or ""
    local path = repo_url_to_path(url)
    if path and not seen[path] then
      seen[path] = true
      repos[#repos + 1] = { path = path, name = path }
    end
  end
  return repos
end

local function parse_pushed_at(json)
  local ok, data = pcall(vim.json.decode, json)
  if not ok or not data then
    return nil, "parse error"
  end
  if data.message then
    return nil, data.message
  end
  return data.pushed_at, nil
end

local function format_date(iso_str)
  if not iso_str then
    return "unknown"
  end
  local pushed = vim.fn.strptime("%Y-%m-%dT%H:%M:%SZ", iso_str)
  if pushed == 0 then
    return iso_str
  end
  return os.date("%Y-%m-%d", pushed)
end

local function classify(iso_str)
  if not iso_str then
    return "unknown", ""
  end
  local pushed = vim.fn.strptime("%Y-%m-%dT%H:%M:%SZ", iso_str)
  local years = (os.time() - pushed) / 31557600
  if years >= 3 then
    return "3+ years", "E"
  elseif years >= 1 then
    return "1-3 years", "W"
  else
    return "active", ""
  end
end

local function make_item(repo, results, errors)
  local pushed = results[repo.path]
  local err = errors[repo.path]
  local date_str = format_date(pushed)
  local status, qf_type = err and err or not pushed and "fetching..." or classify(pushed)
  if qf_type == "" and err then
    qf_type = "E"
  end
  return {
    text = string.format("%-40s  %-12s  %s", repo.name, date_str, status),
    valid = 0,
    type = qf_type,
  }
end

local function update_qflist(repos, results, errors)
  local items = {}
  for _, repo in ipairs(repos) do
    items[#items + 1] = make_item(repo, results, errors)
  end
  table.sort(items, function(a, b)
    -- errors to top, then by date
    if a.type == "E" and b.type ~= "E" then return true end
    if a.type ~= "E" and b.type == "E" then return false end
    return a.text > b.text
  end)
  vim.fn.setqflist({}, "r", { title = "Plugin Updates", items = items })
end

function M.check()
  local ok, lazy = pcall(require, "lazy")
  if not ok then
    vim.notify("lazy.nvim not found", vim.log.levels.ERROR)
    return
  end

  local all_plugins = lazy.plugins()
  local repos = extract_github_repos(all_plugins)

  if #repos == 0 then
    vim.notify("No GitHub plugins found", vim.log.levels.WARN)
    return
  end

  local results = {}
  local errors = {}
  local pending = #repos

  -- Open quickfix with initial "fetching..." state
  update_qflist(repos, results, errors)
  vim.cmd("copen")

  for _, repo in ipairs(repos) do
    local url = "https://api.github.com/repos/" .. repo.path
    vim.system({ "curl", "-s", "--max-time", "10", url }, { text = true }, function(out)
      local pushed, err = parse_pushed_at(out.stdout)
      if pushed then
        results[repo.path] = pushed
      else
        errors[repo.path] = err or "unknown error"
      end

      pending = pending - 1
      vim.schedule(function()
        update_qflist(repos, results, errors)
      end)
    end)
  end
end

vim.api.nvim_create_user_command("CheckPlugins", function()
  M.check()
end, {})

return M
