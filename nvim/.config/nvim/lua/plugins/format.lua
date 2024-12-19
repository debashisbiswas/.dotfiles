return {
  'stevearc/conform.nvim',
  config = function()
    local conform = require 'conform'

    local function create_format_progress_handle()
      local formatters, will_use_lsp = conform.list_formatters_to_run()

      local fmt_names = vim.tbl_map(function(format_info) return format_info.name end, formatters)

      -- TODO: this doesn't work - will_use_lsp is always false, even when using the lsp for formatting?
      if will_use_lsp then table.insert(fmt_names, 'lsp') end

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
          lsp_format = 'fallback',
        }, function(err)
          if err then
            if handle then
              handle:report { message = err }
              handle:cancel()
            else
              vim.notify(err, vim.log.levels.WARN)
            end
          else
            handle:finish()
          end
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

    vim.keymap.set('n', '<leader>f', function()
      local handle = create_format_progress_handle()

      conform.format({ async = true, lsp_format = 'fallback' }, function(err)
        if err then
          if handle then
            handle:report { message = err }
            handle:cancel()
          else
            vim.notify(err, vim.log.levels.WARN)
          end
        else
          handle:finish()
        end
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
  end,
}
