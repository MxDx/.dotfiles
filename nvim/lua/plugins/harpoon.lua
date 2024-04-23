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

        vim.keymap.set("n", "<leader>hf", ":Telescope harpoon marks<CR>", { desc = "Harpoon: Find File in Telescope" })
        vim.keymap.set("n", "<leader>hh", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", { desc = "Harpoon: Toggle Quick Menu" })
        vim.keymap.set("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>", { desc = "Harpoon: Add File" })

        vim.keymap.set("n", "<leader>hr", ":lua require('harpoon.mark').remove_file()<CR>", { desc = "Harpoon: Remove File" })
        vim.keymap.set("n", "<leader>hm", ":lua require('harpoon.mark').clear_all()<CR>", { desc = "Harpoon: Clear All" })
        vim.keymap.set("n", "<leader>hp", ":lua require('harpoon.ui').nav_prev()<CR>", { desc = "Harpoon: Previous" })
        vim.keymap.set("n", "<leader>hn", ":lua require('harpoon.ui').nav_next()<CR>", { desc = "Harpoon: Next" })

        vim.keymap.set("n", "<leader>t1", ":lua require('harpoon.tmux').gotoTerminal(1)<CR>", { desc = "Harpoon: Go to Terminal 1" })
        vim.keymap.set("n", "<leader>t2", ":lua require('harpoon.tmux').gotoTerminal(2)<CR>", { desc = "Harpoon: Go to Terminal 2" })
        vim.keymap.set("n", "<leader>t3", ":lua require('harpoon.tmux').gotoTerminal(3)<CR>", { desc = "Harpoon: Go to Terminal 3" })

        vim.keymap.set("n", "<leader>h1", ":lua require('harpoon.ui').nav_file(1)<CR>", { desc = "Harpoon: Navigate to File 1" })
        vim.keymap.set("n", "<leader>h2", ":lua require('harpoon.ui').nav_file(2)<CR>", { desc = "Harpoon: Navigate to File 2" })
        vim.keymap.set("n", "<leader>h3", ":lua require('harpoon.ui').nav_file(3)<CR>", { desc = "Harpoon: Navigate to File 3" })
        vim.keymap.set("n", "<leader>h4", ":lua require('harpoon.ui').nav_file(4)<CR>", { desc = "Harpoon: Navigate to File 4" })
        vim.keymap.set("n", "<leader>h5", ":lua require('harpoon.ui').nav_file(5)<CR>", { desc = "Harpoon: Navigate to File 5" })
        vim.keymap.set("n", "<leader>h6", ":lua require('harpoon.ui').nav_file(6)<CR>", { desc = "Harpoon: Navigate to File 6" })
        vim.keymap.set("n", "<leader>h7", ":lua require('harpoon.ui').nav_file(7)<CR>", { desc = "Harpoon: Navigate to File 7" })
        vim.keymap.set("n", "<leader>h8", ":lua require('harpoon.ui').nav_file(8)<CR>", { desc = "Harpoon: Navigate to File 8" })
        vim.keymap.set("n", "<leader>h9", ":lua require('harpoon.ui').nav_file(9)<CR>", { desc = "Harpoon: Navigate to File 9" })


	end,
}
