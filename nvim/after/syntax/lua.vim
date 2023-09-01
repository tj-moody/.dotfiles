syntax match luaOperator '\v\zs\~\ze=' conceal cchar=! "render ~= as !=

execute 'syntax match Operator "\v('
\ . substitute(&commentstring, " *%s$", "", "")
\ . ')? ?[\{\}]{-3,}" conceal containedin=luaComment'

hi link luaOperator Operator

set conceallevel=2
