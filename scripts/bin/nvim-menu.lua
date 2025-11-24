vim.bo.buftype = "nofile"
vim.bo.bufhidden = "wipe"
vim.bo.filetype = "violetmenu"
vim.o.laststatus = 0
vim.o.number = false
vim.o.relativenumber = false

vim.o.cursorline = true

local menu_items = {
	"(q)uit",
	"(b)rowser",
	"(o)bsidian",
	"(i)deaflow",
	"(c)laude",
}

vim.api.nvim_buf_set_lines(0, 0, -1, false, menu_items)

vim.bo.modifiable = false

local function fn_run_then_exit(func)
	return function()
		func()
		vim.cmd("qa!")
	end
end

vim.keymap.set("n", "q", function()
	vim.cmd("qa!")
end, { buffer = 0 })

vim.keymap.set(
	"n",
	"b",
	fn_run_then_exit(function()
		vim.system({ "brave" })
	end)
)

vim.keymap.set(
	"n",
	"i",
	fn_run_then_exit(function()
		vim.system({ "xdg-open", "https://ideaflow.app" })
	end)
)

vim.keymap.set(
	"n",
	"o",
	fn_run_then_exit(function()
		local focus_result = vim.system({ "hyprctl", "dispatch", "focuswindow", "class:obsidian" }):wait()
		local focus_success = focus_result.stdout:gsub("\n", "") == "ok"

		if not focus_success then
			vim.system({ "obsidian" })
		end
	end)
)

vim.keymap.set(
	"n",
	"c",
	fn_run_then_exit(function()
		vim.system({ "xdg-open", "https://claude.ai" })
	end)
)
