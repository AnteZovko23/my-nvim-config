return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		-- optional: attach even on new/untracked files
		attach_to_untracked = true,
		on_attach = function(bufnr)
			local gs = require("gitsigns")

			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end

			-- Navigation (per README)
			map("n", "]h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gs.nav_hunk("next")
				end
			end, "Next Hunk")

			map("n", "[h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gs.nav_hunk("prev")
				end
			end, "Prev Hunk")

			-- Actions
			map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
			map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
			map("v", "<leader>hs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Stage hunk")
			map("v", "<leader>hr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Reset hunk")
			map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
			map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
			map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
			map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
			map("n", "<leader>hi", gs.preview_hunk_inline, "Preview hunk (inline)")
			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, "Blame line")
			map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")
			map("n", "<leader>hd", gs.diffthis, "Diff this")
			map("n", "<leader>hD", function()
				gs.diffthis("~")
			end, "Diff against ~")
			map("n", "<leader>hQ", function()
				gs.setqflist("all")
			end, "Hunks → quickfix (all)")
			map("n", "<leader>hq", gs.setqflist, "Hunks → quickfix (attached)")

			-- Text object (function form per README)
			map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
		end,
	},
}
