
return {
  -- Core LSP configs
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- Mason + mason-lspconfig (v2 API)
    { "mason-org/mason.nvim", opts = {} },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "lua_ls", "emmet_ls" }, -- add yours here
        automatic_enable = true,                     -- auto-enable installed servers
      },
    },

    -- Completion capabilities for LSP
    "hrsh7th/cmp-nvim-lsp",

    -- Extras
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },

  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Diagnostics (0.11+): configure signs via vim.diagnostic.config()
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN]  = "",
          [vim.diagnostic.severity.INFO]  = "",
          [vim.diagnostic.severity.HINT]  = "󰠠",
        },
      },
      virtual_text = { prefix = "●" },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = { border = "rounded", source = "if_many" },
    })

    -- LspAttach keymaps (using new diagnostic jump API)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local keymap = vim.keymap
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "Code actions"
        keymap.set({ "n", "v" }, "<leader>ga", vim.lsp.buf.code_action, opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>gs", vim.diagnostic.open_float, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    -- Capabilities for nvim-cmp
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Per-server config (0.11+): define with vim.lsp.config(); mason-lspconfig auto-enables
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          completion  = { callSnippet = "Replace" },
        },
      },
    })

    vim.lsp.config("emmet_ls", {
      capabilities = capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })

    -- Add more:
    -- vim.lsp.config("ts_ls", { capabilities = capabilities })
    -- vim.lsp.config("jsonls", { capabilities = capabilities })
    -- vim.lsp.config("eslint", { capabilities = capabilities })
  end,
}

