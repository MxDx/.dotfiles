return {
	"folke/snacks.nvim",
	opts = {
		zen = {
			-- You can customize the look here
			styles = {
				zen = {
					backdrop = { transparent = false, opacity = 0.8 }, -- This "greys out" the background
					width = 120, -- Centers the buffer with this width
				},
			},
		},
	},
	keys = {
		-- Rapid Toggle for Zen Mode (Buffer in center + Backdrop)
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Toggle Zen Mode",
		},
		-- Rapid Toggle for Zoom (Just maximizes the current window)
		{
			"<leader>uZ",
			function()
				Snacks.zoom()
			end,
			desc = "Toggle Zoom",
		},
		-- Rapid focus toggle with a single leader key
	},
}
