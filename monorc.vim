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

set formatoptions+=j
set hidden
set history=1000
set nomodeline
autocmd FileType markdown setlocal spell
autocmd FileType text setlocal spell
autocmd FileType gitcommit setlocal spell
set wildignore+=.pyc,.swp

set splitright
autocmd WinNew * wincmd L

set list

let &listchars ..= ',eol: ,tab:▸ '
let &fillchars ..= ',eob: '

let g:netrw_banner = 0

set t_Co=256
set background=dark

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

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

set timeoutlen=1000
set ttimeoutlen=5

" Appearance
set termguicolors

hi clear signcolumn
set signcolumn=yes
set foldcolumn=2

""" Statusline
set noshowmode
set statusline=
hi NormalColor guifg=#b8bb26
hi InsertColor guifg=#83a598
hi ReplaceColor guifg=#fb4934
hi VisualColor guifg=#fe8019

set statusline+=%#NormalColor#%{(mode()==#'n')?'\ \ \ \ \ ':''}
set statusline+=%#InsertColor#%{(mode()==#'i')?'\ \ \ \ \ ':''}
set statusline+=%#ReplaceColor#%{(mode()==#'R')?'\ \ \ \ \ ':''}
set statusline+=%#VisualColor#%{(mode()==#'v')?'\ \ \ \ \ ':''}

let g:gitbranch=""
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
            let g:gitbranch=" ".substitute(l:gitrevparse, '\n', '', 'g')
        endif
    endif
endfunction

augroup GetGitBranch
    autocmd!
    autocmd WinEnter * call StatuslineGitBranch()
augroup END

set statusline+=%#Normal#%{g:gitbranch}

set statusline+=%#NormalColor#%F           "file name
set statusline+=%#Comment#\ %y
set statusline+=%#ReplaceColor#%m\ \         "modified flag

set statusline+=%#Normal#%{%'\ %n\ \ '%}

set statusline+=%#Comment#%{(&ff=='dos')?'\ \ ':''}
set statusline+=%#Comment#%{(&ff=='unix')?'\ \ ':''}
set statusline+=%#Comment#%{(&ff=='mac')?'\ \ ':''}

set statusline+=%=

set statusline +=%#NormalColor#%5l           "current line
set statusline +=%#Normal#/
set statusline +=%#ReplaceColor#%L           "total lines
set statusline +=%#NormalColor#%4v           "virtual column number

""" Theme
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
hi StatusLine guifg=#0e8018 guibg=NONE term=NONE cterm=NONE
hi StatusLineNC guifg=#0e8019 guibg=NONE term=NONE cterm=NONE
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
hi Underlined term=underline guifg=#83a598
hi Error term=bold guifg=#fb4934 guibg=NONE
hi Todo term=bold,italic guifg=#fbf1c7 guibg=NONE

""" commentary.vim - copied from vim-commentary with
""" modifications from tj-moody/vim-commentary fork

" commentary.vim - Comment stuff out
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.3
" GetLatestVimScripts: 3695 1 :AutoInstall: commentary.vim

if exists("g:loaded_commentary") || v:version < 703
  finish " doesn't actually work
endif
let g:loaded_commentary = 1

function! s:surroundings() abort
  return split(get(b:, 'commentary_format', substitute(substitute(substitute(
        \ &commentstring, '^$', '%s', ''), '\S\zs%s',' %s', '') ,'%s\ze\S', '%s ', '')), '%s', 1)
endfunction

function! s:strip_white_space(l,r,line) abort
  let [l, r] = [a:l, a:r]
  if l[-1:] ==# ' ' && stridx(a:line,l) == -1 && stridx(a:line,l[0:-2]) == 0
    let l = l[:-2]
  endif
  if r[0] ==# ' ' && (' ' . a:line)[-strlen(r)-1:] != r && a:line[-strlen(r):] == r[1:]
    let r = r[1:]
  endif
  return [l, r]
endfunction

