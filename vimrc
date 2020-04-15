call plug#begin()
" fzf (CLI program and vim plugin)
" General-purpose fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/dev/git/other/fzf' , 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" rust.vim
" Provides Rust file detection, syntax highlighting, formatting, Syntastic integration, and more.
Plug 'rust-lang/rust.vim'
" vim-racer
" Use racer for Rust code completion and navigation
" Note: This requires racer to be installed (`cargo +nightly install racer`)
Plug 'racer-rust/vim-racer'

" COLOR THEMES
" off
" No-color scheme for vim with my peronal changes
Plug 'omakk/vim-colors-off'
" Gruvbox
" Retro groove color scheme for Vim
Plug 'morhetz/gruvbox'
call plug#end()

if has('gui_running')
set guioptions-=m                       " Don't load menu bar
set guioptions-=r                       " Don't load right-scroll bar
set guioptions-=T                       " Don't load tools bar
set guioptions-=L                       " Don't load left-scroll bar
set guioptions+=a                       " Enable autoselect
endif

set nocompatible
filetype indent plugin on           " Load filetype-specific indent lines and plugins
syntax on                           " syntax processing

" Use 'true colors' in the terminal
set termguicolors
set background=dark
colorscheme gruvbox

set wildmenu                        " Visual autocomplete for command menu
set cursorline                      " Highlight current line
set autoindent                      " Copy indent from current line when starting new line
set nowrap                          " Disable visual wrapping
set mouse=a                         " Allow mouse support in all modes
set tags=./tags,tags                " Location of tags file

" Dont back up shit
set noswapfile
set nobackup
set nowritebackup

" Handle long lines
set wrap
set linebreak
set nolist
set textwidth=99
set formatoptions=cqrn1

" Tabs as spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Allow modelines
set modeline
set modelines=1

" Permanent undo
set undodir=~/.vimdid
set undofile

set incsearch                       " Search as characters are entered
set ignorecase                      " Ignore case when searching
set smartcase                       " Switch to case-sensitive search when using a capital letter
set hlsearch                        " Highlight matches
set showmatch                       " Highlight matching [({})]

set lazyredraw                      " Redraw only when we need to

set splitbelow                      " Open below when splitting horizontally
set splitright                      " Open to the right when splitting vertically

let mapleader=";"                   " Set leader to semicolon

" Turn off highlight search
nnoremap <leader><space> :nohlsearch<CR>    

" Switch between light and dark theme
nnoremap <leader>d :set bg=dark<CR>
nnoremap <leader>l :set bg=light<CR>

" Shortcut for splits
nnoremap <leader>q :split<CR>
nnoremap <leader>w :vsplit<CR>

" Shortcut to switch between last two buffers quicker
nnoremap <leader><leader> <C-^>

" Ctrl-[hjkl] to navigate between splits
nnoremap <C-h> <C-W><C-h>
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>

" Place current line at the center, top, and bottom of screen respectively
nnoremap <space> zz
nnoremap <space>t zt
nnoremap <space>b zb

" Make Y to act like D and C
" i.e. yank until EOL
nmap Y y$

" Move up and down on splitted lines
map <Up> gk
map <Down> gj
map k gk
map j gj

" Search visual selection with // when in visual mode
vnoremap // y/<C-R>"<CR>

" ALWAYS use clipboard for ALL operations
set clipboard+=unnamedplus

" Include newlines in between yanks
set cpoptions+=>

" Required for operations modifying multiple buffers
set hidden

" Mapping to determine the highlight group under the cursor
nnoremap <leader>hg :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") ."> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" ===================================================================
"                                                                   #
"                       Plugin Configuration                        #
"                                                                   #
" ===================================================================

" ========================= fzf =====================================
" Customize fzf colors to match colorscheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Use ripgrep when searching as to respect .gitignore
let $FZF_DEFAULT_COMMAND = "rg -g '!tags' --files"

" Prefix commands with 'Fzf'
let g:fzf_command_prefix = 'Fzf'

" Search files
nnoremap <leader>f :FzfFiles<CR>
" Open list of all open buffers
nnoremap <leader>bb :FzfBuffers<CR>
" Open list of all colorschemes
nnoremap <leader>c :FzfColors<CR>
" Open list of tags in the project
nnoremap <leader>t :FzfTags<CR>
" Open list of tags in the current buffer
nnoremap <leader>bt :FzfBTags<CR>
" Open files found in `git status`
nnoremap <leader>gs :FzfGFiles?<CR>

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

function! RipgrepFzf(query, fullscreen)
  " exclude ctags 'tags' file and any 'build/' directory
  let command_fmt = "rg -g '!tags' -g '!build/' --column --line-number --no-heading --color=always --smart-case %s || true"
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" :RG <query>
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" ===================================================================

" ========================== rust.vim ==============================
" Run rustfmt on save
let g:rustfmt_autosave = 1
" ===================================================================

" ========================== vim-racer ==============================
" Use experimental compeleter to get argument and return type information
let g:racer_experimental_completer = 1
" ===================================================================

" ========================== gruvbox ==============================
let g:gruvbox_bold = '0'
let g:gruvbox_italic = '0'
let g:gruvbox_underline = '0'
let g:gruvbox_undercurl = '0'

let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_contrast_light = 'hard'

let g:gruvbox_improved_warnings = '1'

let g:gruvbox_invert_selection = '0'
" ===================================================================
