#lang racket

(require parser-tools/lex
         (prefix-in : parser-tools/lex-sre))

(provide junge-lexer)

(define junge-lexer
  (lexer
   [numeric
    (cons (string->number lexeme)
          (junge-lexer input-port))]
   [(:or #\+ #\- #\* #\/)
    (cons (string->symbol lexeme)
          (junge-lexer input-port))]
   [whitespace (junge-lexer input-port)]
   [(eof) '()]))