vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set clipboard=unnamedplus")
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>qq", ":wqa<CR>", { desc = "Quit all" })
vim.keymap.set({ "n", "v" }, "<C-s>", ":w<CR>", { desc = "Save" })
-- Escape from insert mode and save
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>wd", ":q<CR>", { desc = "Close window" })

-- Relative line number
vim.wo.relativenumber = true

vim.g.background = "light"

vim.opt.swapfile = false

-- Navigate between buffers
vim.keymap.set("n", "<S-h>", ":bprevious <CR>")
vim.keymap.set("n", "<S-l>", ":bnext <CR>")
vim.keymap.set("n", "<leader>bd", ":w <CR>:bdelete <CR>", { desc = "Delete buffer" })

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.wo.number = true

vim.keymap.set("n", "<leader>r", ":%s/", {})

-- Window controls
vim.keymap.set("n", "<leader>ws", ":split<CR>", { desc = "Split window" })
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>", { desc = "Vsplit window" })

vim.opt.shada = ""
