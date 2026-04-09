local vim = vim
local kopts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, kopts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, kopts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, kopts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, kopts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

local servers
if vim.env.VIM_IDE then
  servers = {
    bashls = {},
    clangd = {},
    cmake = {},
    gopls = {},
    jsonls = {
      -- lazy-load schemastore when needed
      before_init = function(_, new_config)
        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
      end,
      settings = {
        json = {
          format = {
            enable = true,
          },
          validate = { enable = true },
        },
      },
    },
    lua_ls = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          format = {
            enable = true,
          },
        },
      },
    },
    pyright = {
      on_init = function(client)
        local root = client.root_dir or vim.fn.getcwd()
        local venv_python = root .. "/.venv/bin/python"
        if vim.fn.filereadable(venv_python) == 1 then
          vim.notify("UV venv detected: " .. venv_python, vim.log.levels.INFO)
          client.config.settings.python = client.config.settings.python or {}
          client.config.settings.python.pythonPath = venv_python
        end
      end,
    },
    rust_analyzer = {},
    ts_ls = {},
  }
else
  servers = {}
end

return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "b0o/schemastore.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("util").has("nvim-cmp")
        end,
      },
    },
    opts = {
      servers = servers,
    },
    config = function(_, opts)
      local Util = require("util")
      Util.on_attach(function(client, buffer)
        on_attach(client, buffer)
      end)

      -- 构建 capabilities (包含 cmp_nvim_lsp)
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities(),
        opts.capabilities or {}
      )

      -- 获取 mason-lspconfig 支持的服务器列表
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(mlsp.get_mappings().lspconfig_to_package)
      end

      local ensure_installed = {}
      for server, server_opts in pairs(opts.servers) do
        server_opts = server_opts == true and {} or server_opts

        -- 合并 capabilities 和服务器特定配置
        local final_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, server_opts)

        -- 使用 vim.lsp.config() 配置服务器 (Neovim 0.11+ API)
        vim.lsp.config(server, final_opts)

        if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
          -- 非 mason 管理的服务器，手动启用
          vim.lsp.enable(server)
        else
          ensure_installed[#ensure_installed + 1] = server
        end
      end

      -- mason-lspconfig 负责安装和自动启用 mason 管理的服务器
      if have_mason then
        mlsp.setup({
          ensure_installed = ensure_installed,
          automatic_enable = true,
        })
      end
    end,
  },
  -- formatters
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = { "mason.nvim" },
  --   opts = function()
  --     local nls = require("null-ls")
  --     return {
  --       root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
  --       sources = {
  --         nls.builtins.formatting.stylua,
  --         -- nls.builtins.formatting.shfmt,
  --       },
  --     }
  --   end,
  -- },

  -- cmdline tools and lsp servers
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",
        -- "shfmt",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}

