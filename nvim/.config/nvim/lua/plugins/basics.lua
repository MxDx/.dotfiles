return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"lua",
				"bash",
				"markdown",
				"markdown_inline",
				"vim",
				"vimdoc",
				"query",
			},
			highlight = {
				enable = true,
				-- Only use this if you have specific legacy themes that require it
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			-- LazyVim handles auto_install by default, but you can keep it
			auto_install = true,
		},
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
				-- hint = "statusline-winbar",
				-- Use floating letters for window hints
				hint = "floating-letter",

				-- when you go to window selection mode, status bar will show one of
				-- following letters on them so you can use that letter to select the window
				selection_chars = "FJDKSLA;CMRUEIWOQP",
				filter_rules = {
					include_current_win = false,
					autoselect_one = true,
					bo = {
						-- Exclude Neo-tree windows
						filetype = { "neo-tree", "neo-tree-popup", "neo-tree-filesystem" },
					},
				},
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			filesystem = {
				filtered_items = {
					visible = true, -- This shows hidden files by default
					hide_dotfiles = false,
					hide_gitignored = true,
				},
                never_show = {
                    ".DS_Store",
                    "thumbs.db",
                    ".git",
                },
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
					theme = "auto",
					icons_enabled = true,
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					always_show_tabline = true,
					globalstatus = false,
					refresh = {
						statusline = 100,
						tabline = 100,
						winbar = 100,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = {
						{
							"filename",
							file_status = true, -- Displays file status (readonly status, modified status)
							newfile_status = true, -- Display new file status (new file means no write after created)
							path = 1, -- 0: Just the filename
							-- 1: Relative path
							-- 2: Absolute path
							-- 3: Absolute path, with tilde as the home directory
							-- 4: Filename and parent dir, with tilde as the home directory

							shorting_target = 80, -- Shortens path to leave 40 spaces in the window
							-- for other components. (terrible name, any suggestions?)
							symbols = {
								modified = "[+]", -- Text to show when the file is modified.
								readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
								unnamed = "[No Name]", -- Text to show for unnamed buffers.
								newfile = "[New]", -- Text to show for newly created file before first write
							},
						},
					},
					lualine_x = {
						"encoding",
						{
							function()
								return require("auto-session.lib").current_session_name(true)
							end,
						},
						"fileformat",
						"filetype",
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						{
							"filename",
							file_status = true, -- Displays file status (readonly status, modified status)
							newfile_status = true, -- Display new file status (new file means no write after created)
							path = 1, -- 0: Just the filename
							-- 1: Relative path
							-- 2: Absolute path
							-- 3: Absolute path, with tilde as the home directory
							-- 4: Filename and parent dir, with tilde as the home directory

							shorting_target = 80, -- Shortens path to leave 40 spaces in the window
							-- for other components. (terrible name, any suggestions?)
							symbols = {
								modified = "[+]", -- Text to show when the file is modified.
								readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
								unnamed = "[No Name]", -- Text to show for unnamed buffers.
								newfile = "[New]", -- Text to show for newly created file before first write
							},
						},
					},
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})
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
