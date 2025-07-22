vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- =======
-- PLUGINS
-- =======
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
          sections = {
            lualine_b = {{'filename', path=4}},
            lualine_c = {},
          },
          inactive_sections = {
            lualine_b = {{'filename', path=4}},
            lualine_c = {},
          },
        },
    },
    {'morhetz/gruvbox'},
    {'nvim-tree/nvim-web-devicons'},
    {'nvim-lua/plenary.nvim'},
    {
      'nvim-tree/nvim-tree.lua',
      opts = {
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      }
    },
    {'debugloop/telescope-undo.nvim'},
    {
      "nvim-treesitter/nvim-treesitter",
      branch = 'master',
      lazy = false,
      build = ":TSUpdate",
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python", "bash", },
      --auto_install = false,
    },
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
      lazy = false,
      dependencies = { 'nvim-lua/plenary.nvim' },
      opts = {
        defaults = {
          mappings = {
            n = {
               ['d'] = 'delete_buffer'
            }
          } -- mappings
        },
        pickers = {
          grep_string = {
            theme = "dropdown",
            layout_config={width=0.8}
          },
          live_grep = {
            theme = "dropdown",
            layout_config={width=0.8}
          },
          find_files = {
            layout_config={width=0.8}
          },
          buffers = {
            layout_config={width=0.8}
          },
        }
      }
    },
    {
      'davidhalter/jedi-vim',
      enabled=false,
      ft = { 'python' },
    },
    {
      'neoclide/coc.nvim',
      branch='release',
    },
    {'airblade/vim-gitgutter'},
    {'tpope/vim-fugitive'},
    {'stevanmilic/nvim-lspimport'},
    {'neovim/nvim-lspconfig'},
    {'github/copilot.vim', enabled=false},
    {
      'milanglacier/minuet-ai.nvim',
      opts={
        provider = 'openai_compatible',
        --notify = 'debug',
        n_completions = 1, -- recommend for local model for resource saving
        -- I recommend beginning with a small context window size and incrementally
        -- expanding it, depending on your local computing power. A context window
        -- of 512, serves as an good starting point to estimate your computing
        -- power. Once you have a reliable estimate of your local computing power,
        -- you should adjust the context window to a larger value.
        context_window = 512,
        provider_options = {
          openai_compatible = {
            -- For Windows users, TERM may not be present in environment variables.
            -- Consider using APPDATA instead.
            api_key = 'TERM',
            name = 'Ollama',
            end_point = 'http://localhost:11434/v1/chat/completions',
            model = 'qwen2.5-coder:1.5b',
            optional = {
              max_tokens = 56,
              top_p = 0.9,
            },
          },
        },

        lsp = {
          enabled_ft = {"pytyhon"},
        },
        cmp = {
          enable_auto_complete = false,
        },
        blink = {
          enable_auto_complete = false,
        },
        virtualtext = {
          -- Specify the filetypes to enable automatic virtual text completion,
          -- e.g., { 'python', 'lua' }. Note that you can still invoke manual
          -- completion even if the filetype is not on your auto_trigger_ft list.
          auto_trigger_ft = {"python", "bash", "sh", "lua"},
          enable_auto_complete = true,
          keymap = {
            accept = "<S-Tab>",
            --accept_line = "<C-Tab>",
            --accept_n_lines = "<S-Tab>",
            -- Cycle to next completion item, or manually invoke completion
            next = "<A-]>",
            -- Cycle to prev completion item, or manually invoke completion
            prev = "<A-[>",
            dismiss = "<A-e>",
          },
          -- Whether show virtual text suggestion when the completion menu
          -- (nvim-cmp or blink-cmp) is visible.
          show_on_completion_menu = false,
        },
        request_timeout = 3,
        --debounce = 1000;
      }
    },
    {
      "olimorris/codecompanion.nvim",
      opts = {
        strategies = {
          chat = {
            keymaps = {
              completion = {
                modes = {
                  i = "<C-space>",
                },
                index = 1,
                callback = "keymaps.completion",
                description = "Completion Menu",
              },
            },
          },
        },
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              make_vars = true,
              make_slash_commands = true,
              show_result_in_chat = true
            }
          },

          history = {
            enabled = true,
            opts = {
              -- Keymap to open history from chat buffer (default: gh)
              keymap = "gh",
              -- Keymap to save the current chat manually (when auto_save is disabled)
              save_chat_keymap = "sc",
              -- Save all chats by default (disable to save only manually using 'sc')
              auto_save = true,
              -- Number of days after which chats are automatically deleted (0 to disable)
              expiration_days = 0,
              -- Picker interface (auto resolved to a valid picker)
              picker = "telescope", --- ("telescope", "snacks", "fzf-lua", or "default")
              ---Optional filter function to control which chats are shown when browsing
              chat_filter = nil, -- function(chat_data) return boolean end
              -- Customize picker keymaps (optional)
              picker_keymaps = {
                  rename = { n = "r", i = "<M-r>" },
                  delete = { n = "d", i = "<M-d>" },
                  duplicate = { n = "<C-y>", i = "<C-y>" },
              },
              ---Automatically generate titles for new chats
              auto_generate_title = true,
              title_generation_opts = {
                ---Adapter for generating titles (defaults to current chat adapter)
                adapter = nil, -- "copilot"
                ---Model for generating titles (defaults to current chat model)
                model = nil, -- "gpt-4o"
                ---Number of user prompts after which to refresh the title (0 to disable)
                refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
                ---Maximum number of times to refresh the title (default: 3)
                max_refreshes = 3,
                format_title = function(original_title)
                    -- this can be a custom function that applies some custom
                    -- formatting to the title.
                    return original_title
                end
              },
              ---On exiting and entering neovim, loads the last chat on opening chat
              continue_last_chat = false,
              ---When chat is cleared with `gx` delete the chat from history
              delete_on_clearing_chat = false,
              ---Directory path to save the chats
              dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
              ---Enable detailed logging for history extension
              enable_logging = false,

              -- Summary system
              summary = {
                -- Keymap to generate summary for current chat (default: "gcs")
                create_summary_keymap = "gcs",
                -- Keymap to browse summaries (default: "gbs")
                browse_summaries_keymap = "gbs",
               
                generation_opts = {
                  adapter = nil, -- defaults to current chat adapter
                  model = nil, -- defaults to current chat model
                  context_size = 90000, -- max tokens that the model supports
                  include_references = true, -- include slash command content
                  include_tool_outputs = true, -- include tool execution results
                  system_prompt = nil, -- custom system prompt (string or function)
                  format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
                },
              },
             
              -- Memory system (requires VectorCode CLI)
              memory = {
                -- Automatically index summaries when they are generated
                auto_create_memories_on_summary_generation = true,
                -- Path to the VectorCode executable
                vectorcode_exe = "vectorcode",
                -- Tool configuration
                tool_opts = {
                    -- Default number of memories to retrieve
                    default_num = 10
                },
                -- Enable notifications for indexing progress
                notify = true,
                -- Index all existing memories on startup
                -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
                index_on_startup = false,
              },
            }
          },
        }
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "ravitemer/codecompanion-history.nvim",
        "MeanderingProgrammer/render-markdown.nvim",
        "franco-ruggeri/codecompanion-spinner.nvim",
      },
    },
    {
      "Davidyz/VectorCode",
      version = "*", -- optional, depending on whether you're on nightly or release
      dependencies = { "nvim-lua/plenary.nvim" },
      cmd = "VectorCode", -- if you're lazy-loading VectorCode
    },
    {
      "MeanderingProgrammer/render-markdown.nvim", -- Enhanced markdown rendering
      enabled = true,
      dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons", "echasnovski/mini.nvim" },
      ft = { "markdown", "codecompanion" },
      opts = {},
    },
    {
      "ravitemer/mcphub.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
      opts = {}
    },
    { 'echasnovski/mini.nvim', version = false },
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        filetypes = {
          codecompanion = {
            prompt_for_file_name = false,
            template = "[Image]($FILE_PATH)",
            use_absolute_path = true,
          },
        },
      },
      keys = {
        -- suggested keymap
        { "<localleader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
      },
    },
    {'dense-analysis/ale'},
    {'psf/black', branch = 'stable', enabled=false, ft = {'python'}},
    {'preservim/nerdcommenter'},
    {'vim-airline/vim-airline-themes'},
    {'fisadev/vim-isort', ft = {'python'}},
    {'SirVer/ultisnips'},
    {'honza/vim-snippets'},
    {
      'dcampos/nvim-snippy',
      enabled=false,
      opts = {
        mappings = {
          is = {
            ['<Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
          },
          nx = {
            ['<leader>x'] = 'cut_text',
          },
        },
      }
    },
    {'wesQ3/vim-windowswap'},
    {'majutsushi/tagbar'},
    {'craigemery/vim-autotag'},

  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "gruvbox" } },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})


