;; extends

(let_declaration
  ((raw_string_literal) @injection.content
                        (#offset! @injection.content 1 0 -1 0)
                        (#match? @injection.content "#version"))
  (#set! injection.language "glsl"))
