return {
  "folke/sidekick.nvim",
  opts = function()
    -- Accept inline suggestions or next edits
    LazyVim.cmp.actions.ai_nes = function()
      local Nes = require("sidekick.nes")
      if Nes.have() and (Nes.jump() or Nes.apply()) then
        return true
      end
    end
    Snacks.toggle({
      name = "Sidekick NES",
      get = function()
        return require("sidekick.nes").enabled
      end,
      set = function(state)
        require("sidekick.nes").enable(state)
      end,
    }):map("<leader>uN")

    return {
      cli = {
        tools = {
          claude = { cmd = { "claude", "--resume" } },
          claude_new = { cmd = { "claude" } },
        },

        win = {
          layout = "right", -- Use a vertical split on the right
          -- Options for "split" layouts (left, right, top, bottom)
          split = {
            width = 60, -- Set the width to 60 columns
            height = 0, -- Set to 0 to use default split height (full height for vertical)
          },
          -- The 'float' table is ignored when layout is not "float"
          float = {
            width = 0.9,
            height = 0.9,
          },
        },
      },
    }
  end,
  -- Your keymaps remain unchanged, as they are well-defined
  -- stylua: ignore
  keys = {
    -- nes is also useful in normal mode
    { "<tab>", LazyVim.cmp.map({ "ai_nes" }, "<tab>"), mode = { "n" }, expr = true },
    { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    {
      "<c-.>",
      function() require("sidekick.cli").toggle() end,
      desc = "Sidekick Toggle",
      mode = { "n", "t", "i", "x" },
    },
    {
      "<leader>aa",
      function() require("sidekick.cli").toggle() end,
      desc = "Sidekick Toggle CLI",
    },
    {
      "<leader>as",
      function() require("sidekick.cli").select() end,
      desc = "Select CLI",
    },
    {
      "<leader>ad",
      function() require("sidekick.cli").close() end,
      desc = "Detach a CLI Session",
    },
    {
      "<leader>at",
      function() require("sidekick.cli").send({ msg = "{this}" }) end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>af",
      function() require("sidekick.cli").send({ msg = "{file}" }) end,
      desc = "Send File",
    },
    {
      "<leader>av",
      function() require("sidekick.cli").send({ msg = "{selection}" }) end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>ap",
      function() require("sidekick.cli").prompt() end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
    {
      "<leader>ac",
      function()
        local cli = require("sidekick.cli")
        cli.send({ msg = "--resume" })
      end,
      desc = "Claude Resume (Select Session)",
    }
  },
}
