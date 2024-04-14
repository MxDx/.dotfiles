return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			local dap = require("dap")
			local widgets = require("dap.ui.widgets")

			local dapui = require("dapui")

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<F5>", dap.continue, {})
			vim.keymap.set("n", "<F10>", dap.step_over, {})
			vim.keymap.set("n", "<F11>", dap.step_into, {})
			vim.keymap.set("n", "<F12>", dap.step_out, {})

			vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<Leader>B", dap.set_breakpoint, {})
			-- vim.keymap.set("n", "<Leader>lp", dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")), {})
			vim.keymap.set("n", "<Leader>dr", dap.repl.open, {})
			vim.keymap.set("n", "<Leader>dl", dap.run_last, {})
			vim.keymap.set({ "n", "v" }, "<Leader>dh", widgets.hover, {})
			vim.keymap.set({ "n", "v" }, "<Leader>dp", widgets.preview, {})
			-- vim.keymap.set("n", "<Leader>df", widgets.centered_float(widgets.frames), {})
			-- vim.keymap.set("n", "<Leader>ds", widgets.centered_float(widgets.scopes), {})
		end,
	},
}
