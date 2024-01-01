local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require("lazy").setup({
  'ojroques/nvim-bufdel',
  'tpope/vim-surround',

  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  {
      "David-Kunz/gen.nvim",
      opts = {
          model = "mistral", -- The default model to use.
          display_mode = "float", -- The display mode. Can be "float" or "split".
          show_prompt = true, -- Shows the Prompt submitted to Ollama.
          show_model = true, -- Displays which model you are using at the beginning of your chat session.
          no_auto_close = false, -- Never closes the window automatically.
          -- init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
          -- Function to initialize Ollama
          -- command = "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body",
          -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
          -- This can also be a lua function returning a command string, with options as the input parameter.
          -- The executed command must return a JSON object with { response, context }
          -- (context property is optional).
          -- list_models = '<omitted lua function>', -- Retrieves a list of model names
          debug = false -- Prints errors and the command which is run.
      }
  },

  {'edluffy/hologram.nvim',
    config=function()
      require('hologram').setup{
          auto_display = true -- WIP automatic markdown image display, may be prone to breaking
      }
    end,},
  {'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
      }
    end
  },

  -- -- Openai integration... probably will remove later.
  -- 'madox2/vim-ai',

  {'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },

  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'FelipeLema/cmp-async-path',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {}, tag = "legacy" },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
    config=function()
            require('autocomplete')
      end
  },

  {'noib3/nvim-cokeline',dependencies = {
    "nvim-tree/nvim-web-devicons",
  },config=function()
	require('cokeconf')
  end
  },
  {"nvim-neo-tree/neo-tree.nvim",dependencies={
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  branch="v3.x",
  }

})


vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' ,'html','htmldjango','javascript','json','yaml'},

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

require'lspconfig'.pyright.setup{}
