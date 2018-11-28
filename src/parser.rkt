#lang racket

(require junge/src/lexer
         parser-tools/yacc)

(provide parse)

(define junge-parser
  (parser
   (start start)
   (end EOF)
   (tokens value-tokens delimiter-tokens)
   (error
    (λ (tok-ok? tok-name tok-value)
      (display (list tok-ok? tok-name tok-value))))
   (grammar
    (start
     [(expression) $1]
     [() #f])
;the following is subject to change
    (expression [(value) (list $1)]
                [(function) (list $1)]
                [(expression expression) (append $1 $2)])
    (value [(NUM) (string->number $1)]
           [(STR) $1])
    (function [(ID) (string->symbol $1)]))))

#;(define (parse-runner parser lexer input)
(let ([input-port (open-input-string input)])
  (define (run)
    (port-count-lines! input-port)
    (parser (lambda () (lexer input-port))))
(run)))

(define (parse-runner parser lexer input-port)
  (define (run)
    (port-count-lines! input-port)
    (parser (lambda () (lexer input-port))))
(run))

(define (parse input)
(parse-runner junge-parser junge-lexer input))

;(parse "1 1 +")