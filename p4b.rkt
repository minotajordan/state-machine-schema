#lang racket

(define (show people-list)
  ; Función auxiliar para insertar una persona en orden en la cola
  (define (insert-person person queue)
    ; Si la cola está vacía, devuelve una lista con la persona
    (if (null? queue)
        (list person)
        ; Compara la edad de la persona con la edad de la primera persona en la cola
        ; Si es mayor, se coloca al principio de la cola
        ; Si es menor o igual, se mantiene la primera persona y se realiza una llamada recursiva para insertar la persona en el resto de la cola
        (if (> (second person) (second (car queue)))
            (cons person queue)
            (cons (car queue) (insert-person person (cdr queue))))))

  ; Función auxiliar recursiva para procesar cada persona y construir la cola ordenada por edad
  (define (sort-people people queue)
    ; Si no hay más personas, invierte la cola y la devuelve
    (if (null? people)
        (reverse queue)
        ; Llama recursivamente a sort-people con la cola actualizada y la persona restante
        ; Utiliza insert-person para insertar la persona en orden en la cola
        (sort-people (cdr people) (insert-person (car people) queue))))

  ; Utiliza sort-people para procesar la lista de personas y devuelve una lista con los nombres ordenados por edad
  (map car (sort-people people-list '())))

;; Ejemplo de uso
(display (show '((pedro 25) (ximena 16) (juan 17) (diego 32))))
