set t_Co=256
set encoding=utf-8
set mouse=a
set colorcolumn=80
set synmaxcol=0  " don't limit syntax coloring length
set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/tools/powerline/powerline/bindings/vim
set rtp+=~/.vim/bundle/Vundle.vim

" windowswap
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>

call vundle#begin()
"let g:vundle_default_git_proto='git'
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:golang_root = '/usr/local/bin'

Plugin 'junegunn/fzf'
"Plugin 'Yggdroot/LeaderF'
Plugin 'gmarik/Vundle.vim'
Plugin 'airblade/vim-gitgutter'  " git integration
"Plugin 'ekalinin/Dockerfile.vim'
Plugin 'tpope/vim-fugitive'
"Plugin 'tomasr/molokai'
Plugin 'morhetz/gruvbox'
"Plugin 'tpope/vim-repeat'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
"Plugin 'sjl/gundo.vim'  " undo tree
Plugin 'mbbill/undotree'  " undo tree
Plugin 'Valloric/YouCompleteMe'
Plugin 'davidhalter/jedi-vim'   " autocomplete
Plugin 'github/copilot.vim'
"Plugin 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }  " in conflict with jedi-vim
"Plugin 'scrooloose/syntastic'  " style checking
Plugin 'w0rp/ale'  " style checking
Plugin 'psf/black', { 'branch': 'stable' }
Plugin 'martinda/Jenkinsfile-vim-syntax'  " Jenkinsfile syntax
Plugin 'tell-k/vim-autopep8'  " automatic linting
Plugin 'scrooloose/nerdtree'   " panel with files
Plugin 'Xuyuanp/nerdtree-git-plugin'  " git marks for nerdtree
Plugin 'scrooloose/nerdcommenter'  " commenting
"Plugin 'altercation/vim-colors-solarized'
"Plugin 'Lokaltog/vim-distinguished'
"Plugin 'wincent/Command-T'
"Plugin 'editorconfig/editorconfig-vim'
"Plugin 'vim-scripts/vcscommand.vim'
"Plugin 'fatih/vim-go'
"Plugin 'Gundo'
Plugin 'reedes/vim-wordy'  " spell checking
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}  " powerline
Plugin 'mileszs/ack.vim'  " Ack
"Plugin 'Raimondi/delimitMate'
"Plugin 'terryma/vim-multiple-cursors'
"Plugin 'tmhedberg/SimpylFold'
"Plugin 'dbsr/vimpy'
Plugin 'jmcantrell/vim-virtualenv'
"Plugin 'wting/rust.vim'
Plugin 'fisadev/vim-isort'  " sorting imports
Plugin 'wookayin/vim-autoimport'  " autoimports

"dodatkowe pluginy
Plugin 'majutsushi/tagbar'
Plugin 'BufOnly.vim'
Plugin 'wesQ3/vim-windowswap'
Plugin 'gilsondev/searchtasks.vim'
"Plugin 'rentalcustard/exuberant-ctags'
Plugin 'craigemery/vim-autotag'
Plugin 'reedes/vim-pencil'

" YAML
Plugin 'chase/vim-ansible-yaml'

" snipety
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'


call vundle#end()
" ==========================================================
" Shortcuts
" ==========================================================
let mapleader=","             " change the leader to be a comma vs slash

" sudo write this
cmap W! w !sudo tee % >/dev/null

" Reload Vimrc
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" open/close the quickfix window
"nmap <leader>c :copen<CR>
"nmap <leader>cc :cclose<CR>

" resizign splits
map <leader>> <C-W>>
map <leader>< <C-W><
map <leader>+ <C-W>+
map <leader>- <C-W>-


