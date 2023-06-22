return {
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "darker",
      term_colors = true,

      -- Options are italic, bold, underline, none
      code_style = {
        comments = "none",
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = function()
      local no_italic = {
        underline = false,
        undercurl = false,
        italic = false,
      }
      return {
        options = {
          mode = "buffers", -- set to "tabs" to only show tabpages instead
          indicator = {
            icon = "",
            style = "none",
          },
          show_buffer_icons = false, -- disable filetype icons for buffers
          show_buffer_close_icons = false,
          show_close_icon = false,
          -- always_show_bufferline = false,
        },
        highlights = {
          buffer_selected = no_italic,
          duplicate_selected = no_italic,
          duplicate_visible = no_italic,
          duplicate = no_italic,
        },
      }
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local file_component = {
        "filename",
        path = 1,
      }
      return {
        options = {
          theme = "auto",
          icons_enabled = false,
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        },
        sections = {
          lualine_b = {
            "branch",
            {
              "diff",
              diff_color = {
                removed = { fg = "#ff0000" },
              },
            },
            "diagnostics",
          },
          lualine_c = {
            file_component,
          },
        },
        inactive_sections = {
          lualine_c = {
            file_component,
          },
        },
      }
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "│",
      filetype_exclude = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },

  -- dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
            ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
            ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
            ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
            ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
            ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
            ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
            ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", "<CMD>Telescope find_files <CR>"),
        dashboard.button("n", " " .. " New file", "<CMD>ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", "<CMD>Telescope oldfiles <CR>"),
        dashboard.button("g", " " .. " Find text", "<CMD>Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", "<CMD>e $MYVIMRC <CR>"),
        dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
        dashboard.button("l", "󰒲 " .. " Lazy", "<CMD>Lazy<CR>"),
        -- dashboard.button("q", " " .. " Quit", "<CMD>qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      local Lazy = require("lazy")
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            Lazy.show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = Lazy.stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },

  -- icons
  -- { "nvim-tree/nvim-web-devicons", lazy = true },
}
