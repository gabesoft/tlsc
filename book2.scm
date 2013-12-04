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

; 18
