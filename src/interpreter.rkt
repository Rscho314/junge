#lang racket

(provide (all-defined-out)
         +
         *)

(define (interpret . args)
  (for/fold ([stack-acc empty])
            ([arg (in-list args)])
    (cond
      [(number? arg) (cons arg stack-acc)]
      [(or (equal? * arg) (equal? + arg))
       (define op-result
         (arg (first stack-acc) (second stack-acc)))
       (cons op-result (drop stack-acc 2))])))
