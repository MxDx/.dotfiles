return {
	"AckslD/swenv.nvim",
	config = function()
		require("swenv").setup({
			-- Should return a list of python executable paths
			get_venvs = function(venvs_path)
				return require("swenv.api").get_venvs(venvs_path)
			end,
			venvs_path = vim.fn.expand("~/.virtualenvs"), -- Point this to where you keep venvs
		})
	end,
	keys = {
		-- Rapidly switch python environments
		{
			"<leader>cv",
			function()
				require("swenv.api").pick_venv()
			end,
			desc = "Choose Venv",
		},
	},
}
