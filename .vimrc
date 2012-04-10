" +---------------------------------------------------------------------------+
" |                            VIM Settings                                   |
" |                   (see gvimrc for gui vim settings)                       |
" |                                                                           |
" | Some highlights:                                                          |
" |   ,n = toggle NERDTree off and on                                         |
" |   ,c = comment block/line with TComment                                   |
" |                                                                           |
" |   ,p = go to previous file                                                |
" |                                                                           |
" |   ,i = toggle invisibles                                                  |
" |   ,v = toggle paste mode on/off                                           |
" |   ,<Space> = clear search highlight                                       |
" |                                                                           |
" |   ,s = search and replace word under cursor                               |
" |                                                                           |
" |                                                                           |
" | Put machine/user specific settings in ~/.vimrc.local                      |
" +---------------------------------------------------------------------------+

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Required!
Bundle 'gmarik/vundle'

"Bundle 'AutoComplPop'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Shougo/neocomplcache'
"Bundle 'Shougo/neocomplcache-snippets-complete'
Bundle 'SirVer/ultisnips'
Bundle 'ap/vim-css-color'
Bundle 'ervandew/supertab'
Bundle 'fs111/pydoc.vim'
Bundle 'gregsexton/MatchTag'
"Bundle 'honza/snipmate-snippets'
Bundle 'kien/ctrlp.vim'
Bundle 'klen/python-mode'
Bundle 'majutsushi/tagbar'
"Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'vim-pandoc/vim-pandoc'

" Plugin variables
let NERDCreateDefaultMappings = 0             " Don't create default NERDCommenter keymappings
let NERDTreeIgnore = ['\.pyc$']               " Browser skiplist
let NERDTreeMouseMode = 1                     " Single click for everything
let g:syntastic_enable_signs = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_check_on_open = 1
let g:CommandTMatchWindowAtTop = 1
let g:Powerline_symbols  =  'fancy'           " Custom font tokens
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1

let g:pymode_doc = 0                         " Load show documentation plugin
let g:pymode_run = 0                         " Load run code plugin
let g:pymode_run_key = '<Leader>r'           " Key for run python code
let g:pymode_lint = 0                        " Disable pylint code plugin

let g:pymode_rope = 1                        " Load rope plugin
let g:pymode_rope_auto_project = 1           " Auto create and open ropeproject
let g:pymode_rope_enable_autoimport = 1      " Enable autoimport
let g:pymode_rope_autoimport_generate = 1    " Auto generate global cache
let g:pymode_rope_autoimport_underlineds = 0
let g:pymode_rope_extended_complete = 1
let g:pymode_rope_autoimport_modules = ["os","shutil","datetime"]
let g:pymode_rope_confirm_saving = 1
let g:pymode_rope_vim_completion = 0
let g:pymode_rope_guess_project = 1
let g:pymode_rope_goto_def_newwin = 0
let g:pymode_rope_always_show_complete_menu = 0

let g:pymode_folding = 0                     " Disable python folding
let g:pymode_motion = 0                      " Disable python objects and motion
let g:pymode_virtualenv = 1                  " Auto fix vim python paths if virtualenv enabled
let g:pymode_breakpoint = 0                  " Disable breakpoints plugin
let g:pymode_utils_whitespaces = 0           " Disable autoremove unused whitespaces

let g:pymode_syntax = 1                      " Enable pymode's custom syntax highlighting
let g:pymode_syntax_all = 0                  " Don't enable all python highlightings
let g:pymode_syntax_print_as_function = 0    " Highlight 'print' as function
let g:pymode_syntax_indent_errors = 1        " Highlight indentation errors
let g:pymode_syntax_space_errors = 1         " Highlight trailing spaces
let g:pymode_syntax_string_formatting = 1    " Highlight string formatting
let g:pymode_syntax_string_format = 1        " Highlight str.format syntax
let g:pymode_syntax_string_templates = 1     " Highlight string.Template syntax
let g:pymode_syntax_doctests = 1             " Highlight doc-tests
let g:pymode_syntax_builtin_objs = 1         " Highlight builtin objects (__doc__, self, etc)
let g:pymode_syntax_builtin_funcs = 1        " Highlight builtin functions
let g:pymode_syntax_highlight_exceptions = 1 " Highlight exceptions

