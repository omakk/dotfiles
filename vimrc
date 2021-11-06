call plug#begin()
" fzf (CLI program and vim plugin)
" General-purpose fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/dev/git/other/fzf' , 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
" nvim-treesitter
" treesitter configs for nvim
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Update the parsers on update
" rust.vim
" Provides Rust file detection, syntax highlighting, formatting, Syntastic integration, and more.
Plug 'rust-lang/rust.vim'
" vim-racer
" Use racer for Rust code completion and navigation
" Note: This requires racer to be installed (`cargo +nightly install racer`)
Plug 'racer-rust/vim-racer'
" GLSL syntax highlighting
Plug 'tikhomirov/vim-glsl'

" COLOR THEMES
" off
" No-color scheme for vim with my peronal changes
Plug 'omakk/vim-colors-off'
" simple-grayscale
" My version on a light/dark grayscale theme forked from tek256/simple-dark
Plug 'omakk/simple-grayscale'
" dracula
Plug 'dracula/vim', { 'as': 'dracula' }
" ghdark
" Vim theme mimicking GitHub's dark mode
Plug 'wojciechkepka/vim-github-dark'
call plug#end()

if has('gui_running')
set guioptions-=m                       " Don't load menu bar
set guioptions-=r                       " Don't load right-scroll bar
set guioptions-=T                       " Don't load tools bar
set guioptions-=L                       " Don't load left-scroll bar
set guioptions+=a                       " Enable autoselect
set guifont=Iosevka\ Term\ 13           " GVim doesnt support ligatures (at least without some patch)
endif

if exists('g:GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Font', 'Iosevka Regular 12')
endif

set nocompatible
filetype indent plugin on           " Load filetype-specific indent lines and plugins
syntax on                           " syntax processing

" Use 'true colors' in the terminal
set termguicolors
set background=dark

set wildmenu                        " Visual autocomplete for command menu
set cursorline                      " Highlight current line
set autoindent                      " Copy indent from current line when starting new line
set nowrap                          " Disable visual wrapping
set mouse=a                         " Allow mouse support in all modes

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

let mapleader=" "                   " Set leader to <space>

" Terminal mode escape
tnoremap <Esc> <C-\><C-N>
tnoremap <ESC> <C-\><C-N>

" Turn off highlight search
nnoremap <leader>` :nohlsearch<CR>

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

" ========================= nvim-treesitter =========================
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "all",
  highlight = { enable = true },
  indent = { enable = true },
}
EOF
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
let $FZF_DEFAULT_COMMAND = "rg --files --hidden -g '!tags' -g '!.git'"

" Prefix commands with 'FZF'
let g:fzf_command_prefix = 'FZF'

" Search files
nnoremap <leader>f :FZF<CR>
" Open list of all open buffers
nnoremap <leader>b :FZFBuffers<CR>
" Open list of all colorschemes
nnoremap <leader>c :FZFColors<CR>
" Open list of tags in the project
nnoremap <leader>t :FZFTags<CR>
" Open list of tags in the current buffer
"nnoremap <leader>bt :FzfBTags<CR>
" Open files found in `git status`
nnoremap <leader>gs :FZFGFiles?<CR>

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

function! RipgrepFzf(query, fullscreen)
  " exclude ctags 'tags' file and any 'build/' directory
  let command_fmt = "rg -g '!tags' -g '!build/' --column --line-number --no-heading --color=always --smart-case %s || true"
  let initial_command = printf(command_fmt, shellescape(a:query))
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(), a:fullscreen)
endfunction

" :RG <query>
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" ===================================================================

" ========================== rust.vim ==============================
" Run rustfmt on save
let g:rustfmt_autosave = 1
" ===================================================================

" ========================== vim-glsl ==============================
autocmd BufNewFile,BufRead *.vert,*.tesc,*.tese,*.glsl,*.geom,*.frag,*.comp set filetype=glsl
" ==================================================================

" ========================== vim-racer ==============================
" Use experimental compeleter to get argument and return type information
let g:racer_experimental_completer = 1
" ===================================================================


" ===================================================================
"                                                                   #
"                   Colorscheme Configuration                       #
"                                                                   #
" ===================================================================

" ========================== dracula ==============================
let g:dracula_bold = 1
let g:dracula_italic = 1
let g:dracula_underline = 0
let g:dracula_undercurl = 0
let g:dracula_inverse = 1
let g:dracula_colorterm = 1
" ===================================================================

" Most colorscheme config must take place before setting the actual
" colorscheme
colorscheme ghdark
