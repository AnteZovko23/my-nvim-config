
return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "echasnovski/mini.icons" }, -- or devicons
  -- Prevent netrw from hijacking when opening a directory (optional but helps)
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- ====== Header (clean ASCII, no weird glyphs) ======
    dashboard.section.header.val = {
      " ",
      "   ███╗   ██╗██╗   ██╗██╗███╗   ███╗ ",
      "   ████╗  ██║██║   ██║██║████╗ ████║ ",
      "   ██╔██╗ ██║██║   ██║██║██╔████╔██║ ",
      "   ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "   ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "   ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      " ",
    }
    dashboard.section.header.opts.hl = "AlphaHeader"

    -- Explorer button: prefers Neo-tree → NvimTree → netrw
    local function has(name)
      return require("lazy.core.config").plugins[name] ~= nil
    end
    local explorer_toggle = (has("neo-tree.nvim") and "<cmd>Neotree toggle<CR>")
      or (has("nvim-tree.lua") and "<cmd>NvimTreeToggle<CR>")
      or "<cmd>Ex<CR>"

    dashboard.section.buttons.val = {
      dashboard.button("n", "  New file", "<cmd>ene | startinsert<CR>"),
      dashboard.button("f", "  Find file", "<cmd>Telescope find_files<CR>"),
      dashboard.button("r", "  Recent", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("g", "  Live grep", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("e", "  Explorer", explorer_toggle),
      dashboard.button(
        "s",
        "  Restore Session",
        has("persistence.nvim") and "<cmd>lua require('persistence').load()<CR>" or "<cmd>SessionRestore<CR>"
      ),
      dashboard.button("u", "󰚰  Update Plugins", "<cmd>Lazy sync<CR>"),
      dashboard.button("q", "  Quit", "<cmd>qa<CR>")
    }
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.buttons.opts.hl_shortcut = "AlphaShortcut"

    -- Footer with Lazy stats (updated once UI is ready)
    local function footer()
      local ok, lazy = pcall(require, "lazy")
      if not ok then return "" end
      local stats = lazy.stats()
      local ms = math.floor((stats.startuptime or 0) * 100 + 0.5) / 100
      return ("⚡ %d/%d plugins in %sms"):format(stats.loaded or 0, stats.count or 0, ms)
    end
    dashboard.section.footer.val = footer()
    dashboard.section.footer.opts.hl = "AlphaFooter"

    dashboard.opts.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 1 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    -- Apply
    require("alpha").setup(dashboard.opts)

    -- ====== Tidy highlights ======
    vim.api.nvim_set_hl(0, "AlphaHeader", { link = "Title" })
    vim.api.nvim_set_hl(0, "AlphaButtons", { link = "Function" })
    vim.api.nvim_set_hl(0, "AlphaShortcut", { link = "Identifier" })
    vim.api.nvim_set_hl(0, "AlphaFooter", { link = "Comment" })

    -- ====== Make Alpha appear on `nvim` AND `nvim .` ======
    -- Handles: no args OR exactly one arg that is a directory.
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        local argc = vim.fn.argc(-1)
        local argv = vim.fn.argv()
        local is_dir_start = (argc == 1 and vim.fn.isdirectory(argv[1]) == 1)

        if argc == 0 or is_dir_start then
          vim.schedule(function()
            if is_dir_start then
              pcall(vim.cmd, "cd " .. vim.fn.fnameescape(argv[1]))
              -- ensure a clean scratch buffer so Alpha can take over
              pcall(vim.cmd, "enew")
            end
            pcall(vim.cmd, "Alpha")
          end)
        end
      end,
    })

    -- ====== Stop the "melting" effect in Alpha ======
    -- This disables mini.animate (and similar) only for the Alpha buffer.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        vim.b.minianimate_disable = true
        vim.b.miniindentscope_disable = true
        -- optional: hide UI chrome while on dashboard
        vim.opt_local.laststatus = 0
        vim.opt_local.showtabline = 0
      end,
    })
    -- restore UI after leaving
    vim.api.nvim_create_autocmd("BufUnload", {
      pattern = "<buffer>",
      callback = function()
        vim.opt.laststatus = 3
        vim.opt.showtabline = 2
      end,
    })

    -- Update footer after Lazy finished computing startup time
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      once = true,
      callback = function()
        require("alpha.themes.dashboard").section.footer.val = footer()
        pcall(alpha.redraw)
      end,
    })
  end,
}

