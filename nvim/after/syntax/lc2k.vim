" Vim syntax file
" Language: LC2K Assembly
" Maintainer: TJ Moody
" Description: Syntax highlighting for LC2K assembly language (very magic version)

if exists("b:current_syntax")
  finish
endif

" --- Comments ---
syntax match lc2kComment "\v;.*$"


syntax keyword lc2kSpecial Stack

" --- Directives ---
syntax keyword lc2kDirective fill
syntax match lc2kComment "\v\zs.\zefill"

" --- Registers and Numbers ---
syntax match lc2kRegister "\v<\d>"
syntax match lc2kNumber "\v-?\d+"
syntax match lc2kSymbolicLocal "\v<[a-z_][A-Za-z0-9_]*>"
syntax match lc2kSymbolicGlobal "\v<[A-Z][A-Za-z0-9_]*>"
syntax match lc2kSpecial "\v[,()]"

" --- Labels ---
syntax match lc2kLocalLabel "\v^[a-z_][A-Za-z0-9_]*:"
syntax match lc2kGlobalLabel "\v^[A-Z][A-Za-z0-9_]*:"

" --- Instructions ---
syntax keyword lc2kRInstruction add nor
syntax keyword lc2kIInstruction lw sw beq
syntax keyword lc2kJInstruction jalr
syntax keyword lc2kOInstruction halt noop

" --- Highlighting links ---
hi link lc2kLocalLabel Character
hi link lc2kGlobalLabel Number
hi link lc2kDirective Label
hi link lc2kRInstruction Identifier
hi link lc2kIInstruction Structure
hi link lc2kJInstruction Statement
hi link lc2kOInstruction Macro
hi link lc2kRegister Keyword
hi link lc2kNumber Number
hi link lc2kSymbolicLocal Character
hi link lc2kSymbolicGlobal Constant
hi link lc2kSpecial Special
hi link lc2kComment Comment

let b:current_syntax = "lc2k"