"let g:ctrlp_working_path_mode = 0           " 0 - don't manage working directory.
let g:ctrlp_root_markers = ['.ctrlp']        " Add custom root markers
" Skip our custom root marker when searching
let g:ctrlp_custom_ignore = {
	\ 'dir': '\node_modules$\|env$',
	\ 'file': '\.ctrlp$',
	\ }

" Color schemes
Bundle 'altercation/vim-colors-solarized'
Bundle 'robokai'
Bundle 'tomasr/molokai'
Bundle 'wgibbs/vim-irblack'
Bundle 'trapd00r/neverland-vim-theme'
Bundle 'Diablo3'
Bundle 'jpo/vim-railscasts-theme'
Bundle 'github-theme'
Bundle 'Lucius'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'noahfrederick/Hemisu'
Bundle 'nanotech/jellybeans.vim'
Bundle 'sjl/badwolf'

" +---------------------------------------------------------------------------+
" | Basic settings                                                            |
" +---------------------------------------------------------------------------+

filetype plugin indent on

syntax on
" Enable 256 colors
set t_Co=256

" Used by the Solarized theme if the terminal isn't using Solarized colors
let g:solarized_termcolors=256

" To show original monokai background color
let g:molokai_original=1

set background=dark

"colorscheme Tomorrow-Night
"colorscheme Tomorrow-Night-Bright
"colorscheme Tomorrow-Night-Eighties
"colorscheme badwolf
colorscheme diablo3
"colorscheme github
"colorscheme hemisu
"colorscheme hunch-dark
"colorscheme hunch-dark-dimmed
"colorscheme ir_black
"colorscheme jellybeans
"colorscheme lucius
"colorscheme molokai
"colorscheme neverland
"colorscheme neverland2
"colorscheme railscasts
"colorscheme robokai
"colorscheme solarized
if has('gui_running')
	colorscheme github
endif

" Extended matching for the % command, good for HTML/XML tags
runtime macros/matchit.vim

" Show line numbers
set number

" Sets the character encoding used inside Vim
set encoding=utf-8
" Don't append a Byte-order Mark (BOM)
set nobomb

" Set the window title to 'titlestring'
set title

" Enable mouse in all modes
set mouse=a
" Enable copy/paste between vim and system clipboard
set clipboard=unnamed

" Change delete lines character in diffs, vert is default
set fillchars=diff:⣿,vert:│

" Don't wrap text
set nowrap
" Dont't wrap text in the middle of a word
set linebreak
" String to put at the start of lines that have been wrapped
set showbreak=↪
" The minimum number of columns to scroll horizontally
set sidescroll=5
" Minimum number of screen lines to keep above and below the cursor
set scrolloff=5

" When a bracket is inserted, briefly jump to the matching one.
set showmatch
" Also display matching <tag> tags (useful for HTML-like languages)
set matchpairs+=<:>

" Highlights the current cursor line
set cursorline

" Allows backspacing over autoindent, line breaks and the start of insert 
set backspace=indent,eol,start

" Always show the statusline
set laststatus=2
set statusline=\ [%l,%c\ %P]\ %m%f\ %r%h%w%=[%{strlen(&ft)?&ft:'none'},\ %{&encoding},\ %{&fileformat}]\ 

set listchars=tab:▸\ ,trail:.,eol:¬,precedes:❮,extends:❯

" Highlight searches
set hlsearch
" Shows search results as you type
set incsearch
" Case insensitive search
set ignorecase
" Use case sensitive search if the search string contains uppercase
set smartcase
" Assume the /g flag when search and replacing
set gdefault

" Indicates a fast terminal connection. More characters will be sent to the
" screen for redrawing
set ttyfast

let g:tabwidth = 4

exec 'set shiftwidth=' . g:tabwidth
exec 'set softtabstop=' . g:tabwidth
exec 'set tabstop=' . g:tabwidth
set smarttab
set shiftround

" Use tabs
set noexpandtab
" Use spaces
"set expandtab

" Fast switching between paste modes
set pastetoggle=<F5>

" Directory for swap files
silent execute '!mkdir -p $HOME/.vim/swap'
set directory=$HOME/.vim/swap

