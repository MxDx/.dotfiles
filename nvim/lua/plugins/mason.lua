return {
  {
    "williamboman/mason.nvim",
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    }),
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pylsp" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.pylsp.setup({})
    end,
  },

  {
    "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup({
        filetype = {
          lua = {
            function()
              return {
                exe = "stylua",
                args = { "--config-path", vim.fn.stdpath("config") .. "/stylua.toml", "-" },
                stdin = true,
              }
            end,
          },
          python = {
            function()
              return {
                exe = "black",
                args = { "-" },
                stdin = true,
              }
            end,
          },
        },
      })
    end,
  },
}
