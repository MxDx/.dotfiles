vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>qq', ":wqa<CR>", {})
vim.keymap.set({'n', 'v'}, '<C-s>', ":w<CR>", {})
vim.keymap.set('n', '<leader>wd', ':q<CR>', {})

vim.g.background = "light"

vim.opt.swapfile = false

-- Navigate between buffers
vim.keymap.set('n', '<S-h>', ':bprevious <CR>')
vim.keymap.set('n', '<S-l>', ':bnext <CR>')

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.wo.number = true

vim.keymap.set('n', '<leader>r', ':%s/', {})