" Directory for backup files
silent execute '!mkdir -p $HOME/.vim/backup'
set backupdir=$HOME/.vim/backup

" Persistent undo history
silent execute '!mkdir -p $HOME/.vim/undo'
set undodir=$HOME/.vim/undo
set undofile

au BufReadPre,BufRead * if strlen(&key) | call SetupEncryption() | endif

" Ignore these when file completing
set wildignore+=.svn,CVS,.git,.hg            " Version control
set wildignore+=*.aux,*.out,*.toc            " LaTeX intermediate files
set wildignore+=*.swp                        " Vim swap files
set wildignore+=*.o,*.obj,*.exe,*.dll        " Compiled object files
set wildignore+=*.pyc                        " Python byte code
set wildignore+=*.luac                       " Lua byte code
set wildignore+=*.beam                       " Compiled Erlang files
set wildignore+=*.class                      " Compiled Java files
set wildignore+=*jpe?g,*.png,*.gif,*.bmp     " Images
set wildignore+=env,node_modules             " Virtualenv and Node.js folders
set wildignore+=lib,libs                     " Library folders
set wildignore+=*.DS_Store                   " OS X files

set wildmenu
set wildmode=list:longest,list:full
set completeopt=menuone,longest,preview

" Set encryption for Vim to blowfish
if version >= 700
	set cryptmethod=blowfish
endif

function SetupEncryption()
	set viminfo=
	setlocal bufhidden=wipe
	setlocal noswapfile
	setlocal nobackup
	setlocal nowritebackup
	setlocal foldmethod=indent
	setlocal foldlevel=0
	setlocal foldclose=all
	" move cursor over word and press 'e' to obfuscate/unobfuscate it
	noremap e g?iw
endfunction

" +---------------------------------------------------------------------------+
" | Script templates                                                          |
" +---------------------------------------------------------------------------+

au BufNewFile *.sh so ~/.vim/templates/tpl.sh
au BufNewFile *.py so ~/.vim/templates/tpl.py

" +---------------------------------------------------------------------------+
" | Remaps & Shortcuts                                                        |
" +---------------------------------------------------------------------------+

let mapleader = ','

" For the times you forget to open files as root/sudo
" Command: :w!!
cmap w!! %!sudo tee > /dev/null %

" Search and replace the word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" <Leader><Space> to clear search highlight
nnoremap <Leader><Space> :nohl<CR>

" Go to previous file
map <Leader>p <C-^>

" Set working directory
nnoremap <Leader>. :lcd %:p:h<CR>

" Toggle NERDTree on/off
noremap <Leader>n :NERDTreeToggle<CR>

" Toggle comments (TComment)
map <Leader>c :TComment<CR>

" Load the Gundo window
map <Leader>g :GundoToggle<CR>

" Rope (not installed atm)
map <Leader>j :RopeGotoDefinition<CR>
"map <Leader>r :RopeRename<CR>

" Neocomplcache
" <CR>: close popup and save indent
inoremap <expr><CR> neocomplcache#smart_close_popup()."\<CR>"

"" <Tab>: completion.
"au VimEnter * inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"au VimEnter * inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"

" Plugin key-mappings (SnipMate)
"imap <C-k> <Plug>(neocomplcache_snippets_expand)
"smap <C-k> <Plug>(neocomplcache_snippets_expand)

" Don't display popup while navigating and deleting
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"

" SuperTab like snippets behavior.
"imap <expr><Tab> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<Tab>"

" Toggle invisible characters
noremap <Leader>i :set list!<CR>

" Highlight problem lines: more than 80 chars, trailing spaces, only whitespace
" Toggle with <Leader>l
nnoremap <silent> <Leader>l
      \ :set nolist!<CR>:set nolist?<CR>
      \ :if exists('w:long_line_match') <Bar>
      \     silent! call matchdelete(w:long_line_match) <Bar>
      \     unlet w:long_line_match <Bar>
      \ elseif &textwidth > 0 <Bar>
      \     let w:long_line_match = matchadd('ErrorMsg', '\%>'.&tw.'v.\+', -1) <Bar>
      \ else <Bar>
      \     let w:long_line_match = matchadd('ErrorMsg', '\%>80v.\+', -1) <Bar>
      \ endif<CR>

