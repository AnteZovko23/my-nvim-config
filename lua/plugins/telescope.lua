return 
{
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim", -- optional, for todo comments integration
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    local builtin = require("telescope.builtin")
    local keymap = vim.keymap.set

    -- f: files (exclude hidden)
    keymap("n", "<leader>ff", function()
      builtin.find_files({
        hidden = false,
        no_ignore = true,
        file_ignore_patterns = { "node_modules", ".git" },
      })
    end, { desc = "Find Files" })

    -- F: files (include hidden)
    keymap("n", "<leader>fF", function()
      builtin.find_files({ hidden = true, no_ignore = true })
    end, { desc = "Find Files (Hidden)" })

    -- w: live grep words (exclude hidden)
    keymap("n", "<leader>fw", function()
      builtin.live_grep({
        additional_args = function()
          return {
            "--glob", "!**/node_modules/**",
            "--glob", "!**/.git/**",
          }
        end,
      })
    end, { desc = "Live Grep (exclude git & node_modules)" })

    -- W: live grep (include hidden + ignored files)
    keymap("n", "<leader>fW", function()
      builtin.live_grep({
        additional_args = function()
          return {
            "--hidden",
            "--no-ignore",
          }
        end,
      })
    end, { desc = "Live Grep (ALL — includes git & node_modules)" })

    -- other useful mappings you had
    keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find open buffers" })
    keymap("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODO comments" })
       
  end,
}

