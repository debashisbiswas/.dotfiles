return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',

  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function() return vim.fn.executable 'make' == 1 end,
    },
  },

  opts = {
    pickers = {
      find_files = {
        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
        find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
      },
      live_grep = {
        additional_args = { '--hidden' },
      },
    },
    defaults = {
      path_display = { 'smart' },
      file_ignore_patterns = { 'node_modules', '.git' },
    },
    extensions = { fzf = {} },
  },

  config = function(_, opts)
    require('telescope').setup(opts)
    require('telescope').load_extension 'fzf'
  end,

  keys = {
    -- See `:help telescope.builtin`
    { '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' } },
    { '<leader><leader>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' } },

    {
      '<leader>/',
      function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.,
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      { desc = '[/] Fuzzily search in current buffer' },
    },

    {
      '<leader>;',
      function()
        require('telescope.builtin').commands(require('telescope.themes').get_ivy {
          winblend = 10,
        })
      end,
      { desc = 'Telescope commands' },
    },

    { '<c-p>', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' } },
    { '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' } },
    { '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' } },
    { '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' } },
    { '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' } },
    { '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' } },
    { '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' } },

    {
      '<leader>vc',
      function() require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' } end,
      desc = '[v]im [c]onfig',
    },
    {
      '<leader>vs',
      function() require('telescope.builtin').live_grep { cwd = vim.fn.stdpath 'config' } end,
      desc = '[v]im [s]onfig',
    },
  },
}
