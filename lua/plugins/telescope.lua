return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",

      build = "make",

      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },

    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  config = function()
    require("telescope").setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find  [H]elp" })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    vim.keymap.set("n", "<leader>fw", function()
      builtin.grep_string({
        additional_args = function()
          return { "--glob", "!*.md", "--glob", "!*.txt" }
        end,
      })
    end, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>fg", function()
      builtin.live_grep({
        additional_args = function()
          return { "--glob", "!*.md", "--glob", "!*.txt" }
        end,
      })
    end, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[S]earch [R]esume" })
    vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

    vim.keymap.set("n", "<leader>f/", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, { desc = "[S]earch [/] in Open Files" })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set("n", "<leader>fn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[S]earch [N]eovim files" })

    -- Find folders/directories
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    vim.keymap.set("n", "<leader>fD", function()
      builtin.find_files({
        find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git", "--exclude", "node_modules" },
        prompt_title = "Find Directories",
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
          end)

          local function open_first_file()
            local entry = action_state.get_selected_entry()
            local dir = entry.path or entry.value
            actions.close(prompt_bufnr)
            local first
            for name, type_ in vim.fs.dir(dir) do
              if type_ == "file" and not name:match("^%.") then
                first = dir .. "/" .. name
                break
              end
            end
            if first then
              vim.cmd.edit(vim.fn.fnameescape(first))
            else
              vim.notify("No files found in " .. dir, vim.log.levels.WARN)
            end
          end

          map("i", "<C-o>", open_first_file)
          map("n", "<C-o>", open_first_file)
          return true
        end,
      })
    end, { desc = "Find [D]irectories" })

    -- Find files including hidden and git-ignored (capital F)
    vim.keymap.set("n", "<leader>fF", function()
      builtin.find_files({
        hidden = true,
        no_ignore = true,
        find_command = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!.git/*", "--glob", "!node_modules/*" },
        prompt_title = "Find Files (Hidden & Ignored)",
      })
    end, { desc = "Find Files (All)" })

    -- Live grep including hidden and git-ignored (capital G)
    vim.keymap.set("n", "<leader>fG", function()
      builtin.live_grep({
        additional_args = function()
          return {
            "--hidden",
            "--no-ignore",
            "--glob",
            "!.git/*",
            "--glob",
            "!node_modules/*",
            "--glob",
            "!*.md",
            "--glob",
            "!*.txt",
          }
        end,
        prompt_title = "Live Grep (Hidden & Ignored)",
      })
    end, { desc = "Grep (All)" })
  end,
}
