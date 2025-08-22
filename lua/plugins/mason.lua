-- lua/plugins/mason.lua
return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		priority = 900,
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		lazy = false,
		priority = 901,
		opts = {
			ensure_installed = {},
			automatic_enable = true, -- auto-enable installed servers
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		priority = 902,
		opts = {
			ensure_installed = {
				-- Formatters
				"prettier",
				"stylua",
				"isort",
				"black",
				"pylint",
				"eslint_d",
			},

			auto_update = false, -- set true if you want to auto-update tools on start
			run_on_start = true, -- install missing tools on startup
		},
	},
}
