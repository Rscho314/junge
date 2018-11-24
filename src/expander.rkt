#lang racket

(provide #%top
         #%app
         #%datum
         (rename-out [junge-module-begin #%module-begin])
         interpret
         +
         *)

(define-syntax-rule (junge-module-begin stx ...)
  (#%module-begin stx ...
  (display (first stack))))

(define stack empty)

(define (pop-stack!)
  (define arg (first stack))
  (set! stack (rest stack))
  arg)

(define (push-stack! arg)
  (set! stack (cons arg stack)))

(define (interpret [arg #f])
  (cond
    [(number? arg) (push-stack! arg)]
    [(or (equal? + arg) (equal? * arg))
     (define op-result (arg (pop-stack!) (pop-stack!)))
     (push-stack! op-result)]))
