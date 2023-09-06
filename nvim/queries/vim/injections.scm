;; extends

(execute_statement
  (string_literal) @injection.content
  (#set! injection.language "vim")
  (#offset! @injection.content 0 1 0 -1)
)
