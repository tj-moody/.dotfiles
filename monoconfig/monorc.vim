"  _             _
" | |_ ___  ___ (_)
" | __/ _ \/ _ \| |
" | ||  __/  __/| |
"  \__\___|\___|/ |
"             |__/
" Minimal vimrc with no
" dependencies by TJ Moody
"   - Uses a modified version
"     of tpope's vim-commentary
" https://github.com/tj-moody

""" Opts"{{{
set term=xterm-256color
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

set laststatus=2
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
set formatoptions-=cro
set formatoptions+=j

set shortmess+=cC

set path+=**

set hidden
set history=1000
set nomodeline
autocmd FileType markdown setlocal spell
autocmd FileType text setlocal spell
autocmd FileType gitcommit setlocal spell
set wildignore+=.pyc,.swp

set splitbelow

set list

let &listchars ..= ',eol: ,tab:▸ '
let &fillchars ..= ',eob: ,fold: ,stl:─,stlnc:─,vert:│'

let g:netrw_banner = 0

set t_Co=256
set background=dark
"}}}
""" Mappings"{{{
nnoremap <leader>. :vsp .<CR>

nnoremap <leader>ff :e .<CR>

nnoremap j gj
nnoremap k gk

nnoremap <silent><leader>w :write<CR>
nnoremap <silent><leader><leader>x :silent write<CR>:source<CR>:noh<CR>

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

nnoremap H :bprev<CR>
nnoremap L :bnext<CR>

nmap <leader>c gc
xmap <leader>c gc

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

set timeoutlen=1000
set ttimeoutlen=5
"}}}
""" Appearance"{{{
set termguicolors

hi clear signcolumn
set signcolumn=yes
set foldcolumn=3
set numberwidth=3

function! CustomFoldText()
    return getline(v:foldstart)
endfunction

set foldtext=CustomFoldText()
"}}}
""" Statusline"{{{
set noshowmode
set statusline=

hi NormalColor guifg=#b8bb26
hi InsertColor guifg=#83a598
hi ReplaceColor guifg=#fb4934
hi VisualColor guifg=#fe8019

hi link ModeColor NormalColor

hi clear StatusLineNC
hi StatusLineNC guifg=#ebddb2
hi clear StatusLine
hi StatusLine guifg=#ebddb3

set statusline+=%#WinSeparator#%{'─────'}
set statusline+=\ "

let g:gitbranch=""
let g:ingit="false"
function! StatuslineGitBranch()
    let g:gitbranch=""
    if &modifiable
        try
            lcd %:p:h
        catch
            return
        endtry
        silent let l:gitrevparse=system("git rev-parse --abbrev-ref HEAD")
        lcd -
        if l:gitrevparse!~"fatal: not a git repository"
            let g:gitbranch="\ua0".substitute(l:gitrevparse, '\n', '', 'g')
                \ . "\ua0──\ua0"
            let g:ingit="true"
        else
            let g:ingit="false"
        endif
    endif
endfunction

augroup GetGitBranch
    autocmd!
    autocmd WinEnter * call StatuslineGitBranch()
augroup END

set statusline+=%#WinSeparator#%{g:gitbranch}

set statusline+=%#WinSeparator#%f            "file name
set statusline+=%#ReplaceColor#%m\     "modified flag

set statusline+=%#WinSeparator#%=

set statusline+=\  "
set statusline+=%#WinSeparator#%{%'\ %n'%}

set statusline+=%##%{&termencoding}
set statusline+=%#Comment#%{%(&ff=='dos')?'[]':''%}\ "
set statusline+=%#WinSeparator#%{%(&ff=='unix')?'':''%}\ "
set statusline+=%#Comment#%{%(&ff=='mac')?'[]':''%}\ "

set statusline+=%#WinSeparator#%{'─────'}
"}}}
""" Theme"{{{
hi clear CursorLine
hi clear CursorLineNr

hi ColorColumn guibg=#3c3836
hi Conceal guifg=#83a598
hi clear Cursor
hi link lCursor Cursor
hi clear CursorIM
hi link CursorColumn CursorLine
hi Directory term=bold guifg=#83a958
hi DiffAdd term=bold guibg=#2a4333
hi DiffChange term=bold guibg=#333841
hi DiffDelete term=bold guibg=#442d30
hi DiffText term=bold guibg=#213352
hi EndOfBuffer guifg=#504945
hi ErrorMsg guifg=#fb4934 guibg=NONE
hi VertSplit guifg=#ebdbb2 guibg=NONE term=NONE cterm=NONE
hi WinSeparator guifg=#ebdbb2 guibg=NONE term=NONE cterm=NONE
" hi Folded
" hi FoldColumn
hi clear FoldColumn
" hi SignColumn
hi IncSearch guifg=#fe8019
hi LineNr guifg=#7c6f64
hi link LineNrAbove LineNr
hi link LineNrBelow LineNr
hi CursorLineNr guifg=#fabd2f
hi link CursorLineFold FoldColumn
hi link CursorLineSign SignColumn
hi MatchParen guifg=#ebdbb2
hi clear ModeMsg
hi MoreMsg guifg=#fabd2f
hi clear NonText
hi Normal guifg=#ebdbb2
hi Pmenu guibg=#504945 guifg=#ebdbb2
hi PmenuSel term=bold guibg=#83a598 guifg=#504945
hi PmenuSbar guibg=#504945
hi PmenuThumb guibg=#7c6f64
hi clear PopupNotification
hi Question term=bold guifg=#fe8019
hi QuickFixLine term=bold guibg=#fab2df guifg=#0e1018
hi Search guifg=#fabd2f guibg=NONE
hi link CurSearch IncSearch
hi SpecialKey guifg=#a89984
hi SpellBad term=undercurl guisp=#fb4934
hi SpellCap term=undercurl guisp=#83a598
hi SpellLocal term=undercurl guisp=#8ec07c
hi SpellRare term=undercurl guisp=#d3869b
hi link StatusLineTerm Normal
hi link StatusLineTermNC Normal
hi TabLine guibg=#3c3836 guifg=#7c6f64
hi link TabLineFill Tabline
hi TabLineSel guifg=#a2b5c1 guibg=NONE
hi Title guifg=#b8bb26
hi Visual guibg=#665c54
hi link VisualNOS Visual
hi link WarningMsg ErrorMsg
hi link WildMenu Normal

hi Comment term=bold,italic guifg=#81878f
hi Constant guifg=#d3869b
hi Identifier guifg=#83a598
hi Statement guifg=#fb4934
hi PreProc guifg=#8ec07c
hi Type guifg=#fabd2f
hi Special guifg=#fe8019
hi Operator guifg=#928374
hi Delimiter guifg=#928374
hi Function guifg=#b8bb26
hi Underlined term=underline guifg=#83a598
hi Error term=bold guifg=#fb4934 guibg=NONE
hi Todo term=bold,italic guifg=#fbf1c7 guibg=NONE
hi Folded term=bold guifg=#81878f guibg=NONE
"}}}
