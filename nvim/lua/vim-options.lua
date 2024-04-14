vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>qq', ":wqa<CR>", {})
vim.keymap.set('n', '<C-s>', ":w<CR>", {})
