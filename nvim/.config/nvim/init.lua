require("vim-options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		-- 1. Add LazyVim and import its plugins
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },

		-- 2. Import "Extras" (LSPs & Linters) with NO config needed
		{ import = "lazyvim.plugins.extras.linting.eslint" }, -- Easy Linting!
		{ import = "lazyvim.plugins.extras.formatting.prettier" },
		{
			import = "lazyvim.plugins.extras.ai.copilot",
			opts = {
				-- Enable Copilot for all file types
				filetypes = {
					["*"] = true, -- Allow most things
					["yaml"] = true, -- Explicitly allow yaml
					["yaml.ansible"] = true, -- Explicitly allow the ansible subtype
					help = false, -- Example: keep it off for help files
					gitcommit = false,
				},
			},
		},
		{ import = "lazyvim.plugins.extras.editor.neo-tree" },
		-- { import = "lazyvim.plugins.extras.editor.fzf" },
		{ import = "lazyvim.plugins.extras.editor.telescope" },
		{ import = "lazyvim.plugins.extras.util.project" },

		-- Language specific extras
		{ import = "lazyvim.plugins.extras.lang.python" },

		-- 3. Import your local custom plugins
		{ import = "plugins" },
	},
	defaults = { autocmds = true, keymaps = true, opts = true },
})
