call plug#begin()
" nvim-treesitter
" treesitter configs for nvim
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Update the parsers on update
" nvim-lspconfig
" A collection of common config for Neovim's built-in LSP
Plug 'neovim/nvim-lspconfig'
" plenary.nvim (required by telescope.nvim)
Plug 'nvim-lua/plenary.nvim'
" telescope.nvim
" Fuzzy finder
Plug 'nvim-telescope/telescope.nvim'
" telescope-fzf-native.nvim
" Native fzf support in telescope
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

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

" Turn on spell-checker on markdown files
autocmd FileType markdown setlocal spell

" Detect glsl files
autocmd BufNewFile,BufRead *.vs,*.fs,*.vert,*.tesc,*.tese,*.glsl,*.geom,*.frag,*.comp set ft=glsl

" ===================================================================
"                                                                   #
"                       Plugin Configuration                        #
"                                                                   #
" ===================================================================

" ====================== nvim-lspconfig =============================
lua <<EOF
local opts = { noremap=true, silent=true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ld', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'ccls' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
  }
end
EOF
" ===================================================================
" ===================== nvim-treesitter =============================
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "all",
  highlight = { enable = true },
  indent = { enable = true },
}
EOF
" ===================================================================

" ====================== telescope.nvim =============================
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>c <cmd>lua require('telescope.builtin').colorschemes()<cr>
nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>s <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>g <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>tt <cmd>lua require('telescope.builtin').tags()<cr>
"nnoremap <leader>tl <cmd>lua require('telescope.builtin').loclist()<cr>
"nnoremap <leader>tm <cmd>lua require('telescope.builtin').man_pages()<cr>
"nnoremap <leader>tq <cmd>lua require('telescope.builtin').quickfix()<cr>
"nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

lua <<EOF
local telescope = require('telescope')
telescope.setup{}
telescope.load_extension('fzf')
EOF
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
