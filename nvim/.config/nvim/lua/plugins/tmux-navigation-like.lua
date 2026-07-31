return {
	"christoomey/vim-tmux-navigator",
	lazy = false,
	init = function()
		vim.g.tmux_navigator_no_mappings = 1
	end,
	config = function()
		-- LazyVim's own <C-h/j/k/l> window-nav keymaps load on VeryLazy (after this
		-- config() runs), so they'd clobber these unless we also defer to VeryLazy.
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				dofile(vim.fn.expand("~/.config/herdr/plugins/github/vim-herdr-navigation-a8bf42123d81/editor/nvim.lua"))
			end,
		})
	end,
	-- For tmux
	-- cmd = {
	-- 	"TmuxNavigateLeft",
	-- 	"TmuxNavigateDown",
	-- 	"TmuxNavigateUp",
	-- 	"TmuxNavigateRight",
	-- 	"TmuxNavigatePrevious",
	-- },
	-- keys = {
	-- 	{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
	-- 	{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
	-- 	{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
	-- 	{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
	-- 	{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
	-- },
}
