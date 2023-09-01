execute 'syntax match Operator "\v('
\ . substitute(&commentstring, " *%s$", "", "")
\ . ')? ?[\{\}]{-3,}" conceal containedin=confComment'
