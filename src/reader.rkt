#lang racket

(require racket/syntax
         junge/src/parser)
 
(provide read-syntax)

(define (read-syntax path port)
  (define src-datums (parse port))
  (define module-datum `(module junge-mod junge/src/expander
                          (interpret ,@src-datums)))
  (datum->syntax #f module-datum))