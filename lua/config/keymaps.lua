vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>tl", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "<C-c>", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "<S-Down>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<S-Up>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

-- Move to left window with ctrl arrow
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Move to left window" })
-- Move to right window with ctrl arrow
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Move to right window" })
-- Move to up window with ctrl arrow
vim.keymap.set("n", "<C-Up>", "<C-w>k", { desc = "Move to up window" })
-- Move to down window with ctrl arrow
vim.keymap.set("n", "<C-Down>", "<C-w>j", { desc = "Move to down window" })

-- Move between buffers with shift arrow with bufferline
vim.keymap.set("n", "<S-Left>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Move to previous buffer" })
vim.keymap.set("n", "<S-Right>", "<cmd>BufferLineCycleNext<CR>", { desc = "Move to next buffer" })

vim.keymap.set("n", "<leader>sa", ":%s///g<Left><Left>", { desc = "Replace All" })
vim.keymap.set("n", "<leader>sc", ":%s///gc<Left><Left><Left>", { desc = "Replace Confirm" })

-- Close all windows and buffers and save and exit
vim.keymap.set("n", "<leader>qq", "<cmd>qa!<CR>", { desc = "Quit all" })

-- Close current buffer with space b c
vim.keymap.set("n", "<leader>bc", "<cmd>bd!<CR>", { desc = "Close current buffer" })
