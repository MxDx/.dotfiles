return {
	"ahmedkhalf/project.nvim",
	-- Load early so BufReadPre/BufEnter events from session restore are caught
	event = "BufReadPre",
	opts = {
		-- Also treat the cwd itself as a project root (catches session-restored projects)
		detect_cwd = true,
		detection_methods = { "lsp", "pattern" },
		patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pyproject.toml" },
		silent_chdir = true,
		show_hidden = false,
	},
}
