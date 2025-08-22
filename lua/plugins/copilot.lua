return {
	{
		"github/copilot.vim",
		lazy = false, -- load immediately (fixes race/keymap issues)
		priority = 1000, -- load before other UI/completion plugins
		init = function()
			-- Disable Copilot everywhere so nothing appears until you ask for it.
			-- You can still request a suggestion manually with <Plug>(copilot-suggest).
			vim.g.copilot_filetypes = { ["*"] = false }

			-- If needed, point to a specific Node (nvm, asdf, etc.):
			-- vim.g.copilot_node_command = vim.fn.expand("$HOME/.local/share/asdf/shims/node")
			-- or: vim.g.copilot_node_command = "/usr/bin/node"
		end,
		config = function()
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_assume_mapped = true

			local expr = { silent = true, expr = true, replace_keycodes = false }
			local plug = { silent = true }

			-- Manual trigger (works even if Copilot is “disabled” for the filetype)
			vim.keymap.set("i", "<C-Space>", "<Plug>(copilot-suggest)", plug)
			vim.keymap.set("i", "<C-@>", "<Plug>(copilot-suggest)", plug) -- some terms send <C-@>

			-- Your preferred keys
			vim.keymap.set("i", "<Tab>", 'copilot#Accept("\\<Tab>")', expr) -- accept full

			-- Accept next word AND immediately ask Copilot for the next chunk
			vim.keymap.set("i", "<C-Right>", function()
				-- accept one word (note the escaped <CR>)
				local ok = vim.fn["copilot#AcceptWord"]("\\<CR>")
				-- re-trigger a fresh suggestion so ghost text stays visible
				vim.schedule(function()
					-- feed the <Plug>(copilot-suggest) mapping
					local keys = vim.api.nvim_replace_termcodes("<Plug>(copilot-suggest)", true, true, true)
					vim.api.nvim_feedkeys(keys, "i", true)
				end)
				return ok
			end, { silent = true, expr = true, replace_keycodes = false })
			-- no accept_line
			vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", plug) -- next suggestion
			vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", plug) -- previous suggestion
			vim.keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)", plug) -- dismiss
		end,
	},
}
