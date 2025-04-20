return {
    "folke/snacks.nvim",
    dependencies = {
        "echasnovski/mini.icons",
    },
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            enabled = true,

            preset = {
                --                header = [[
                --                                              
                --       ████ ██████           █████      ██
                --      ███████████             █████ 
                --      █████████ ███████████████████ ███   ███████████
                --     █████████  ███    █████████████ █████ ██████████████
                --    █████████ ██████████ █████████ █████ █████ ████ █████
                --  ███████████ ███    ███ █████████ █████ █████ ████ █████
                -- ██████  █████████████████████ ████ █████ █████ ████ ██████
                --        ]],
            },
            sections = {
                { section = "header" },
                { section = "keys", gap = 1 },
                { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 2 } },
                { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
                { section = "startup" },
            },
        },
        indent = { enabled = true },
        input = { enabled = true },
        git = { enabled = true },
        picker = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scroll = { enabled = false },
        statuscolumn = { enabled = true },
        words = { enabled = true },
    },
    keys = {
        {
            "<leader>sf",
            function()
                Snacks.scratch()
            end,
            desc = "Toggle Scratch Buffer",
        },
        {
            "<leader>S",
            function()
                Snacks.scratch.select()
            end,
            desc = "Select Scratch Buffer",
        },
        {
            "<leader>gl",
            function()
                Snacks.lazygit.log_file()
            end,
            desc = "Lazygit Log (cwd)",
        },
        {
            "<leader>lg",
            function()
                Snacks.lazygit()
            end,
            desc = "Lazygit",
        },
        {
            "<C-p>",
            function()
                Snacks.picker.pick("files")
            end,
            desc = "Find Files",
        },
        {
            "<leader><leader>",
            function()
                Snacks.picker.recent()
            end,
            desc = "Recent Files",
        },
        {
            "<leader>fb",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep Files",
        },
        {
            "<C-n>",
            function()
                Snacks.explorer()
            end,
            desc = "Explorer",
        },
    },
}
