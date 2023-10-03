syntax match Operator "\v(//\s*)?((\{\{\{)|(\}\}\}))+\d?$" conceal containedin=rustCommentLine
" syntax match Operator "\v#\[.*\]$" conceal cchar=

set conceallevel=2
