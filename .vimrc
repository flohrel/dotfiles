" #
" ## GENERAL ##
"
set nocompatible
" hidden buffer
set hidden
" utf-8 buffer
set encoding=utf-8
" utf-8 files
set fileencoding=utf-8
" enable mouse usage
set mouse=a
" to work with tmux
set ttymouse=xterm2
" plugin indent
set noautoindent
filetype indent plugin on
" replace blank chars
set list listchars=tab:│·,nbsp:␣,trail:•,extends:⟩,precedes:⟨
" electric parenthesis
set showmatch
" syntax color
syntax on
" syntax color correction for :
"  - script sh
autocmd FileType sh let g:is_posix = 1
"  - asm
autocmd BufRead *.s set ft=nasm
autocmd BufRead *.S set ft=nasm
autocmd BufRead *.asm set ft=nasm
" line number
set number
set relativenumber
" 4-char hard tab
set shiftwidth=4
set tabstop=4
" show current command
set showcmd
" show mode in status bar
set showmode


" #
" ## SEARCH ##
" #

" loop search
set wrapscan
" Press F4 to toggle highlighting on/off, and show current value.
noremap <F4> :set hlsearch! hlsearch?<CR>
set incsearch
" case insensitive search... except if uppercase
set ignorecase
set smartcase


" #
" ## COMPLETION ##
" #

" command completion
set wmnu
set wildmode=list:longest,list:full
" ignored files
set wildignore=*.o,*.r,*.so,*.sl
" insertion mode completion
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" dictionary completion (Ctrl-x Ctrl-k)
set dictionary+=/usr/share/dict/american-english


" #
" ## PLUGINS ##
" #

" F2 to toggle NERDTree
map <F2> :NERDTreeToggle<CR>
" show hidden files
let NERDTreeShowHidden=1
" if opening vim without file, open NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
