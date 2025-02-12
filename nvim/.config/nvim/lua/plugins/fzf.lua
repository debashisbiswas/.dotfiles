return {
  'ibhagwan/fzf-lua',
  opts = {},
  keys = {
    { '<leader>?', function() require('fzf-lua').oldfiles() end, { desc = 'Search oldfiles' } },
    { '<leader>/', function() require('fzf-lua').grep_curbuf() end, { desc = '[/] Fuzzily search in current buffer' } },

    { '<leader>;', function() require('fzf-lua').commands() end, { desc = 'Search commands' } },

    { '<leader>ht', function() require('fzf-lua').colorschemes() end, { desc = 'Color schemes' } },

    { '<c-p>', function() require('fzf-lua').git_files() end, { desc = 'Search [G]it [F]iles' } },
    { '<leader>ss', function() require('fzf-lua').builtin() end, { desc = '[ ] Find existing buffers' } },
    { '<leader>sf', function() require('fzf-lua').files() end, { desc = '[S]earch [F]iles' } },
    { '<leader>sh', function() require('fzf-lua').helptags() end, { desc = '[S]earch [H]elp' } },
    { '<leader>sw', function() require('fzf-lua').grep_cword() end, { desc = '[S]earch current [W]ord' } },
    { '<leader>sg', function() require('fzf-lua').live_grep() end, { desc = '[S]earch by [G]rep' } },
    { '<leader>sd', function() require('fzf-lua').diagnostics_workspace() end, { desc = '[S]earch [D]iagnostics' } },
    { '<leader>sr', function() require('fzf-lua').resume() end, { desc = '[S]earch [R]esume' } },

    {
      '<leader>vc',
      function() require('fzf-lua').files { cwd = vim.fn.stdpath 'config' } end,
      desc = '[v]im [c]onfig',
    },

    {
      '<leader>vs',
      function() require('fzf-lua').live_grep { cwd = vim.fn.stdpath 'config' } end,
      desc = '[v]im [s]earch config',
    },
  },
}
