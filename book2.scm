; ch 11

(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

(define member?
  (lambda (a lat)
    (and (not (null? lat))
         (or (eq? a (car lat))
             (member? a (cdr lat))))))

(define two-in-a-row?
  (lambda (lat)
    (cond
      ((null? lat) #f)
      ((null? (cdr lat)) #f)
      (else (or (eq? (car lat) (car (cdr lat)))
                (two-in-a-row? (cdr lat)))))))

(define is-first-b?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else (or (eq? (car lat) a)
                (two-in-a-row-b? lat))))))

(define two-in-a-row-b?
  (lambda (lat)
    (cond
      ((null? lat) #f)
      (else (is-first-b? (car lat) (cdr lat))))))

(define two-in-a-row-c?
  (lambda (preceding lat)
    (cond
      ((null? lat) #f)
      (else (or (eq? (car lat) preceding)
                (two-in-a-row-c? (car lat) (cdr lat)))))))

(define two-in-a-row-d?
  (lambda (lat)
    (cond
      ((null? lat) #f)
      (else (two-in-a-row-c? (car lat) (cdr lat))))))

(define sum-of-prefixes-b
  (lambda (sum-so-far tup)
    (cond
      ((null? tup) '())
      (else (cons (+ sum-so-far (car tup))
                  (sum-of-prefixes-b (+ sum-so-far (car tup))
                                     (cdr tup)))))))

(define sum-of-prefixes (lambda (tup) (sum-of-prefixes-b 0 tup)))

(define add1 (lambda (n) (+ n 1)))
(define sub1 (lambda (n) (- n 1)))
(define zero? (lambda (n) (eq? n 0)))
(define one? (lambda (n) (eq? n 1)))

(define pick
  (lambda (n lat)
    (cond
      ((one? n) (car lat))
      (else (pick (sub1 n) (cdr lat))))))

(define scramble-b
  (lambda (tup rev-pre)
    (cond
      ((null? tup) '())
      (else (cons (pick (car tup) (cons (car tup) rev-pre))
                  (scramble-b (cdr tup)
                              (cons (car tup) rev-pre)))))))

(define scramble (lambda (tup) (scramble-b tup '())))

; ch 12

(define Y
  (lambda (le)
    ((lambda (f) (f f))
     (lambda (f) (le (lambda (x) ((f f) x)))))))

(define multiremember2
  (lambda (a lat)
    ((Y (lambda (mr)
          (lambda (lat)
            (cond
              ((null? lat) '())
              ((eq? a (car lat)) (mr (cdr lat)))
              (else (cons (car lat) (mr (cdr lat))))))))
     lat)))

(define multiremember
  (lambda (a lat)
    ((letrec
       ((mr (lambda (lat)
              (cond
                ((null? lat) '())
                ((eq? a (car lat)) (mr (cdr lat)))
                (else (cons (car lat) (mr (cdr lat))))))))
       mr)
     lat)))

; 24
