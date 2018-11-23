call plug#begin()
" NERDTree
" Tree explorer plugin
Plug 'scrooloose/nerdtree'

" fzf (CLI program and vim plugin)
" General-purpose fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/dev/git/other/fzf' }
Plug 'junegunn/fzf.vim'

" Deoplete
" An extensible and asynchronous completion framework for neovim/Vim8
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Deoplete-clangx
" C/C++ completion for deoplete using clang
Plug 'Shougo/deoplete-clangx'

" vim-cpp-modern
" Extended vim syntax highlighting for C/C++
Plug 'bfrg/vim-cpp-modern'

" COLOR THEMES
" Iosvkem
" Color theme that mimics colorscheme made to showcase the Iosevka typeface
Plug 'neutaaaaan/iosvkem'
call plug#end()

set nocompatible
filetype indent plugin on           " Load filetype-specific indent lines and plugins
syntax on                           " syntax processing

" Use 'true colors' in the terminal
set termguicolors
set background=dark
colorscheme Iosvkem                 " My own modifcation of blackdust.vim

set wildmenu                        " Visual autocomplete for command menu
set cursorline                      " Highlight current line
set autoindent                      " Copy indent from current line when starting new line
set nowrap                          " Disable visual wrapping

" Dont back up shit
set noswapfile
set nobackup
set nowritebackup

" From jessfraz/vimrc
" Makes vim handle long lines nicely
set wrap
set textwidth=99
set formatoptions=qrn1

" Tabs as spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Allow modelines
set modeline
set modelines=1

set number                          " Show line numbers
set relativenumber                  " Show line number relative to cursor line

set incsearch                       " Search as characters are entered
set ignorecase                      " Ignore case when searching
set smartcase                       " Switch to case-sensitive search when using a capital letter
set hlsearch                        " Highlight matches
set showmatch                       " Highlight matching [({})]

set lazyredraw                      " Redraw only when we need to

set splitbelow                      " Open below when splitting horizontally
set splitright                      " Open to the right when splitting vertically

let mapleader="`"                   " Set leader to comma

" Turn off highlight search
nnoremap <leader><space> :nohlsearch<CR>    

" Switch between light and dark theme
nnoremap <leader>bgd :set bg=dark<CR>
nnoremap <leader>bgl :set bg=light<CR>

" Shortcut for splits
nnoremap <leader>q :split<CR>
nnoremap <leader>w :vsplit<CR>

" Make Y to act like D and C
" i.e. yank until EOL
nmap Y y$

" Ctrl-[hjkl] to navigate between splits
nnoremap <C-h> <C-W><C-h>
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>

" Buffer prev/next
nnoremap <C-z> :bprev<CR>
nnoremap <C-x> :bnext<CR>

" Place current line at the center, top, and bottom of screen respectively
nnoremap <space> zz
nnoremap <space>t zt
nnoremap <space>b zb

" Move up and down on splitted lines
map <Up> gk
map <Down> gj
map k gk
map j gj

" Search visual selection with // when in visual mode
vnoremap // y/<C-R>"<CR>

" ALWAYS use clipboard for ALL operations
set clipboard+=unnamedplus

" Required for operations modifying multiple buffers
set hidden

" ===================================================================
"                                                                   #
"                       Plugin Configuration                        #
"                                                                   #
" ===================================================================

" ========================= NERDTree ================================
" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>
" ===================================================================

" ========================= fzf =====================================
" Shift-f to launch fzf
nnoremap <S-f> :FZF<CR>
" ===================================================================

" ========================= deoplete ================================
let g:deoplete#enable_at_startup = 1
" Close preview window when finishing a complete
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" Tab completion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" ===================================================================

" ===================== deoplete-clangx =============================
" Change clang binary path
call deoplete#custom#var('clangx', 'clang_binary', '/usr/bin/clang')

" Change clang options
call deoplete#custom#var('clangx', 'default_c_options', '')
call deoplete#custom#var('clangx', 'default_cpp_options', '')
" ===================================================================
