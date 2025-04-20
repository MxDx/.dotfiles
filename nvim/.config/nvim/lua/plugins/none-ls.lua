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
            automatic_installation = true,
            ensure_installed = {
                "stylua",
                "black",
                "prettier",
                -- "beautysh",
                -- "shellcheck",
            },
        })

        null_ls.setup({
            sources = {
-- Lua formatter
                null_ls.builtins.formatting.stylua.with({
                    extra_args = { "--line-length", "120" },
                }),

                -- Python formatter
                null_ls.builtins.formatting.black.with({
                    extra_args = { "--line-length", "120" },
                }),
                -- null_ls.builtins.formatting.stylua,
                -- null_ls.builtins.formatting.black,
                -- null_ls.builtins.formatting.prettier,
                -- null_ls.builtins.formatting.beautysh,
                -- null_ls.builtins.diagnostics.shellcheck,
            },
        })

        -- Format on savelocal augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        require("null-ls").setup({
            -- you can reuse a shared lspconfig on_attach callback here
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                            -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                            vim.lsp.buf.format({
                                bufnr = bufnr,
                                filter = function(client)
                                    return client.name == "null-ls"
                                end,
                            })
                        end,
                    })
                end
            end,
        })

        vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format" })
    end,
}
