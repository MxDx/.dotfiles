return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    -- Beautiful ui select
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            -- This is your opts table
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({
                            -- even more opts
                        }),
                    },
                },
            })
            -- To get ui-select loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require("telescope").load_extension("ui-select")
        end,
    },

    {
        -- For syntax highlighting
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                auto_install = true,
                ensure_installed = { "lua", "bash" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    {
        "s1n7ax/nvim-window-picker",
        name = "window-picker",
        event = "VeryLazy",
        version = "2.*",
        config = function()
            require("window-picker").setup({
                -- type of hints you want to get
                -- following types are supported
                -- 'statusline-winbar' | 'floating-big-letter' | 'floating-letter'
                -- 'statusline-winbar' draw on 'statusline' if possible, if not 'winbar' will be
                -- 'floating-big-letter' draw big letter on a floating window
                -- 'floating-letter' draw letter on a floating window
                -- used
                hint = "statusline-winbar",

                -- when you go to window selection mode, status bar will show one of
                -- following letters on them so you can use that letter to select the window
                selection_chars = "FJDKSLA;CMRUEIWOQP",
            })
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            require("neo-tree").setup({
                use_libuv_file_watcher = true,
                close_if_last_window = true,
                filesystem = {
                    filtered_items = {
                        visible = false, -- when true, they will just be displayed differently than normal items
                        hide_dotfiles = false,
                        hide_gitignored = true,
                    },
                    follow_current_file = {
                        enabled = false, -- This will find and focus the file in the active buffer every time
                        --               -- the current file is changed while the tree is open.
                    },
                },
            })
            vim.keymap.set("n", "<leader>e", ":Neotree filesystem toggle left<CR>", {})
            vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup()
            options = {
                theme = "dracula",
            }
            sections = {
                lualine_a = {
                    {
                        "buffers",
                        show_filename_only = true, -- Shows shortened relative path when set to false.
                        hide_filename_extension = false, -- Hide filename extension when set to true.
                        show_modified_status = true, -- Shows indicator when the buffer is modified.

                        mode = 0,      -- 0: Shows buffer name
                        -- 1: Shows buffer index
                        -- 2: Shows buffer name + buffer index
                        -- 3: Shows buffer number
                        -- 4: Shows buffer name + buffer number

                        max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
                        -- it can also be a function that returns
                        -- the value of `max_length` dynamically.
                        filetype_names = {
                            TelescopePrompt = "Telescope",
                            dashboard = "Dashboard",
                            packer = "Packer",
                            fzf = "FZF",
                            alpha = "Alpha",
                        }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

                        -- Automatically updates active buffer color to match color of other components (will be overidden if buffers_color is set)
                        use_mode_colors = false,

                        buffers_color = {
                            -- Same values as the general color option can be used here.
                            active = "lualine_{section}_normal", -- Color for active buffer.
                            inactive = "lualine_{section}_inactive", -- Color for inactive buffer.
                        },

                        symbols = {
                            modified = " ●", -- Text to show when the buffer is modified
                            alternate_file = "#", -- Text to show to identify the alternate file
                            directory = "", -- Text to show when the buffer is a directory
                        },
                    },
                },
            }
        end,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
}
