syntax match xxdZero '\v\s\zs00\ze\s'
syntax match xxdNonPrintable '\v\s\zs(0|1)[1-9a-fA-F]\ze\s'
syntax match xxdDot '\v\s\zs\.\ze\s'

hi link xxdZero Operator
hi link xxdNonPrintable Identifier
hi link xxdDot Operator