" ctrl-jklm to navigate between split buffers
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" navigate between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" and lets make these all work in insert mode too ( <C-O> makes next cmd
"  happen as if in command mode )
imap <C-W> <C-O><C-W>

" ==========================================================
" Aliases
" ==========================================================
cnoreabbrev ntf NERDTreeFind

" ==========================================================
" Basic Settings
" ==========================================================
syntax on                     " syntax highlighing
filetype on                   " try to detect filetypes
filetype plugin indent on     " enable loading indent file for filetype
set number                    " Display line numbers
set title                     " show title in console title bar
set wildmenu                  " Menu completion in command mode on <Tab>
set wildmode=full             " <Tab> cycles between all matching choices.
set sts=4                     " set Tab to have 4 spaces
set ts=4                     " set Tab to have 4 spaces
set sw=4

" don't bell or blink
set noerrorbells
set vb t_vb=

"python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
  "project_base_dir = os.environ['VIRTUAL_ENV']
  "activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  "execfile(activate_this, dict(__file__=activate_this))
"EOF

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

" Set working directory to directory of file being edited
nnoremap <leader>. :lcd %:p:h<CR>

""" Moving Around/Editing
set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
"set wrap                    " Wrap text
set nowrap                  " don't Wrap text
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
"set smartindent             " use smart indent if there is no indent file
set tabstop=4               " <tab> inserts 4 spaces
set shiftwidth=4            " an indent level is 4 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set formatoptions=tcroql    " Setting text and comment formatting to auto
"set textwidth=120            " Lines are automatically wrapped after 120 columns
set textwidth=0              " Lines are not automatically wrapped
set linespace=3             " The spacing between lines is a little roomier
" << >> shift lines
"vnoremap < <gv
"vnoremap > >gv
set foldmethod=indent       " folding
set foldnestmax=10          " folding
set nofoldenable            " folding
set foldlevel=99            " folding

"""" Reading/Writing
set autowrite               " Stop complaining about unsaved buffers
set autowriteall            " I'm serious...
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
"set nofoldenable            " Disable folding, because recently `zO` has been the command I use most frequently

"""" Messages, Info, Status
set ls=2                    " allways show status line
"set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
"set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

" Paste from system clipboard
set clipboard=unnamed
map <leader>p "+p
map <leader>P "+P
map <leader>y "+y

" Quit window on <leader>q
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa!<CR>

" hide matches on <leader>space (rather than searching for something like " 'asdf')
nnoremap <leader><space> :nohlsearch<cr>

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" Select the item in the list with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Cycle through open buffers with Control + Spacebar
"map <C-space> :bn <CR>
"map <C-M-space> :bp <CR>

" I bet 90% of vim users have the following two lines in their .vimrc...
set background=dark
"colorscheme solarized
"colorscheme desert
colorscheme gruvbox
"colorscheme monokai
"colorscheme darcula

" Don't create swapfiles
set noswapfile
set nobackup
set nowritebackup

" Allow for undo even after closing and re-opening a file
if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif

" Make diffs *really* obvious
hi DiffText gui=underline guibg=red guifg=black


" ==========================================================
" Plugin Config
" ==========================================================

" Black
nnoremap <leader>b :Black<CR>
"let g:black_virtualenv = $VIRTUAL_ENV


"YouCompleteMe
"nnoremap <leader>b :YcmCompleter Format<CR>
"nnoremap <leader>d :aboveleft vertical YcmCompleter GoToDefinition<CR>
"nnoremap <leader>g :aboveleft vertical YcmCompleter GoToImplementation<CR>
"let g:ycm_goto_buffer_command = 'split'

" Isort
nnoremap <leader>i :Isort<CR>


" Gundo
" Load the Gundo window
"map <leader>g :GundoToggle<CR>
"nnoremap <F5> :GundoToggle<CR>

" UndoTree
nnoremap <F5> :UndotreeToggle<cr>

" jedi-vim
let g:jedi#usages_command = "<leader>u"
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#smart_auto_mappings = 1
let g:jedi#completions_enabled = 0

" syntastic: show errors from all linters at once
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['go', 'golint']

let g:syntastic_enable_signs = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"

" Set CtrlP to search by filename rather than path
let g:ctrlp_by_filename = 0
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*build/*
set wildignore+=*dist/*
set wildignore+=*.egg-info/*
set wildignore+=*/coverage/*
" Preview Markdown files with QuickLook
map <Leader>v :write<cr>:sil !/usr/bin/qlmanage -p % > /dev/null &<cr>:redraw!<cr>
set guifont=Sauce\ Code\ Powerline:h14
"autocmd FileType go autocmd BufWritePre <buffer> GoFmt
set expandtab               " Use spaces, not tabs, for autoindent/tab key.

"NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '\~$', '__pycache__']

" powerline"
"let g:Powerline_symbols = 'fancy'

" python-mode
"let g:pymode_run_bind = '<leader>r'
let g:pymode_run_bind = '<Nop>'
let g:pymode_breakpoint_bind = '<leader>b'
let g:pymode_rope_show_doc_bind = '<leader>pd'
let g:pymode_rope_find_it_bind='<leader>u'
let g:pymode_rope_goto_definition_bind = '<leader>pg'
let g:pymode_rope_goto_definition_cmd = 'vnew'
let g:pymode_rope_rename_bind = '<leader>pr'
let g:pymode_rope_module_to_package_bind = '<leader>p1p'
let g:pymode_rope_extract_method_bind = '<leader>pm'
let g:pymode_rope_extract_variable_bind = '<leader>pl'
let g:pymode_rope_use_function_bind = '<leader>pu'
let g:pymode_rope_move_bind = '<leader>pv'
let g:pymode_rope_change_signature_bind = '<leader>ps'
let g:pymode_lint=0
let g:pymode_lint_async=0
let g:pymode_lint_on_write=0
let g:pymode_lint_message=0
let g:pymode_python = 'python3'

let g:pymode_rope=0
let g:pymode_rope_autoimport=1
let g:pymode_rope_autoimport_import_after_complete=1


" vim-multiple-cursor
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<leader>b'
let g:multi_cursor_prev_key='<leader>x'
let g:multi_cursor_skip_key='<leader>z'
let g:multi_cursor_quit_key='<Esc>'

" vim autoimport settings
nmap <C-i> :ImportSymbol<CR>
imap <C-i> <Esc>:ImportSymbol<CR>

"" vimpy settings
"let g:vimpy_prompt_resolve = 1

" w0rp/ale settings
let g:ale_sign_column_always = 1
let g:ale_linters = {
\   'python': ['pylint', 'flake8'],
\}

" tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_position='rightbelow vertical'

" snippety
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


" ==========================================================
" Others
" ==========================================================
" highlight extra whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" run shell command from selected text
vnoremap <leader>x "zy:r! <C-R>"<CR>
