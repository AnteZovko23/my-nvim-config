return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern(
              "tsconfig.json",
              "tsconfig.base.json",
              "tsconfig.webstorm.json",
              "jsconfig.json",
              "package.json"
            )(fname)
          end,
        },
      },
    },
  },
}