-- ==========================================================
-- Basic Settings
-- ==========================================================
vim.cmd [[ cnoremap <C-p> <Up> ]]
vim.cmd [[ cnoremap <C-n> <Down> ]]

vim.api.nvim_win_set_option(0, 'number', true)  -- Display line numbers
vim.api.nvim_win_set_option(0, 'title', true)  -- show title in console title bar
vim.api.nvim_win_set_option(0, 'wildmenu', true)  -- Menu completion in command mode on <Tab>
vim.api.nvim_win_set_option(0, 'wildmode', 'full')  -- <Tab> cycles between all matching choices.
vim.api.nvim_win_set_option(0, 'cursorline', true)  -- have a line indicate the cursor location
vim.api.nvim_win_set_option(0, 'ruler', true)  -- show the cursor position all the time
vim.api.nvim_win_set_option(0, 'virtualedit', 'block')  -- Let cursor move past the last char in <C-v> mode
vim.api.nvim_win_set_option(0, 'scrolloff', 3)  -- Keep 3 context lines above and below the cursor
vim.api.nvim_win_set_option(0, 'backspace', '2')  -- Allow backspacing over autoindent, EOL, and BOL
vim.api.nvim_win_set_option(0, 'showmatch', true)  -- Briefly jump to a paren once it's balanced
vim.api.nvim_win_set_option(0, 'linebreak', true)  -- don't wrap text in the middle of a word
vim.api.nvim_win_set_option(0, 'autoindent', true)  -- always set autoindenting on
vim.api.nvim_win_set_option(0, 'tabstop', 4)  -- <tab> inserts 4 spaces
vim.api.nvim_win_set_option(0, 'shiftwidth', 4)  -- an indent level is 4 spaces wide.
vim.api.nvim_win_set_option(0, 'softtabstop',4)  -- <BS> over an autoindent deletes both spaces.
vim.api.nvim_win_set_option(0, 'expandtab', true)  -- Use spaces, not tabs, for autoindent/tab key.
vim.api.nvim_win_set_option(0, 'shiftround', true)  -- rounds indent to a multiple of shiftwidth
vim.api.nvim_win_set_option(0, 'formatoptions', 'tcroql')  -- Setting text and comment formatting to auto
vim.api.nvim_win_set_option(0, 'foldenable', false)  -- folding
vim.api.nvim_win_set_option(0, 'encoding', 'utf-8')
vim.api.nvim_win_set_option(0, 'colorcolumn', '80')
vim.api.nvim_win_set_option(0, 'synmaxcol', 0)
vim.api.nvim_win_set_option(0, 'autoread', false)  -- Don't automatically re-read changed files.
vim.api.nvim_win_set_option(0, 'modeline', true)  -- Allow vim options to be embedded in files;
vim.api.nvim_win_set_option(0, 'swapfile', false)
vim.api.nvim_win_set_option(0, 'wrap', false)
vim.api.nvim_win_set_option(0, 'undofile', true)
vim.cmd [[ set spell ]]

