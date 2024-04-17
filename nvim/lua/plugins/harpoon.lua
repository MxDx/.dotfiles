return {
	"ThePrimeagen/harpoon",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
    },
	config = function()
	 	require("harpoon").setup({
            global_settings = {
                tabline = true,
            },
        })
		vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
		vim.cmd("highlight! HarpoonActive guibg=NONE guifg=white")
		vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
		vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
		vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")

        vim.keymap.set("n", "<leader>hf", ":Telescope harpoon marks<CR>", {})
        vim.keymap.set("n", "<leader>hh", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", {})
        vim.keymap.set("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>", {})

        vim.keymap.set("n", "<leader>hr", ":lua require('harpoon.mark').remove_file()<CR>", {})
        vim.keymap.set("n", "<leader>hm", ":lua require('harpoon.mark').clear_all()<CR>", {})
        vim.keymap.set("n", "<leader>hp", ":lua require('harpoon.ui').nav_prev()<CR>", {})
        vim.keymap.set("n", "<leader>hn", ":lua require('harpoon.ui').nav_next()<CR>", {})

        vim.keymap.set("n", "<leader>t1", ":lua require('harpoon.tmux').gotoTerminal(1)<CR>", {})
        vim.keymap.set("n", "<leader>t2", ":lua require('harpoon.tmux').gotoTerminal(2)<CR>", {})
        vim.keymap.set("n", "<leader>t3", ":lua require('harpoon.tmux').gotoTerminal(3)<CR>", {})

        vim.keymap.set("n", "<leader>h1", ":lua require('harpoon.ui').nav_file(1)<CR>", {})
        vim.keymap.set("n", "<leader>h2", ":lua require('harpoon.ui').nav_file(2)<CR>", {})
        vim.keymap.set("n", "<leader>h3", ":lua require('harpoon.ui').nav_file(3)<CR>", {})
        vim.keymap.set("n", "<leader>h4", ":lua require('harpoon.ui').nav_file(4)<CR>", {})
        vim.keymap.set("n", "<leader>h5", ":lua require('harpoon.ui').nav_file(5)<CR>", {})
        vim.keymap.set("n", "<leader>h6", ":lua require('harpoon.ui').nav_file(6)<CR>", {})
        vim.keymap.set("n", "<leader>h7", ":lua require('harpoon.ui').nav_file(7)<CR>", {})
        vim.keymap.set("n", "<leader>h8", ":lua require('harpoon.ui').nav_file(8)<CR>", {})
        vim.keymap.set("n", "<leader>h9", ":lua require('harpoon.ui').nav_file(9)<CR>", {})


	end,
}
