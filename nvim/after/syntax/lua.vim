syntax match luaOperator '\v\zs\~\ze=' conceal cchar=! "render ~= as !=

syntax match Operator "\v(--\s*)?((\{\{\{)|(\}\}\}))+\d?$" conceal containedin=luaComment

hi link luaOperator Operator

set conceallevel=2
