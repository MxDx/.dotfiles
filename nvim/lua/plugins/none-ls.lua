return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		require("mason-null-ls").setup({
			ensure_installed = {
				"stylua",
				"black",
				-- "beautysh",
				-- "shellcheck",
			},
		})

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black,
				-- null_ls.builtins.formatting.beautysh,
				-- null_ls.builtins.diagnostics.shellcheck,
			},
		})

		vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})
	end,
}