" +---------------------------------------------------------------------------+
" | Auto commands                                                             |
" +---------------------------------------------------------------------------+

" Only show cursorline in the current window and in normal mode.
augroup cline
	au!
	au WinLeave * set nocursorline
	au WinEnter * set cursorline
	au InsertEnter * set nocursorline
	au InsertLeave * set cursorline
augroup END

" Only show colorcolumn in the current window.
augroup ccol
    au!
    au WinLeave * setlocal colorcolumn=0
    au WinEnter * setlocal colorcolumn=+1
augroup END

augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END

function! ColorColumn()
	setlocal colorcolumn=+1
	highlight ColorColumn ctermbg=black ctermfg=white guibg=darkgrey guifg=white
endfunction

au FileType pandoc call ColorColumn()
au FileType pandoc set wrap wrapmargin=2 textwidth=78

" Enable wrapping for txt files
au BufRead,BufNewFile *.txt set wrap wrapmargin=2 textwidth=78

" Make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python setlocal expandtab tabstop=4 shiftwidth=4 textwidth=79

" Ruby uses 2 spaces for indentation
au FileType ruby setlocal expandtab tabstop=2 shiftwidth=2

" Resize splits when the window is resized
au VimResized * :wincmd =

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" When editing a file, always jump to the last known cursor position.
au BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\     execute "normal g`\"" |
	\ endif

" Helps if you have to use another editor on the same file
au FileChangedShell *
    \ echohl WarningMsg |
    \ echo 'File has been changed outside of Vim.' |
    \ echohl None

" Outputs a small warning when opening a Python file that contains tab characters
function! WarnTabs()
    let save_cursor = getpos('.')
    if searchpos('\t') != [0,0]
        echohl WarningMsg |
        \ echo 'Warning, this file contains tabs.' |
        \ echohl None
    endif
    call setpos('.', save_cursor)
endfunction
au BufReadPost *.py call WarnTabs()

if has("python")
" Add the virtualenv's site-packages to vim path
py << EOF
import os.path, sys, vim
if 'VIRTUAL_ENV' in os.environ:
	project_base_dir = os.environ['VIRTUAL_ENV']
	sys.path.insert(0, project_base_dir)
	activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
	execfile(activate_this, dict(__file__=activate_this))
EOF
endif

" +---------------------------------------------------------------------------+
" |                             OS Specific                                   |
" |                      (GUI stuff goes in gvimrc)                           |
" +---------------------------------------------------------------------------+

if has("gui")
	set guioptions-=m  " Remove menu bar
	set guioptions-=T  " Remove toolbar
endif

if has("gui_macvim")
    " Fullscreen takes up entire screen
	set fuoptions=maxhorz,maxvert

    " Command-Return for fullscreen
    macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

	" MacVIM shift+arrow-keys behaviour (required in .vimrc)
	"let macvim_hig_shift_movement = 1

    " Command-][ to increase/decrease indentation
    vmap <D-]> >gv
    vmap <D-[> <gv
	
	" Map tab switch to cmd-<number>
	map <D-1> :tabn 1<CR>
	map <D-2> :tabn 2<CR>
	map <D-3> :tabn 3<CR>
	map <D-4> :tabn 4<CR>
	map <D-5> :tabn 5<CR>
	map <D-6> :tabn 6<CR>
	map <D-7> :tabn 7<CR>
	map <D-8> :tabn 8<CR>
	map <D-9> :tabn 9<CR>
	map! <D-1> <C-O>:tabn 1<CR>
	map! <D-2> <C-O>:tabn 2<CR>
	map! <D-3> <C-O>:tabn 3<CR>
	map! <D-4> <C-O>:tabn 4<CR>
	map! <D-5> <C-O>:tabn 5<CR>
	map! <D-6> <C-O>:tabn 6<CR>
	map! <D-7> <C-O>:tabn 7<CR>
	map! <D-8> <C-O>:tabn 8<CR>
	map! <D-9> <C-O>:tabn 9<CR>
endif
 
" Windows
if has("gui_win32")
  "" 
endif

" +---------------------------------------------------------------------------+ 
" |                               Host specific                               |
" +---------------------------------------------------------------------------+
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
