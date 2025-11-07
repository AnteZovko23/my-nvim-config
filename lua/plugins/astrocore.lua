---@type LazySpec
return {
  "AstroNvim/astrocore",
  opts = {
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics = { virtual_text = true, virtual_lines = false },
      highlighturl = true,
      notifications = true,
    },
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    filetypes = {
      extension = { foo = "fooscript" },
      filename = { [".foorc"] = "fooscript" },
      pattern = { [".*/etc/foo/.*"] = "fooscript" },
    },
    options = {
      opt = {
        number = true,
        relativenumber = true,
        spell = false,
        signcolumn = "yes",
        wrap = false,
        mouse = "a",
        showmode = false,
        clipboard = "unnamedplus",
        breakindent = true,
        undofile = true,
        ignorecase = true,
        smartcase = true,
        updatetime = 250,
        timeoutlen = 300,
        splitright = true,
        splitbelow = true,
        list = true,
        listchars = { tab = "» ", trail = "·", nbsp = "␣" },
        inccommand = "split",
        cursorline = true,
        scrolloff = 10,
        confirm = true,
        termguicolors = true,
        background = "dark",
        backspace = "indent,eol,start",
        swapfile = false,
        backup = false,
        undodir = os.getenv("HOME") .. "/.vim/undodir",
      },
      g = {
        have_nerd_font = true,
      },
    },
    mappings = {
      n = {
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr)
              require("astrocore.buffer").close(bufnr)
            end)
          end,
          desc = "Close buffer from tabline",
        },
        ["<Esc>"] = { "<cmd>nohlsearch<CR>", desc = "Clear search highlight" },
        ["<leader>tl"] = { function() vim.diagnostic.setloclist() end, desc = "Open diagnostic Quickfix" },
        ["<S-Down>"] = { "<C-d>zz", desc = "Half page down centered" },
        ["<S-Up>"] = { "<C-u>zz", desc = "Half page up centered" },
        ["<C-Left>"] = { "<C-w>h", desc = "Move to left window" },
        ["<C-Right>"] = { "<C-w>l", desc = "Move to right window" },
        ["<C-Up>"] = { "<C-w>k", desc = "Move to upper window" },
        ["<C-Down>"] = { "<C-w>j", desc = "Move to lower window" },
        ["<S-Left>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<S-Right>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Previous buffer" },
        ["<leader>sa"] = { ":%s///g<Left><Left>", desc = "Replace All" },
        ["<leader>sc"] = { ":%s///gc<Left><Left><Left>", desc = "Replace Confirm" },
        ["<C-c>"] = { ":nohl<CR>", desc = "Clear search highlights" },
      },
      i = {
        ["<C-c>"] = { "<Esc>", desc = "Exit insert mode" },
      },
      t = {
        ["<Esc><Esc>"] = { [[<C-\><C-n>]], desc = "Exit terminal mode" },
      },
    },
  },
}

