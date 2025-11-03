return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  lazy = false,
  opts = function()
    local logo = [[
      ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
      ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
      ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
      ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
      ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#89b4fa", bold = true })
    vim.api.nvim_set_hl(0, "DashboardIcon", { fg = "#f5c2e7", bold = true })
    vim.api.nvim_set_hl(0, "DashboardDesc", { fg = "#cdd6f4" })
    vim.api.nvim_set_hl(0, "DashboardKey", { fg = "#f38ba8", bold = true })
    vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#94e2d5", italic = true })
    vim.api.nvim_set_hl(0, "DashboardShortCut", { fg = "#a6e3a1" })

    local opts = {
      theme = "doom",
      hide = {
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
        week_header = {
          enable = true,
          concat = "  ",
          append = { "", "󰃭 Ready to code!" },
        },
        center = {
          {
            icon = "  ",
            icon_hl = "DashboardIcon",
            desc = "Find File",
            desc_hl = "DashboardDesc",
            key = "f",
            key_hl = "DashboardKey",
            key_format = " [%s]",
            action = "lua LazyVim.pick()()",
          },
          {
            icon = "  ",
            icon_hl = "DashboardIcon",
            desc = "New File",
            desc_hl = "DashboardDesc",
            key = "n",
            key_hl = "DashboardKey",
            key_format = " [%s]",
            action = "ene | startinsert",
          },
          {
            icon = "  ",
            icon_hl = "DashboardIcon",
            desc = "Recent Files",
            desc_hl = "DashboardDesc",
            key = "r",
            key_hl = "DashboardKey",
            key_format = " [%s]",
            action = 'lua LazyVim.pick("oldfiles")()',
          },
          {
            icon = "  ",
            icon_hl = "DashboardIcon",
            desc = "Find Text",
            desc_hl = "DashboardDesc",
            key = "g",
            key_hl = "DashboardKey",
            key_format = " [%s]",
            action = 'lua LazyVim.pick("live_grep")()',
          },
          {
            icon = "  ",
            icon_hl = "DashboardIcon",
            desc = "Config",
            desc_hl = "DashboardDesc",
            key = "c",
            key_hl = "DashboardKey",
            key_format = " [%s]",
            action = "lua LazyVim.pick.config_files()()",
          },
          {
            icon = "  ",
            icon_hl = "DashboardIcon",
            desc = "Restore Session",
            desc_hl = "DashboardDesc",
            key = "s",
            key_hl = "DashboardKey",
            key_format = " [%s]",
            action = 'lua require("persistence").load()',
          },
          {
            icon = "  ",
            icon_hl = "DashboardIcon",
            desc = "Lazy Extras",
            desc_hl = "DashboardDesc",
            key = "x",
            key_hl = "DashboardKey",
            key_format = " [%s]",
            action = "LazyExtras",
          },
          {
            icon = "󰒲  ",
            icon_hl = "DashboardIcon",
            desc = "Lazy",
            desc_hl = "DashboardDesc",
            key = "l",
            key_hl = "DashboardKey",
            key_format = " [%s]",
            action = "Lazy",
          },
          {
            icon = "  ",
            icon_hl = "DashboardIcon",
            desc = "Quit",
            desc_hl = "DashboardDesc",
            key = "q",
            key_hl = "DashboardKey",
            key_format = " [%s]",
            action = function()
              vim.api.nvim_input("<cmd>qa<cr>")
            end,
          },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
          local version = vim.version()
          local nvim_version = "  v" .. version.major .. "." .. version.minor .. "." .. version.patch

          return {
            "",
            "⚡ " .. stats.loaded .. "/" .. stats.count .. " plugins loaded in " .. ms .. "ms",
            nvim_version,
          }
        end,
        vertical_center = true,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 35 - #button.desc)
    end

    if vim.o.filetype == "lazy" then
      vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
          end)
        end,
      })
    end

    return opts
  end,
}
