-- =======
-- PLUGINS
-- =======

local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add{
  -- My plugins here
  'nvim-tree/nvim-web-devicons';
  'nvim-tree/nvim-tree.lua';
  'debugloop/telescope-undo.nvim';  -- for telescope
  'nvim-lua/plenary.nvim';  -- for telescope
  'nvim-treesitter/nvim-treesitter';  -- for telescope
  {'nvim-telescope/telescope.nvim', tag = '0.1.8'};
  'davidhalter/jedi-vim';
  'airblade/vim-gitgutter';
  'tpope/vim-fugitive';
  { "stevanmilic/nvim-lspimport" };
  'neovim/nvim-lspconfig';

  --'sainnhe/gruvbox-material';
   'morhetz/gruvbox';

  --'github/copilot.vim';
  'dense-analysis/ale';
  {'psf/black', branch = 'stable'};
  'scrooloose/nerdcommenter';
  'vim-airline/vim-airline';
  'vim-airline/vim-airline-themes';
  'fisadev/vim-isort';
  'SirVer/ultisnips';
  'honza/vim-snippets';
  'dcampos/nvim-snippy';
  'wesQ3/vim-windowswap';

  'majutsushi/tagbar';
  'craigemery/vim-autotag';
}


require('nvim-tree').setup()



-- ==========================================================
-- Basic Settings
-- ==========================================================
vim.g.mapleader = ","

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
vim.g.python3_host_prog = '/usr/local/bin/python3.12'


-- abbreviations

vim.cmd [[ cnoreabbrev ntf NvimTreeFindFile ]]

-- =======
-- PLUGINS
-- =======

-- NvimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.api.nvim_set_keymap('', '<C-n>', ':NvimTreeToggle<CR>', {})

-- Telescope
require('telescope').setup({
  defaults = {
    mappings = {
      n = {
    	  ['d'] = require('telescope.actions').delete_buffer
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
})
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', telescope_builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>ff', telescope_builtin.grep_string, { desc = 'Telescope grep string under cursor' })
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope buffers' })

-- jedi-vim
vim.g['jedi#usages_command'] = '<leader>u'
vim.g['jedi#use_splits_not_buffers'] = 'left'
vim.g['jedi#smart_auto_mappings'] = 1
vim.g['jedi#completions_enabled'] = 1

-- ale
vim.g.ale_sign_column_always = 1
vim.g.ale_virtualtext_cursor = 0
vim.g.ale_linters = {
    python= {'pylint', 'pyright'},
    sh = {'language-server'}
}

-- black
vim.api.nvim_set_keymap('n', '<leader>b', ':Black<CR>', { noremap = true })


-- bash
require 'lspconfig'.bashls.setup {}


-- snippy

require('snippy').setup({
    mappings = {
        is = {
            ['<C-Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
        },
        nx = {
            ['<leader>x'] = 'cut_text',
        },
    },
})

-- windowswap
vim.g.windowswap_map_keys = 0  -- prevent default bindings
vim.api.nvim_set_keymap('n', '<leader>yw', ':call WindowSwap#MarkWindowSwap()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pw', ':call WindowSwap#DoWindowSwap()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ww', ':call WindowSwap#EasyWindowSwap()<CR>', { noremap = true, silent = true })

-- airline
vim.g.airline_theme = 'bubblegum'
vim.g.airline_powerline_fonts = 1
vim.g.airline_extensions = {'branch'}
vim.g.airline_section_x = ''
vim.g.airline_section_y = ''
vim.g.airline_section_z = ''

-- autoimport
vim.keymap.set("n", "<leader>a", require("lspimport").import, { noremap = true })

-- tagbar
vim.api.nvim_set_keymap('n', '<F8>', ':TagbarToggle<CR>', { noremap = true })
vim.g.tagbar_position = 'rightbelow vertical'

