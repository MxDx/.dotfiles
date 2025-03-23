vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set clipboard=unnamedplus")
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>qq", ":wqa<CR>", { desc = "Quit all and save" })
vim.keymap.set({ "n", "v" }, "<C-s>", ":w<CR>", { desc = "Save" })
-- Escape from insert mode and save
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", { desc = "Save" })

-- Save all buffers Ctrl + S
vim.keymap.set("n", "<C-S>", ":wa<CR>", { desc = "Save all" })
vim.keymap.set("i", "<C-S>", "<Esc>:wa<CR>", { desc = "Save all" })

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

vim.opt.shada = ""
