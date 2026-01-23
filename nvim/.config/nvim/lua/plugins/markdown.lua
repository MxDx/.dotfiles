return {
	{
		{
			"mason-org/mason.nvim",
			opts = { ensure_installed = { "markdownlint" } },
		},
		{
			"mfussenegger/nvim-lint",
			opts = {
				linters = {
					markdownlint = {
						-- MD013 is line-length. We add it to the ignore list.
						args = { "--disable", "MD013", "--" },
					},
				},
			},
		},
	}
}
