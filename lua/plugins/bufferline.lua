return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      separator_style = "slant",
    },
  },
    keys = {
    { "<leader>bc", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
  },
}