-- Messages, Info, Status
vim.api.nvim_set_option('ls', 2)  -- allways show status line
vim.api.nvim_set_option('showcmd', true)  -- Show incomplete normal mode commands as I type.
vim.api.nvim_set_option('report', 0)  -- : commands always print changed line count.
vim.api.nvim_set_option('laststatus', 2)  -- Always show statusline, even if only 1 window.

-- Searching and Patterns
vim.api.nvim_set_option('ignorecase', true)  -- Default to using case insensitive searches,
vim.api.nvim_set_option('smartcase', true)  -- unless uppercase letters are used in the regex.
vim.api.nvim_set_option('hlsearch', true)  -- Highlight searches by default.
vim.api.nvim_set_option('incsearch', true)  -- Incrementally search while typing a /regex

-- Paste from system clipboard
vim.cmd [[ set clipboard=unnamed ]]
vim.api.nvim_set_keymap('', '<leader>p', '"+p', {})
vim.api.nvim_set_keymap('', '<leader>P', '"+P', {})
vim.api.nvim_set_keymap('', '<leader>y', '"+y', {})

-- quit and reload
vim.cmd [[ nnoremap <leader>q :q<CR> ]]
vim.cmd [[ nnoremap <leader>Q :qa!<CR> ]]
vim.cmd [[ nnoremap <leader>e :e!<CR> ]]

