--------------------
-- Linting
--------------------

local lint = require 'lint'

lint.linters_by_ft = {
  python = { 'ruff' },
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'TextChanged' }, {
  callback = function() lint.try_lint() end,
})

--------------------
-- Formatting
--------------------

local conform = require 'conform'

local function get_available_formatter_names()
  local formatters = conform.list_formatters()
  local fmt_names = {}

  if not vim.tbl_isempty(formatters) then
    fmt_names = vim.tbl_map(function(f) return f.name end, formatters)
  elseif conform.will_fallback_lsp() then
    fmt_names = { 'lsp' }
  else
    return
  end

  return fmt_names
end

local function create_format_progress_handle()
  local fmt_names = get_available_formatter_names()

  if not fmt_names then return end

  return require('fidget.progress').handle.create {
    title = 'Formatting',
    lsp_client = { name = table.concat(fmt_names, ', ') },
    percentage = 0,
  }
end

local js_formatters = { 'prettierd' }

conform.setup {
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end

    local handle = create_format_progress_handle()

    return {
      lsp_fallback = true,
    }, function(err)
      if handle then handle:finish() end
      if err then vim.notify(err, vim.log.levels.WARN) end
    end
  end,

  formatters_by_ft = {
    python = { 'ruff_fix', 'ruff_format' },

    lua = { 'stylua' },
    rust = { 'rustfmt' },

    html = js_formatters,
    css = js_formatters,
    json = js_formatters,

    typescript = js_formatters,
    javascript = js_formatters,
    typescriptreact = js_formatters,
    javascriptreact = js_formatters,

    astro = js_formatters,
    svelte = js_formatters,

    nix = { 'nixpkgs_fmt' },
  },
}

vim.keymap.set('n', '<leader>;', function()
  local handle = create_format_progress_handle()

  conform.format({ async = true, quiet = true, lsp_fallback = true }, function(err)
    if handle then handle:finish() end
    if err then vim.notify(err, vim.log.levels.WARN) end
  end)
end, { desc = 'Format buffer' })

vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})

vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})
