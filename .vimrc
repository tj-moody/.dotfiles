"  _             _
" | |_ ___  ___ (_)
" | __/ _ \/ _ \| |
" | ||  __/  __/| |
"  \__\___|\___|/ |
"             |__/
" Minimal vimrc with no
" dependencies by TJ Moody
" https://github.com/tj-moody


set nocompatible

let mapleader = ","

set autoindent
set expandtab
set shiftround
set shiftwidth=4
set smarttab
set tabstop=4

set hlsearch
set ignorecase
set incsearch
set smartcase

set lazyredraw

set display+=lastline
set encoding=utf-8
set linebreak
set scrolloff=3
set sidescrolloff=5
syntax on
filetype plugin indent on

set laststatus=3
set ruler
set wildmenu
set cursorline
set number
set relativenumber
set mouse=a
set title
set wrap

set backspace=indent,eol,start
set matchpairs+=<:>
set confirm
set formatoptions+=j
set hidden
set history=1000
set nomodeline
set spell
set wildignore+=.pyc,.swp

set listchars=tab:▸\ ,eol:¬

set t_Co=256
set background=dark

nnoremap <leader>. :vsp .<CR>

nnoremap j gj
nnoremap k gk

nnoremap <leader>w :silent write<CR>
nnoremap <leader><leader>x :silent write<CR>:source<CR>:noh<CR>

nnoremap <leader>q :q<CR>
nnoremap <esc> :noh<CR>:echo ''<CR>

vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

nnoremap <CR> mzo<esc>`z
nnoremap <S-CR> mzO<esc>`z

nnoremap p ]p
vnoremap p "0p

nnoremap x "_x

nnoremap J mzJ`z

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap sl :vsp<CR>
nnoremap sj :sp<CR>
nnoremap se <c-w>=

vnoremap V j
nnoremap gV `[v`]

nnoremap <leader>o :silent only<CR>

nnoremap <leader>y "+y
vnoremap <leader>y "+y

vnoremap < <gv4h
vnoremap > >gv4h

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
