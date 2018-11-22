#lang racket

(require syntax/strip-context)
 
(provide (rename-out [junge-read read]
                       [junge-read-syntax read-syntax]))
 
(define (junge-read in)
  (syntax->datum
   (junge-read-syntax #f in)))
 
(define (junge-read-syntax src in)
  (with-syntax ([str (port->string in)])
    (strip-context
     #'(module anything racket
         (provide data)
         (define data 'str)))))