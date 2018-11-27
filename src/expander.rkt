#lang racket

(require junge/src/interpreter)

(provide #%top
         #%app
         #%datum
         (rename-out [junge-module-begin #%module-begin])
         (all-from-out junge/src/interpreter))

(define-syntax-rule (junge-module-begin expr)
  (#%module-begin
  (display (first expr))))