function! s:go(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  elseif a:0 > 1
    let [lnum1, lnum2] = [a:1, a:2]
  else
    let [lnum1, lnum2] = [line("'["), line("']")]
  endif

  let [l, r] = s:surroundings()
  let uncomment = 2
  let force_uncomment = a:0 > 2 && a:3
  for lnum in range(lnum1,lnum2)
    let line = matchstr(getline(lnum),'\S.*\s\@<!')
    let [l, r] = s:strip_white_space(l,r,line)
    if len(line) && (stridx(line,l) || line[strlen(line)-strlen(r) : -1] != r)
      let uncomment = 0
    endif
  endfor

  if get(b:, 'commentary_startofline')
    let indent = '^'
  else
    let indent = '^\s*'
  endif

  let lines = []
  for lnum in range(lnum1,lnum2)
    let line = getline(lnum)
    if strlen(r) > 2 && l.r !~# '\\'
      let line = substitute(line,
            \'\M' . substitute(l, '\ze\S\s*$', '\\zs\\d\\*\\ze', '') . '\|' . substitute(r, '\S\zs', '\\zs\\d\\*\\ze', ''),
            \'\=substitute(submatch(0)+1-uncomment,"^0$\\|^-\\d*$","","")','g')
    endif
    if force_uncomment
      if line =~ '^\s*' . l
        let line = substitute(line,'\S.*\s\@<!','\=submatch(0)[strlen(l):-strlen(r)-1]','')
      endif
    elseif uncomment
      let line = substitute(line,'\S.*\s\@<!','\=submatch(0)[strlen(l):-strlen(r)-1]','')
    else
      let line = substitute(line,'^\%('.matchstr(getline(lnum1),indent).'\|\s*\)\zs.*\S\@<=','\=l.submatch(0).r','')
    endif
    call add(lines, line)
  endfor
  call setline(lnum1, lines)
  let modelines = &modelines
  try
    set modelines=0
    silent doautocmd User CommentaryPost
  finally
    let &modelines = modelines
  endtry
  return ''
endfunction

function! s:textobject(inner) abort
  let [l, r] = s:surroundings()
  let lnums = [line('.')+1, line('.')-2]
  for [index, dir, bound, line] in [[0, -1, 1, ''], [1, 1, line('$'), '']]
    while lnums[index] != bound && line ==# '' || !(stridx(line,l) || line[strlen(line)-strlen(r) : -1] != r)
      let lnums[index] += dir
      let line = matchstr(getline(lnums[index]+dir),'\S.*\s\@<!')
      let [l, r] = s:strip_white_space(l,r,line)
    endwhile
  endfor
  while (a:inner || lnums[1] != line('$')) && empty(getline(lnums[0]))
    let lnums[0] += 1
  endwhile
  while a:inner && empty(getline(lnums[1]))
    let lnums[1] -= 1
  endwhile
  if lnums[0] <= lnums[1]
    execute 'normal! 'lnums[0].'GV'.lnums[1].'G'
  endif
endfunction

command! -range -bar -bang Commentary call s:go(<line1>,<line2>,<bang>0)
xnoremap <expr>   <Plug>Commentary     <SID>go()
nnoremap <expr>   <Plug>Commentary     <SID>go()
nnoremap <expr>   <Plug>CommentaryLine <SID>go() . '_'
onoremap <silent> <Plug>Commentary        :<C-U>call <SID>textobject(get(v:, 'operator', '') ==# 'c')<CR>
nnoremap <silent> <Plug>ChangeCommentary c:<C-U>call <SID>textobject(1)<CR>
nmap <silent> <Plug>CommentaryUndo :echoerr "Change your <Plug>CommentaryUndo map to <Plug>Commentary<Plug>Commentary"<CR>

if !hasmapto('<Plug>Commentary') || maparg('gc','n') ==# ''
  xmap <leader>c  <Plug>Commentary
  nmap <leader>c  <Plug>Commentary
  omap ic  <Plug>Commentary
  nmap <leader>cc <Plug>CommentaryLine
  nmap <leader>cu <Plug>Commentary<Plug>Commentary
endif
