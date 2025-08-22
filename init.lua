-- lsp/hotfix.lua
do
	local util = require("vim.lsp.util")
	if util and type(util.make_position_params) == "function" and not util.__patched then
		local orig = util.make_position_params
		util.make_position_params = function(win, enc, ...)
			if enc == nil then
				local clients = (vim.lsp.get_clients or vim.lsp.get_active_clients)({ bufnr = 0 })
				enc = (clients[1] and clients[1].offset_encoding) or "utf-16"
			end
			return orig(win or 0, enc, ...)
		end
		util.__patched = true
	end
end
-- lsp/hotfix.lua
do
	local util = require("vim.lsp.util")
	if util and type(util.make_position_params) == "function" and not util.__patched then
		local orig = util.make_position_params
		util.make_position_params = function(win, enc, ...)
			if enc == nil then
				local clients = (vim.lsp.get_clients or vim.lsp.get_active_clients)({ bufnr = 0 })
				enc = (clients[1] and clients[1].offset_encoding) or "utf-16"
			end
			return orig(win or 0, enc, ...)
		end
		util.__patched = true
	end
end
require("core")
