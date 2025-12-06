local shortcuts = {
	{
		key = "b",
		text = "(b)rowser",
		action = function()
			vim.system({ "brave" })
		end,
	},
	{
		key = "i",
		text = "(i)deaflow",
		action = function()
			vim.system({ "xdg-open", "https://ideaflow.app" })
		end,
	},
	{
		key = "o",
		text = "(o)bsidian",
		action = function()
			local focus_result = vim.system({ "hyprctl", "dispatch", "focuswindow", "class:obsidian" }):wait()
			local focus_success = focus_result.stdout:gsub("\n", "") == "ok"

			if not focus_success then
				vim.system({ "obsidian" })
			end
		end,
	},
	{
		key = "c",
		text = "(c)laude",
		action = function()
			vim.system({ "xdg-open", "https://claude.ai" })
		end,
	},
	{
		key = "t",
		text = "(t)icktick",
		action = function()
			vim.system({ "ticktick" })
		end,
	},
	{
		key = "n",
		text = "(n)otion",
		action = function()
			vim.system({ "xdg-open", "https://notion.so" })
		end,
	},
	{
		key = "e",
		text = "(e)macs",
		action = function()
			vim.system({ "emacs" })
		end,
	},
}

local function quit()
	vim.cmd("qa!")
end

for _, shortcut in ipairs(shortcuts) do
	vim.keymap.set("n", shortcut.key, function()
		shortcut.action()
		quit()
	end)
end

local buffer_text = vim.iter(shortcuts)
	:map(function(v)
		return v.text
	end)
	:totable()

table.insert(buffer_text, "---")
table.insert(buffer_text, "(esc) to (q)uit")

vim.api.nvim_buf_set_lines(0, 0, -1, true, buffer_text)

vim.keymap.set("n", "<esc>", quit)
vim.keymap.set("n", "q", quit)

vim.bo.buftype = "nofile"
vim.bo.bufhidden = "wipe"
vim.bo.filetype = "violetmenu"
vim.o.laststatus = 0
vim.o.number = false
vim.o.relativenumber = false
vim.o.showmode = false
vim.bo.readonly = false
