local Util = require("util")

return {
  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = Util.get_root() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<F3>",      "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      -- { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)",      remap = true },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
        components = {
          icon = function(config, node, state)
            if node.type == "file" or node.type == "directory" then
              return {}
            end
            return require("neo-tree.sources.common.components").icon(config, node, state)
          end
        }
      },
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "+",
          expander_expanded = "-",
          expander_highlight = "NeoTreeExpander",
        },
        git_status = {
          symbols = {
            deleted = "",
            renamed = "",
            modified = "",
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = ""
          }
        }
      },
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },

  -- search/replace in multiple files
  --[[
  {
    "nvim-pack/nvim-spectre",
    enabled = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
        -- stylua: ignore
        keys = {
            { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
        },
  },
  ]]

  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup({
        resultsSeparatorLineChar = "-",
        icons = {
          enabled = false,
        }
      });
    end,
    keys = {
      { "<leader>sr", "<cmd>GrugFar<cr>", desc = "Replace in files (GrugFar)" },
    },
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      --[[
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        cond = function()
          return vim.fn.executable("cmake") == 1
        end,
      },]]
    },
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        layout_strategy = 'vertical',
        layout_config = { height = 0.95 },
      },
      extensions = {
        --[[
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },]]
      },
    },
    config = function(_, opts)
      local Telescope = require("telescope")
      Telescope.setup(opts)
      -- Telescope.load_extension("fzf")
    end,
    keys = {
      { "<leader>,",       "<cmd>Telescope buffers show_all_buffers=true<cr>",   desc = "Switch Buffer" },
      { "<leader>/",       Util.telescope("live_grep"),                          desc = "Grep (root dir)" },
      { "<leader>:",       "<cmd>Telescope command_history<cr>",                 desc = "Command History" },
      { "<leader><space>", Util.telescope("files"),                              desc = "Find Files (root dir)" },

      -- find
      { "<leader>fb",      "<cmd>Telescope buffers<cr>",                         desc = "Buffers" },
      { "<leader>ff",      Util.telescope("files", { cwd = false }),             desc = "Find Files (cwd)" },
      { "<leader>fF",      Util.telescope("files"),                              desc = "Find Files (root dir)" },
      { "<leader>fr",      Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
      { "<leader>fR",      "<cmd>Telescope oldfiles<cr>",                        desc = "Recent" },

      -- git
      { "<leader>gc",      "<cmd>Telescope git_commits<CR>",                     desc = "Git commits" },
      { "<leader>gs",      "<cmd>Telescope git_status<CR>",                      desc = "Git status" },

      -- search
      { "<leader>sb",      "<cmd>Telescope current_buffer_fuzzy_find<cr>",       desc = "Buffer" },
      { "<leader>sc",      "<cmd>Telescope command_history<cr>",                 desc = "Command History" },
      { "<leader>sd",      "<cmd>Telescope diagnostics bufnr=0<cr>",             desc = "Document diagnostics" },
      { "<leader>sD",      "<cmd>Telescope diagnostics<cr>",                     desc = "Workspace diagnostics" },
      { "<leader>sg",      Util.telescope("live_grep", { cwd = false }),         desc = "Grep (cwd)" },
      { "<leader>sG",      Util.telescope("live_grep"),                          desc = "Grep (root dir)" },
      { "<leader>sh",      "<cmd>Telescope help_tags<cr>",                       desc = "Help Pages" },
      { "<leader>sk",      "<cmd>Telescope keymaps<cr>",                         desc = "Key Maps" },
      { "<leader>sM",      "<cmd>Telescope man_pages<cr>",                       desc = "Man Pages" },
      { "<leader>sm",      "<cmd>Telescope marks<cr>",                           desc = "Jump to Mark" },
      { "<leader>so",      "<cmd>Telescope vim_options<cr>",                     desc = "Options" },
      { "<leader>sw",      Util.telescope("grep_string", { cwd = false }),       desc = "Word (cwd)" },
      { "<leader>sW",      Util.telescope("grep_string"),                        desc = "Word (root dir)" },
      {
        "<leader>ss",
        Util.telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        Util.telescope("lsp_dynamic_workspace_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol (Workspace)",
      },
    },
  },

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "-" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", "<CMD>Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", "<CMD>Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", "<CMD><C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  -- close buffer
  {
    "kazhala/close-buffers.nvim",
    cmd = "BDelete",
    keys = {
      { "<leader>bd", "<CMD>BDelete this<CR>", desc = "Close current buffer" },
      { "<leader>ba", "<CMD>BDelete all<CR>",  desc = "Close all buffers" },
    },
  },

  {
    "RaafatTurki/hex.nvim",
    cmd = "HexDump",
    config = function()
      require 'hex'.setup {

        -- cli command used to dump hex data
        dump_cmd = 'xxd -g 1 -u',

        -- cli command used to assemble from hex data
        assemble_cmd = 'xxd -r',

        -- function that runs on BufReadPre to determine if it's binary or not
        is_file_binary_pre_read = function()
          -- logic that determines if a buffer contains binary data or not
          -- must return a bool
        end,

        -- function that runs on BufReadPost to determine if it's binary or not
        is_file_binary_post_read = function()
          -- logic that determines if a buffer contains binary data or not
          -- must return a bool
        end,
      }
    end,
  },

}
