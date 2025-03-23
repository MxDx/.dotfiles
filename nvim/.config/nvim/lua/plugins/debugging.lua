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

			vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP continue"})
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP step over" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP step into" })
			vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP step out" })

			vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" })
			vim.keymap.set("n", "<Leader>B", dap.set_breakpoint, { desc = "DAP set breakpoint" })
			-- vim.keymap.set("n", "<Leader>lp", dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")), {})
			vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "DAP open REPL" })
			vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "DAP run last" })
			vim.keymap.set({ "n", "v" }, "<Leader>dh", widgets.hover, { desc = "DAP hover" })
			vim.keymap.set({ "n", "v" }, "<Leader>dp", widgets.preview, { desc = "DAP preview" })
            vim.keymap.set("n", "<Leader>dc", dap.disconnect, { desc = "DAP disconnect" })

		end,
	},
}
