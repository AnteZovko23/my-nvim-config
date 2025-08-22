-- lua/plugins/colorscheme.lua
return {
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,      -- load on startup
    priority = 1000,   -- load before other plugins
    config = function()
      vim.cmd.colorscheme("nightfly")
    end,
  },
}
