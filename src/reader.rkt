#lang racket

(require racket/syntax
         parser-tools/lex
         (prefix-in : parser-tools/lex-sre))
 
(provide read-syntax)

(define junge-lexer
  (lexer
   [numeric
    (cons `(interpret,(string->number lexeme))
          (junge-lexer input-port))]
   [(:or #\+ #\- #\* #\/)
    (cons `(interpret ,(string->symbol lexeme))
          (junge-lexer input-port))]
   [whitespace (junge-lexer input-port)]
   [(eof) '()]))

(define (read port)
    (junge-lexer port))

(define (read-syntax path port)
  (define src-datums (read port))
  (define module-datum `(module junge-mod junge/src/expander
                          ,@src-datums))
  ;module-datum
  (datum->syntax #f module-datum))

