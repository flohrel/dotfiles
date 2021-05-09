" ## General ##

set nocompatible

" Encodage par défaut des buffers en utf-8
set encoding=utf-8
" Encodage par défaut des fichiers en utf-8
set fileencoding=utf-8

" enable mouse usage
set mouse=a

" Indentation par les plugins
set noautoindent
filetype indent plugin on

set list listchars=tab:│·,nbsp:␣,trail:•,extends:⟩,precedes:⟨

" Parenthèses électriques
set showmatch

" Coloration syntaxique
syntax on

" Pour les fichiers shell script
" - corrige la coloration syntaxique
autocmd FileType sh let g:is_posix = 1

autocmd BufRead *.s set ft=nasm
autocmd BufRead *.S set ft=nasm
autocmd BufRead *.asm set ft=nasm

" Numerotation des lignes
set number
set relativenumber

" Permet d'ouvrir plusieurs fichiers (hidden buffer)
set hidden

" 4-char hard tab
set shiftwidth=4
set tabstop=4

" Show current command
set showcmd

" Affichage du mode dans la barre de statut
set showmode

" ## Recherche ##

" Retourne au début après avoir atteint la fin
set wrapscan
" Press F1 to toggle highlighting on/off, and show current value.
noremap <F9> :set hlsearch! hlsearch?<CR>
set incsearch
" case insensitive search... except if uppercase
set ignorecase
set smartcase

" ## Completion ##

" Complétion dans la barre de commande
set wmnu
set wildmode=list:longest,list:full
" Fichiers ignorés lors de la complétion
set wildignore=*.o,*.r,*.so,*.sl
  
" Complétion en mode insertion
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Complétion par dictionnaire (Ctrl-x Ctrl-k) 
set dictionary+=/usr/share/dict/american-english

" ## Plugins ##

" F2 to toggle
map <F2> :NERDTreeToggle<CR>
" Show hidden files
let NERDTreeShowHidden=1
" If opening vim without file, open NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
