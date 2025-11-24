local function quit()
	vim.cmd("qa!")
end

local function fn_run_then_exit(func)
	return function()
		func()
		quit()
	end
end

local function append_lines(lines)
	vim.api.nvim_buf_set_lines(0, -1, -1, true, lines)
end

local shortcuts = {
	{
		key = "b",
		text = "(b)rowser",
		action = fn_run_then_exit(function()
			vim.system({ "brave" })
		end),
	},
	{
		key = "i",
		text = "(i)deaflow",
		action = fn_run_then_exit(function()
			vim.system({ "xdg-open", "https://ideaflow.app" })
		end),
	},
	{
		key = "o",
		text = "(o)bsidian",
		action = fn_run_then_exit(function()
			local focus_result = vim.system({ "hyprctl", "dispatch", "focuswindow", "class:obsidian" }):wait()
			local focus_success = focus_result.stdout:gsub("\n", "") == "ok"

			if not focus_success then
				vim.system({ "obsidian" })
			end
		end),
	},
	{
		key = "c",
		text = "(c)laude",
		action = fn_run_then_exit(function()
			vim.system({ "xdg-open", "https://claude.ai" })
		end),
	},
}

for _, shortcut in ipairs(shortcuts) do
	vim.keymap.set("n", shortcut.key, shortcut.action)
end

local shortcuts_text = vim.iter(shortcuts)
	:map(function(v)
		return v.text
	end)
	:totable()

vim.api.nvim_buf_set_lines(0, 0, -1, true, shortcuts_text)

append_lines({ "(esc) to (q)uit" })

vim.keymap.set("n", "<esc>", quit)
vim.keymap.set("n", "q", quit)

vim.bo.buftype = "nofile"
vim.bo.bufhidden = "wipe"
vim.bo.filetype = "violetmenu"
vim.o.laststatus = 0
vim.o.number = false
vim.o.relativenumber = false
vim.o.cursorline = true
vim.bo.modifiable = false
