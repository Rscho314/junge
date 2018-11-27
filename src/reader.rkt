#lang racket

(require racket/syntax
         junge/src/lexer)
 
(provide read-syntax)

(define (read port)
    (junge-lexer port))

(define (read-syntax path port)
  (define src-datums (read port))
  (define module-datum `(module junge-mod junge/src/expander
                          (interpret ,@src-datums)))
  (datum->syntax #f module-datum))
