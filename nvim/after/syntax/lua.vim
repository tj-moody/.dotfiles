syntax match Operator "\v(--\s*)?((\{\{\{)|(\}\}\}))+\d?$" conceal containedin=luaComment

hi link luaOperator Operator

set conceallevel=2
