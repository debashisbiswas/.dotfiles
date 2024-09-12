vim.bo.textwidth = 80

local function add_title_to_url()
  local url = vim.fn.expand('<cWORD>')

  if not url:match "^http" then
    print("cursor is not on a url: " .. url)
    return
  end

  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local start_col, end_col = string.find(vim.api.nvim_get_current_line(), vim.pesc(url))

  if start_col and end_col then
    local title = vim.fn.system({ "web-title.sh", url }):gsub("[\n\r]", "")
    local markdown_link = ("[%s](%s)"):format(title, url)

    vim.api.nvim_buf_set_text(0, row - 1, start_col - 1, row - 1, end_col, { markdown_link })
  end
end

vim.keymap.set('n', '<localleader>at', add_title_to_url, { desc = "add title to url" })
