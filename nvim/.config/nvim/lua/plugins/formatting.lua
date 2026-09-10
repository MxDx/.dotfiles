return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        markdown = { "prettier" },
      },
      formatters = {
        prettier = {
          -- This tells prettier to wrap text to your print width
          args = { "--stdin-filepath", "$FILENAME", "--prose-wrap", "always", "--print-width", "160" },
        },
      },
    },
  },
  {
    -- markdownlint-cli2 reads from stdin for live linting, which means it
    -- can't discover ~/.markdownlint.jsonc by walking up from the buffer's
    -- real path (it only has cwd to go on). Pass --config explicitly so the
    -- relaxed line-length rule always applies, regardless of nvim's cwd.
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", vim.fn.expand("~/.markdownlint.jsonc"), "-" },
        },
      },
    },
  },
}
