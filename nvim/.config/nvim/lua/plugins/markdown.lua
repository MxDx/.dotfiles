return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    config = function()
        vim.g.mkdp_filetypes = { "markdown" }
        -- Keybinding 
        -- <leader>mp for preview if you are in markdown file
        vim.api.nvim_set_keymap("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { noremap = true, silent = true })
    end,
    ft = { "markdown" },
}
