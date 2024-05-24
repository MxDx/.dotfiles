return {
    "coffebar/transfer.nvim",
    lazy = true,
    cmd = { "TransferInit", "DiffRemote", "TransferUpload", "TransferDownload", "TransferDirDiff", "TransferRepeat" },
    opts = {},
    config = function()
        require("transfer").setup()

        vim.keymap.set("n", "<leader>ti", "<cmd>TransferInit<cr>", { desc = "Init transfer" })
        vim.keymap.set("n", "<leader>tu", "<cmd>TransferUpload<cr>", { desc = "Upload file" })
        vim.keymap.set("n", "<leader>td", "<cmd>TransferDownload<cr>", { desc = "Download file" })
        vim.keymap.set("n", "<leader>tdr", "<cmd>DiffRemote<cr>", { desc = "Diff remote file" })
        vim.keymap.set("n", "<leader>tdf", "<cmd>TransferDirDiff<cr>", { desc = "Diff remote directory" })
        vim.keymap.set("n", "<leader>tr", "<cmd>TransferRepeat<cr>", { desc = "Repeat last transfer" })
    end,
}
