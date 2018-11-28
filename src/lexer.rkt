#lang racket

(require parser-tools/lex
         (prefix-in : parser-tools/lex-sre))

(provide junge-lexer
         value-tokens
         delimiter-tokens)

(define-tokens value-tokens
  (ID
   NUM
   STR))

(define-empty-tokens delimiter-tokens
  (DEF
   EOF))

(define junge-lexer
  (lexer
   [(:: (:or #\d #\D) (:or #\e #\E) (:or #\f #\F))
    (token-DEF)]
   [numeric
    (token-NUM lexeme)]
   [(:: #\" (:* any-char) #\")
    (token-STR lexeme)]
   [(:or #\+ #\- #\* #\/)
    (token-ID lexeme)]
   [whitespace (junge-lexer input-port)]
   [(eof) (token-EOF)]))