vim.api.nvim_set_keymap('n', '<leader><space>', ':nohlsearch<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><S>', ':%s/\\s\\+$//<cr>:let @/=\'\'<CR>', { noremap = true})

-- sudo write this
vim.api.nvim_set_keymap('c', 'W!', 'w !sudo tee % > /dev/null', {})

-- Reload Vimrc
vim.api.nvim_set_keymap('', '<leader>V', ':source ~/.config/nvim/init.lua<CR>:filetype detect<CR>:exe ":echo \'vimrc reloaded\'"<CR>', {})

-- resizign splits
vim.api.nvim_set_keymap('', '<leader>>', '<C-W>>', {})
vim.api.nvim_set_keymap('', '<leader><', '<C-W><', {})
vim.api.nvim_set_keymap('', '<leader>+', '<C-W>+', {})
vim.api.nvim_set_keymap('', '<leader>-', '<C-W>-', {})

-- ctrl-jklm to navigate between split buffers
vim.api.nvim_set_keymap('', '<c-j>', '<c-w>j', {})
vim.api.nvim_set_keymap('', '<c-k>', '<c-w>k', {})
vim.api.nvim_set_keymap('', '<c-l>', '<c-w>l', {})
vim.api.nvim_set_keymap('', '<c-h>', '<c-w>h', {})
vim.api.nvim_set_keymap('i', '<C-W>', '<C-O><C-W>', {})

-- navigate between tabs
vim.api.nvim_set_keymap('', '<Leader>n', '<esc>:tabprevious<CR>', {})
vim.api.nvim_set_keymap('', '<Leader>m', '<esc>:tabnext<CR>', {})

-- colors
vim.api.nvim_set_option('background', 'dark')
--vim.cmd [[ colorscheme gruvbox-material ]]
vim.cmd [[ colorscheme gruvbox ]]
vim.cmd [[ hi DiffText gui=underline guibg=red guifg=black ]]

-- Providers
vim.g.python3_host_prog = '/usr/bin/python3'

-- abbreviations
vim.cmd [[ cnoreabbrev ntf NvimTreeFindFile ]]

-- =======
-- PLUGINS
-- =======
-- airline
vim.g.airline_theme = 'bubblegum'
vim.g.airline_powerline_fonts = 1
vim.g.airline_extensions = {'branch'}
vim.g.airline_section_x = ''
vim.g.airline_section_y = ''
vim.g.airline_section_z = ''

-- ale
vim.g.ale_sign_column_always = 1
vim.g.ale_virtualtext_cursor = 0
vim.g.ale_linters = {
  python = {'pylint', 'pyright'},
  sh = {'language-server'}
}

