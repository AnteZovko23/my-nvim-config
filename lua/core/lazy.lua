-- ~/.config/nvim/lua/config/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = { { import = "plugins" } }, -- only load what you put in lua/plugins
	defaults = { lazy = false },
}, {
	concurrency = 1, -- serialize network work
	git = {
		timeout = 300, -- bump if your network is flaky
		url_format = "https://github.com/%s.git",
		filter = false, -- NO partial clones (these often hang on some setups)
		-- do shallow clones to reduce delta resolving
		clone_opts = { "--depth=1", "--single-branch" },
		-- also use depth=1 on updates
		fetch_opts = { "--depth=1" },
	},
	readme = { enabled = false },
	change_detection = { enabled = false, notify = false },
})
