return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true

    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = true,
        signcolumn = "yes",
      },
      renderer = {
        group_empty = true,
        highlight_git = "all",
        highlight_opened_files = "name",
        indent_markers = {
          enable = true,
          inline_arrows = false,
        },
        icons = {
          web_devicons = {
            folder = { enable = true, color = true },
          },
          git_placement = "signcolumn",
          modified_placement = "right_align",
          show = {
            file = true,
            folder = true,
            folder_arrow = false,
            git = true,
            modified = true,
            diagnostics = true,
            bookmarks = true,
          },
          glyphs = {
            folder = {
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
          },
        },
      },
      modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
      },
      git = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        ignore = false,
        timeout = 400,
      },
      filters = {
        custom = { ".DS_Store" },
        git_ignored = false,
      },
      actions = {
        open_file = {
          window_picker = { enable = false },
        },
      },
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    keymap.set("n", "<leader>ee", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
  end,
}
