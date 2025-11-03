-- lua/plugins/colorscheme.lua
return {
  {
    "iagorrr/noctis-high-contrast.nvim", -- repo
    name = "noctishc", -- optional alias
    lazy = false, -- load on startup
    priority = 1000, -- load first
    config = function()
      vim.cmd.colorscheme("noctishc") -- apply colorscheme
    end,
  },
}
