; ch 11

(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

(define member?-old
  (lambda (a lat)
    (and (not (null? lat))
         (or (eq? a (car lat))
             (member? a (cdr lat))))))

(define two-in-a-row-a?
  (lambda (lat)
    (cond
      ((null? lat) #f)
      ((null? (cdr lat)) #f)
      (else (or (eq? (car lat) (car (cdr lat)))
                (two-in-a-row-a? (cdr lat)))))))

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

(define sum-of-prefixes-old (lambda (tup) (sum-of-prefixes-b 0 tup)))

(define sum-of-prefixes
  (lambda (tup)
    (letrec
      ((sop (lambda (sum-so-far tup)
              (cond
                ((null? tup) '())
                (else (cons (+ sum-so-far (car tup))
                            (sop (+ sum-so-far (car tup))
                                 (cdr tup))))))))
      (sop 0 tup))))

(define add1 (lambda (n) (+ n 1)))
(define sub1 (lambda (n) (- n 1)))
(define zero? (lambda (n) (eq? n 0)))
(define one? (lambda (n) (eq? n 1)))

(define scramble-b
  (lambda (tup rev-pre)
    (cond
      ((null? tup) '())
      (else (cons (pick (car tup) (cons (car tup) rev-pre))
                  (scramble-b (cdr tup)
                              (cons (car tup) rev-pre)))))))

(define scramble-c (lambda (tup) (scramble-b tup '())))

(define pick
  (lambda (n lat)
    (cond
      ((null? lat) 'invalid-param-lat)
      ((one? n) (car lat))
      (else (pick (sub1 n) (cdr lat))))))

(define scramble
  (lambda (tup)
    (letrec
      ((s (lambda (tp rp)
            (cond
              ((null? tp) '())
              (else
                (let ([rest (cons (car tp) rp)])
                  (cons (pick (car tp) rest)
                        (s (cdr tp) rest))))))))
      (s tup '()))))

; ch 12

(define Y
  (lambda (le)
    ((lambda (f) (f f))
     (lambda (f) (le (lambda (x) ((f f) x)))))))

(define multirember2
  (lambda (a lat)
    ((Y (lambda (mr)
          (lambda (lat)
            (cond
              ((null? lat) '())
              ((eq? a (car lat)) (mr (cdr lat)))
              (else (cons (car lat) (mr (cdr lat))))))))
     lat)))

(define multirember-old
  (lambda (a lat)
    (letrec
      ((mr (lambda (lat)
             (cond
               ((null? lat) '())
               ((eq? a (car lat)) (mr (cdr lat)))
               (else (cons (car lat) (mr (cdr lat))))))))
      (mr lat))))

(define rember-f
  (lambda (test?)
    (lambda (a l)
      (cond
        ((null? l) '())
        ((test? (car l) a) (cdr l))
        (else (cons (car l)
                    ((rember-f test?) a (cdr l))))))))

(define multirember-f
  (lambda (test?)
    (lambda (a lat)
      (letrec
        ((mr (lambda (lat)
               (cond
                 ((null? lat) '())
                 ((test? a (car lat)) (mr (cdr lat)))
                 (else (cons (car lat) (mr (cdr lat))))))))
        (mr lat)))))

(define multirember (multirember-f eq?))

(define member?
  (lambda (a lat)
    (letrec
      ((mem? (lambda (l)
               (cond
                 ((null? l) #f)
                 ((eq? (car l) a) #t)
                 (else (mem? (cdr l)))))))
      (mem? lat))))

(define union-old
  (lambda (s1 s2)
    (cond
      ((null? s1) s2)
      ((member? (car s1) s2) (union-old (cdr s1) s2))
      (else (cons (car s1) (union-old (cdr s1) s2))))))

(define union
  (lambda (s1 s2)
    (letrec
      ((u (lambda (s1)
            (cond
              ((null? s1) s2)
              ((mem? (car s1) s2) (u (cdr s1)))
              (else (cons (car s1) (u (cdr s1)))))))
       (mem? (lambda (a lat)
               (letrec
                 ((m? (lambda (lat)
                        (cond
                          ((null? lat) #f)
                          ((eq? (car lat) a) #t)
                          (else (m? (cdr lat)))))))
                 (m? lat)))))
      (u s1))))

(define two-in-a-row?
  (lambda (lat)
    (letrec
      ((two? (lambda (a lat)
               (cond
                 ((null? lat) #f)
                 ((eq? (car lat) a) #t)
                 (else (two? (car lat) (cdr lat)))))))
      (cond
        ((null? lat) #f)
        (else (two? (car lat) (cdr lat)))))))

; ch 13

(define intersect
  (lambda (s1 s2)
    (letrec
      ((int (lambda (s1)
              (cond
                ((null? s1) '())
                ((member? (car s1) s2) (cons (car s1) (int (cdr s1))))
                (else (int (cdr s1)))))))
      (int s1))))

(define intersectall-old
  (lambda (lset)
    (letrec
      ((helper (lambda (set)
                 (cond
                   ((null? (cdr set)) (car set))
                   (else (intersect (car set) (helper (cdr set))))))))
      (cond
        ((null? lset) '())
        (else (helper lset))))))

(define-syntax letcc
  (syntax-rules ()
                ((_ var body ...)
                 (call-with-current-continuation
                   (lambda (var) body ...)))))

(define-syntax try
  (syntax-rules ()
                ((_ var a . b)
                 (letcc success
                        (letcc var (success a)) . b))))

(define intersectall-scheme
  (lambda (lset)
    (call-with-current-continuation
      (lambda (hop)
        (letrec
          ((helper (lambda (lset)
                     (cond
                       ((null? (car lset)) (hop '()))
                       ((null? (cdr lset)) (car lset))
                       (else (intersect (car lset) (helper (cdr lset))))))))
          (cond
            ((null? lset) '())
            (else (helper lset))))))))

(define intersectall
  (lambda (lset)
    (letcc hop
           (letrec
             ((helper (lambda (lset)
                        (cond
                          ((null? (car lset)) (hop '()))
                          ((null? (cdr lset)) (car lset))
                          (else (isect (car lset) (helper (cdr lset)))))))
              (isect (lambda (s1 s2)
                       (letrec
                         ((helper (lambda (s1)
                                    (cond
                                      ((null? s1) '())
                                      ((member? (car s1) s2)
                                       (cons (car s1) (helper (cdr s1))))
                                      (else (helper (cdr s1)))))))
                         (cond
                           ((null? s2) (hop '()))
                           (else (helper s1)))))))
             (cond
               ((null? lset) '())
               (else (helper lset)))))))

(define rember
  (lambda (a lat)
    (letrec
      ((helper (lambda (lat)
                 (cond
                   ((null? lat) '())
                   ((eq? (car lat) a) (cdr lat))
                   (else (cons (car lat) (helper (cdr lat))))))))
      (helper lat))))

(define rember-beyond-first
  (lambda (a lat)
    (letrec
      ((helper (lambda (lat)
                 (cond
                   ((null? lat) '())
                   ((eq? (car lat) a) '())
                   (else (cons (car lat) (helper (cdr lat))))))))
      (helper lat))))

(define rember-upto-last
  (lambda (a lat)
    (letcc skip
           (letrec
             ((helper (lambda (lat)
                        (cond
                          ((null? lat) '())
                          ((eq? (car lat) a) (skip (helper (cdr lat))))
                          (else (cons (car lat) (helper (cdr lat))))))))
             (helper lat)))))

; ch 14

(define leftmost
  (lambda (l)
    (cond
      ((null? l) '())
      ((atom? (car l)) (car l))
      (else
        (let ((next (leftmost (car l))))
          (cond
            ((atom? next) next)
            (else (leftmost (cdr l)))))))))

(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)
      ((or (null? l1) (null? l2)) #f)
      (else (and (equal? (car l1) (car l2))
                 (eqlist? (cdr l1) (cdr l2)))))))

(define depth*
  (lambda (l)
    (cond
      ((null? l) 1)
      (else
        (let ((rest (depth* (cdr l))))
          (if
            (atom? (car l)) rest
            (max (add1 (depth* (car l))) rest)))))))

(define leftmost-b
  (lambda (l)
    (letcc skip
           (letrec
             ((lm (lambda (l)
                    (cond
                      ((null? l) '())
                      ((atom? (car l)) (skip (car l)))
                      (else (let ()
                              (lm (car l))
                              (lm (cdr l))))))))
             (lm l)))))

(define rember1*-old
  (lambda (a l)
    (letrec
      ((rem (lambda (l)
              (cond
                ((null? l) '())
                ((atom? (car l))
                 (cond
                   ((eq? (car l) a) (cdr l))
                   (else (cons (car l) (rem (cdr l))))))
                (else
                  (let ([rest (rem (car l))])
                    (cond
                      ((eqlist? rest (car l))
                       (cons (car l) (rem (cdr l))))
                      (else (cons rest (cdr l))))))))))
      (rem l))))

(define rember1*
  (lambda (a l)
    (letrec
      ((rm (lambda (a l oh)
             (cond
               ((null? l) (oh))
               ((atom? (car l)) (if (eq? (car l) a)
                                  (cdr l)
                                  (cons (car l) (rm a (cdr l) oh))))
               (else
                 (try oh2
                      (cons (rm a (car l) oh2) (cdr l))
                      (cons (car l) (rm a (cdr l) oh))))))))
      (try oh (rm a l oh) l))))

; ch 15

(define remember-last
  (let ((x '()))
    (lambda (y)
      (let ((r (cons y (cons x '())))) (set! x y) r))))

(define deep
  (lambda (m)
    (if (zero? m) '() (cons (deep (sub1 m)) '()))))


(define deepR
  (let ((ms '()))
    (lambda (m)
      (set! ms (cons m ms))
      (cons ms (deep m)))))

(define find
  (lambda (key keys vals)
    (write (cons 'cache-hit (cons key '())))
    (letrec
      ((get (lambda (keys vals)
              (cond
                ((null? keys) #f)
                ((eq? (car keys) key) (car vals))
                (else (get (cdr keys) (cdr vals)))))))
      (get keys vals))))

(define deepM
  (let ((keys '())
        (vals '()))
    (lambda (m)
      (if (member? m keys)
        (find m keys vals)
        (let ((r (deep m)))
          (set! keys (cons m keys))
          (set! vals (cons r vals))
          r)))))

;118
