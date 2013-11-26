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

; insert new to the right of the first occurrence of old in l
(define insertR
  (lambda (new old l)
    (cond
      ((null? l) l)
      ((eq? (car l) old) (cons (car l)
                               (cons new (cdr l))))
      (else (cons (car l)
                  (insertR new old (cdr l)))))))

; insert new to the left of the first occurrence of old in l
(define insertL
  (lambda (new old l)
    (cond
      ((null? l) l)
      ((eq? (car l) old) (cons new l))
      (else (cons (car l)
                  (insertL new old (cdr l)))))))

; replace the first occurrence old with new in l
(define subst
  (lambda (new old l)
    (cond
      ((null? l) l)
      ((eq? (car l) old) (cons new (cdr l)))
      (else (cons (car l)
                  (subst new old (cdr l)))))))

; replace the first occurrence of o1 or o2 with new in l
(define subst2
  (lambda (new o1 o2 l)
    (cond
      ((null? l) l)
      ((or (eq? (car l) o1)
           (eq? (car l) o2)) (cons new (cdr l)))
      (else (cons (car l)
                  (subst2 new o1 o2 (cdr l)))))))

; remove a member (all occurrences)
(define multirmember
  (lambda (a lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) a) (mrmember a (cdr lat)))
      (else (cons (car lat) (mrmember a (cdr lat)))))))

; insert new to the right of old in l
(define multiinsertR
  (lambda (new old l)
    (cond
      ((null? l) l)
      ((eq? (car l) old) (cons (car l)
                               (cons new (multiinsertR new old (cdr l)))))
      (else (cons (car l)
                  (multiinsertR new old (cdr l)))))))

; insert new to the left of old in l
(define multiinsertL
  (lambda (new old l)
    (cond
      ((null? l) l)
      ((eq? (car l) old) (cons new
                               (cons old (multiinsertL new old (cdr l)))))
      (else (cons (car l)
                  (multiinsertL new old (cdr l)))))))

; replace ever occurrence of old with new in l
(define multisubst
  (lambda (new old l)
    (cond
      ((null? l) l)
      ((eq? (car l) old) (cons new (multisubst new old (cdr l))))
      (else (cons (car l)
                  (multisubst new old (cdr l)))))))

(define add1 (lambda (n) (+ n 1)))
(define sub1 (lambda (n) (- n 1)))
(define zero? (lambda (n) (eq? n 0)))

(define plus 
  (lambda (x y)
    (cond
      ((zero? y) x)
      (else 
        (add1 (plus x (sub1 y)))))))