-- autocmds
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "codecompanion" },
    callback = function()
        vim.treesitter.start()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua" },
    callback = function()
        vim.api.nvim_win_set_option(0, 'tabstop', 2)
        vim.api.nvim_win_set_option(0, 'shiftwidth', 2)
        vim.api.nvim_win_set_option(0, 'softtabstop', 2)
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python" },
    callback = function()
        vim.b.coc_root_patterns = {'.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json'}
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "gitcommit" },
    callback = function()
        vim.api.nvim_win_set_option(0, 'colorcolumn', '70')
    end,
})

-- autoimport
vim.keymap.set("n", "<leader>a", require("lspimport").import, { noremap = true })

-- black
vim.api.nvim_set_keymap('n', '<leader>b', ':Black<CR>', { noremap = true })

-- coc
vim.keymap.set("n", "<leader>d", "<Plug>(coc-definition)", {silent = true})
vim.keymap.set("n", "<leader>u", "<Plug>(coc-references)", {silent = true})
vim.keymap.set("n", "<leader>r", "<Plug>(coc-rename)", {silent = true})
vim.keymap.set("i", "<c-space>", "coc#refresh()", {silent = true, noremap = true, expr=true})
vim.keymap.set("i", "<cr>", 'coc#pum#visible() ? coc#pum#confirm() : "<CR>"', {silent = true, noremap = true, expr=true})

-- CodeCompanion
vim.api.nvim_set_keymap('n', '<leader>ct', ':CodeCompanionChat toggle<CR>', { noremap = true })

require("codecompanion").setup({
  adapters = {
    granite = function()
      return require("codecompanion.adapters").extend("ollama", {
        schema = {
          model = {
            default = "granite-code:3b",
            choices = {
              "granite-code:3b",
            },
          },
          num_ctx = {
            default = 125000,
          },
          num_predict = {
            default = -1,
          },
        },
      })
    end,
    qwen = function()
      return require("codecompanion.adapters").extend("ollama", {
        schema = {
          model = {
            default = "qwen3:1.7b",
            choices = {
              "qwen3:1.7b",
              "qwen2.5-coder:3b",
              "codeqwen:7b"
            },
          },
          num_ctx = {
            default = 40000,
            ["1.7b"] = 40000,
            ["qwen3:1.7b"] = 40000,
            ["3b"] = 32000,
            ["qwen2.5-coder:3b"] = 32000,
            ["codeqwen:7b"] = 64000,
          },
          num_predict = {
            default = -1,
          },
        },
      })
    end,
    deepseek = function()
      return require("codecompanion.adapters").extend("ollama", {
        schema = {
          model = {
            default = "deepseek-coder-v2:16b",
            choices = {
              "deepseek-coder-v2:16b",
            },
          },
          num_ctx = {
            default = 160000,
          },
          num_predict = {
            default = -1,
          },
        },
      })
    end,
  },
  strategies = {
    chat = {
      adapter = "qwen",
    },
    inline = {
      adapter = "qwen",
    },
    cmd = {
      adapter = "qwen",
    },
  },
})

-- jedi-vim
vim.g['jedi#usages_command'] = '<leader>u'
vim.g['jedi#use_splits_not_buffers'] = 'left'
vim.g['jedi#smart_auto_mappings'] = 1
vim.g['jedi#completions_enabled'] = 1
vim.g['jedi#goto_definitions_command'] = "<leader>d"

-- lsp-config
vim.lsp.enable('bashls')

-- lualine
require('lualine').setup()

-- NvimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.api.nvim_set_keymap('', '<C-n>', ':NvimTreeToggle<CR>', {})

-- tagbar
vim.api.nvim_set_keymap('n', '<F8>', ':TagbarToggle<CR>', { noremap = true })
vim.g.tagbar_position = 'rightbelow vertical'

-- Telescope
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', telescope_builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>ff', telescope_builtin.grep_string, { desc = 'Telescope grep string under cursor' })
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope buffers' })

-- windowswap
vim.g.windowswap_map_keys = 0  -- prevent default bindings
vim.api.nvim_set_keymap('n', '<leader>yw', ':call WindowSwap#MarkWindowSwap()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pw', ':call WindowSwap#DoWindowSwap()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ww', ':call WindowSwap#EasyWindowSwap()<CR>', { noremap = true, silent = true })
