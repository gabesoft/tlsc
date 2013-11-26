(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

; list of atoms? 
(define lat?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((atom? (car l)) (lat? (cdr l)))
      (else #f))))

(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else (or (eq? (car lat) a)
                (member? a (cdr lat)))))))

; remove a member (only the first occurrence)
(define rmember
  (lambda (a lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) a) (cdr lat))
      (else (cons (car lat) (rmember a (cdr lat)))))))

; extract the car of every list in l
(define firsts
  (lambda (l)
    (cond
      ((null? l) l)
      (else (cons (car (car l))
                  (firsts (cdr l)))))))

; insert new to the right of old in l
(define insertR
  (lambda (new old l)
    (cond
      ((null? l) l)
      ((eq? (car l) old) (cons (car l)
                               (cons new (cdr l))))
      (else (cons (car l)
                  (insertR new old (cdr l)))))))
