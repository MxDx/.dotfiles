return {
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
}
