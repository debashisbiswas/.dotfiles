return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'isak102/telescope-git-file-history.nvim',
      dependencies = {
        'tpope/vim-fugitive',
      },
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  lazy = false,
  opts = {
    defaults = {
      layout_config = {
        prompt_position = 'top',
      },
      file_ignore_patterns = { 'node_modules', '.git' },
    },

    pickers = {
      find_files = {
        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d
        find_command = { 'rg', '--files', '--hidden', '--glob', '!.git' },
      },
      live_grep = {
        additional_args = { '--hidden' },
      },
    },
  },
  config = function(_, opts)
    require('telescope').setup(opts)
    require('telescope').load_extension 'fzf'
    require('telescope').load_extension 'git_file_history'

    vim.api.nvim_set_hl(0, 'TelescopeMatching', { link = 'Statement' })
    vim.api.nvim_set_hl(0, 'TelescopeTitle', { link = 'Statement' })
    vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { link = 'Statement' })
  end,
  keys = {
    { '<leader>fr', '<Cmd>Telescope oldfiles<CR>', { desc = 'Search oldfiles' } },
    {
      '<leader>/',
      function()
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = true,
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
    { '<leader>ht', '<Cmd>Telescope colorscheme<CR>', { desc = 'Color schemes' } },
    { '<leader>bb', '<Cmd>Telescope buffers<CR>', { desc = 'Buffers' } },

    { '<c-p>', '<Cmd>Telescope git_files<CR>', { desc = 'Search [G]it [F]iles' } },
    { '<leader>ss', '<Cmd>Telescope builtin<CR>', { desc = 'Search pickers' } },
    { '<leader>sf', '<Cmd>Telescope find_files<CR>', { desc = '[S]earch [F]iles' } },
    { '<leader>sh', '<Cmd>Telescope help_tags<CR>', { desc = '[S]earch [H]elp' } },
    { '<leader>sw', '<Cmd>Telescope grep_string<CR>', { desc = '[S]earch current [W]ord' } },
    { '<leader>sg', '<Cmd>Telescope live_grep<CR>', { desc = '[S]earch by [G]rep' } },
    {
      '<leader>sd',
      '<Cmd>Telescope diagnostics<CR>',
      { desc = '[S]earch [D]iagnostics' },
    },
    { '<leader>sr', '<Cmd>Telescope resume<CR>', { desc = '[S]earch [R]esume' } },

    {
      '<leader>vc',
      function() require('telescope.builtin').files { cwd = vim.fn.stdpath 'config' } end,
      desc = '[v]im [c]onfig',
    },

    {
      '<leader>vs',
      function() require('telescope.builtin').live_grep { cwd = vim.fn.stdpath 'config' } end,
      desc = '[v]im [s]earch config',
    },

    {
      '<leader>gh',
      function() require('telescope').extensions.git_file_history.git_file_history() end,
      desc = '[g]it file [h]istory',
    },
  },
}
