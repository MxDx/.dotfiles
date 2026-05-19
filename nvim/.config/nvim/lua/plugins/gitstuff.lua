return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		},
		keys = {
			{ "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview Hunk" },
			{ "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle Git Blame" },
		},
	},
}
