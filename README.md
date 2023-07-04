# state-machine-schema
Una m áquina de estado es un sistema que consume una lista de simbolos en entrada

y retorna true si los acepta, false si no. A medida que consume simbolos, va cam-
biando de estado de acuerdo a ciertas transiciones entre estados. Para simplificar,

consideramos que cada estado es un estado de aceptación: o sea, una m ́aquina acepta
cualquier input que pueda consumir enteramente. Adem ́as, en vez de trabajar con
s ́ımbolos, trabajaremos con strings. Por ejemplo, el siguiente c ódigo Scheme define
una m ́aquina que reconoce la expresión regular (a
+b)
∗
(por ej. “ab”, “abaaabab”).

Tiene dos estados, waita (el estado inicial) y waitab.

```ruby
#lang racket

(define (maquina-simple input)
  (let loop ((estado 'inicio) (entrada input))
    (cond
      ; Estado inicial
      ((eq? estado 'inicio)
       (cond
         ((null? entrada) #f)  ; La entrada está vacía, se rechaza
         ((string=? (car entrada) "a")
          (loop 'waita (cdr entrada)))  ; Transición a waita
         (else #f)))  ; Cualquier otro símbolo, se rechaza
      
      ; Estado w-a
      ((eq? estado 'waita)
       (cond
         ((null? entrada) #t)  ; La entrada se ha consumido por completo, se acepta
         ((string=? (car entrada) "b")
          (loop 'waitab (cdr entrada)))  ; Transición a waitab
         (else #f)))  ; Cualquier otro símbolo, se rechaza
      
      ; Estado w-ab
      ((eq? estado 'waitab)
       (cond
         ((null? entrada) #t)  ; La entrada se ha consumido por completo, se acepta
         ((string=? (car entrada) "c")
          (loop 'wait-n (cdr entrada)))  ; Transición a wait-n
         (else #f)))  ; Cualquier otro símbolo, se rechaza
      
      ; Estado w-n
      ((eq? estado 'wait-n)
       (cond
         ((null? entrada) #t)  ; La entrada se ha consumido por completo, se acepta
         (else #f)))  ; Cualquier otro símbolo, se rechaza
    )
  )
)

; Ejemplo de uso

(displayln (maquina-simple '("a" "b" "c")))  ; true
(displayln (maquina-simple '("a" "b" "d")))  ; false
(displayln (maquina-simple '("a" "b")))  ; false
```
