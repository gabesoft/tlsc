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
(define multiremember
  (lambda (a lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) a) (multiremember a (cdr lat)))
      (else (cons (car lat) (multiremember a (cdr lat)))))))

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

(define multiinsertRL
  (lambda (new oldL oldR lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) oldL)
       (cons new (cons oldL (multiinsertRL new oldL oldR (cdr lat)))))
      ((eq? (car lat) oldR)
       (cons oldR (cons new (multiinsertRL new oldL oldR (cdr lat)))))
      (else (cons (car lat) (multiinsertRL new oldL oldR (cdr lat)))))))

(define multiinsertRL-co
  (lambda (new oldL oldR lat acc)
    (cond
      ((null? lat) (acc '() 0 0))
      ((eq? (car lat) oldL)
       (multiinsertRL-co
         new oldL oldR (cdr lat)
         (lambda (newlat L R)
           (acc (cons new (cons oldL newlat)) (add1 L) R))))
      ((eq? (car lat) oldR)
       (multiinsertRL-co
         new oldL oldR (cdr lat)
         (lambda (newlat L R)
           (acc (cons oldR (cons new newlat)) L (add1 R)))))
      (else
        (multiinsertRL-co
          new oldL oldR (cdr lat)
          (lambda (newlat L R)
            (acc (cons (car lat) newlat) L R)))))))

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

(define add
  (lambda (x y)
    (cond
      ((zero? y) x)
      (else (add1 (add x (sub1 y)))))))

(define sub
  (lambda (x y)
    (cond
      ((zero? y) x)
      (else (sub1 (sub x (sub1 y)))))))

; sum a list of numbers (tuple)
(define addtup
  (lambda (tup)
    (cond
      ((null? tup) 0)
      (else (add (car tup) (addtup (cdr tup)))))))

(define mul
  (lambda (x y)
    (cond
      ((zero? y) 0)
      (else (add x (mul x (sub1 y)))))))

(define tup+
  (lambda (tup1 tup2)
    (cond
      ((null? tup1) tup2)
      ((null? tup2) tup1)
      (else (cons (add (car tup1) (car tup2))
                  (tup+ (cdr tup1) (cdr tup2)))))))

(define gt
  (lambda (x y)
    (cond
      ((zero? x) #f)
      ((zero? y) #t)
      (else (gt (sub1 x) (sub1 y))))))

(define lt
  (lambda (x y)
    (cond
      ((zero? y) #f)
      ((zero? x) #t)
      (else (lt (sub1 x) (sub1 y))))))

(define eq
  (lambda (x y)
    (cond
      ((lt x y) #f)
      ((gt x y) #f)
      (else #t))))

(define pow
  (lambda (x y)
    (cond
      ((zero? y) 1)
      (else (mul x (pow x (sub1 y)))))))

; integer division
(define div
  (lambda (x y)
    (cond
      ((lt x y) 0)
      (else (add1 (div (sub x y) y))))))

(define len
  (lambda (l)
    (cond
      ((null? l) 0)
      (else (add1 (len (cdr l)))))))

(define pick
  (lambda (n lat)
    (cond
      ((zero? n) (car lat))
      (else (pick (sub1 n) (cdr lat))))))

(define rempick
  (lambda (n lat)
    (cond
      ((zero? n) (cdr lat))
      (else (cons (car lat) (rempick (sub1 n) (cdr lat)))))))

(define no-nums
  (lambda (lat)
    (cond
      ((null? lat) lat)
      ((number? (car lat)) (no-nums (cdr lat)))
      (else (cons (car lat) (no-nums (cdr lat)))))))

(define all-nums
  (lambda (lat)
    (cond
      ((null? lat) lat)
      ((number? (car lat)) (cons (car lat) (all-nums (cdr lat))))
      (else (all-nums (cdr lat))))))

(define eqan?
  (lambda (a1 a2)
    (cond
      ((and (number? a1) (number? a2)) (eq a1 a2))
      ((or (number? a1) (number? a2)) #f)
      (else (eq? a1 a2)))))

; counts the number of times a occurs in lat
(define occur
  (lambda (a lat)
    (cond
      ((null? lat) 0)
      ((eq? (car lat) a) (add1 (occur a (cdr lat))))
      (else (occur a (cdr lat))))))

(define one? (lambda (n) (eq? n 1)))

(define remember*
  (lambda (a l)
    (cond
      ((null? l) l)
      ((list? (car l)) (cons (remember* a (car l)) (remember* a (cdr l))))
      ((eq? (car l) a) (remember* a (cdr l)))
      (else (cons (car l) (remember* a (cdr l)))))))

(define insertR*
  (lambda (new old l)
    (cond
      ((null? l) l)
      ((list? (car l))
       (cons (insertR* new old (car l))
             (insertR* new old (cdr l))))
      ((eq? (car l) old) (cons (car l)
                               (cons new (insertR* new old (cdr l)))))
      (else (cons (car l) (insertR* new old (cdr l)))))))

(define insertL*
  (lambda (new old l)
    (cond
      ((null? l) l)
      ((list? (car l)) (cons (insertL* new old (car l))
                             (insertL* new old (cdr l))))
      ((eq? (car l) old) (cons new (cons (car l)
                                         (insertL* new old (cdr l)))))
      (else (cons (car l) (insertL* new old (cdr l)))))))

(define occur*
  (lambda (a l)
    (cond
      ((null? l) 0)
      ((list? (car l)) (add (occur* a (car l)) (occur* a (cdr l))))
      ((eq? (car l) a) (add1 (occur* a (cdr l))))
      (else (occur* a (cdr l))))))

(define subst*
  (lambda (new old l)
    (cond
      ((null? l) l)
      ((list? (car l)) (cons (subst* new old (car l))
                             (subst* new old (cdr l))))
      ((eq? (car l) old) (cons new (subst* new old (cdr l))))
      (else (cons (car l) (subst* new old (cdr l)))))))

(define member*
  (lambda (a l)
    (cond
      ((null? l) #f)
      ((list? (car l)) (or (member* a (car l))
                           (member* a (cdr l))))
      (else (or (eq? (car l) a)
                (member* a (cdr l)))))))

(define leftmost
  (lambda (l)
    (cond
      ((atom? (car l)) (car l))
      (else (leftmost (car l))))))

(define eqlist?-old
  (lambda (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)
      ((or (null? l1) (null? l2) #f))
      ((and (list? (car l1)) (list? (car l2)))
       (and (eqlist? (car l1) (car l2))
            (eqlist? (cdr l1) (cdr l2))))
      (else (and (eq? (car l1) (car l2))
                 (eqlist? (cdr l1) (cdr l2)))))))

(define equal?
  (lambda (s1 s2)
    (cond
      ((and (atom? s1) (atom? s2)) (eq? s1 s2))
      ((or (atom? s1) (atom? s2)) #f)
      (else (eqlist? s1 s2)))))

(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)
      ((or (null? l1) (null? l2) #f))
      (else (and (equal? (car l1) (car l2))
                 (eqlist? (cdr l1) (cdr l2)))))))

; remove a member (only the first occurrence)
(define remember
  (lambda (s l)
    (cond
      ((null? l) l)
      ((equal? (car l) s) (cdr l))
      (else (cons (car l) (remember s (cdr l)))))))

; ch 6
(define numbered?
  (lambda (aexp)
    (cond
      ((atom? aexp) (number? aexp))
      (else (and (numbered? (car aexp))
                 (numbered? (car (cdr (cdr aexp)))))))))

; exp of the form (e1 op e2)
(define value1
  (lambda (aexp)
    (cond
      ((atom? aexp) aexp)
      ((eq? (car (cdr aexp)) '+)
       (add (value1 (car aexp)) (value1 (car (cdr (cdr aexp))))))
      ((eq? (car (cdr aexp)) 'x)
       (mul (value1 (car aexp)) (value1 (car (cdr (cdr aexp))))))
      ((eq? (car (cdr aexp)) '^)
       (pow (value1 (car aexp)) (value1 (car (cdr (cdr aexp))))))
      (else '(unknown operation)))))

(define fst-sub-exp (lambda (aexp) (car (cdr aexp))))
(define snd-sub-exp (lambda (aexp) (car (cdr (cdr aexp)))))
(define operator (lambda (aexp) (car aexp)))

; exp of the form  (op e1 e2)
(define value
  (lambda (aexp)
    (cond
      ((atom? aexp) aexp)
      ((eq? (operator aexp) '+)
       (add (value (fst-sub-exp aexp)) (value (snd-sub-exp aexp))))
      ((eq? (operator aexp) 'x)
       (mul (value (fst-sub-exp aexp)) (value (snd-sub-exp aexp))))
      ((eq? (operator aexp) '^)
       (pow (value (fst-sub-exp aexp)) (value (snd-sub-exp aexp))))
      (else '(unknown operation)))))

; ch 7
(define set?
  (lambda (lat)
    (cond
      ((null? lat) #t)
      ((member? (car lat) (cdr lat)) #f)
      (else (set? (cdr lat))))))

(define makeset
  (lambda (lat)
    (cond
      ((null? lat) lat)
      ((member? (car lat) (cdr lat)) (makeset (cdr lat)))
      (else (cons (car lat) (makeset (cdr lat)))))))

(define makeset2
  (lambda (lat)
    (cond
      ((null? lat) lat)
      (else (cons (car lat)
                  (makeset2 (multiremember (car lat) (cdr lat))))))))

(define subset?
  (lambda (set1 set2)
    (cond
      ((null? set1) #t)
      (else (and (member? (car set1) set2)
                 (subset? (cdr set1) set2))))))

(define eqset?
  (lambda (set1 set2)
    (and (subset? set1 set2)
         (subset? set2 set1))))

(define intersect?
  (lambda (set1 set2)
    (cond
      ((null? set1) #f)
      (else (or (member? (car set1) set2)
                (intersect? (cdr set1) set2))))))

(define intersect
  (lambda (set1 set2)
    (cond
      ((null? set1) '())
      ((member? (car set1) set2)
       (cons (car set1) (intersect (cdr set1) set2)))
      (else (intersect (cdr set1) set2)))))

(define union
  (lambda (set1 set2)
    (cond
      ((null? set1) set2)
      ((member? (car set1) set2) (union (cdr set1) set2))
      (else (cons (car set1) (union (cdr set1) set2))))))

(define difference
  (lambda (set1 set2)
    (cond
      ((null? set1) '())
      ((member? (car set1) set2) (difference (cdr set1) set2))
      (else (cons (car set1) (difference (cdr set1) set2))))))

(define intersectall
  (lambda (lset)
    (cond
      ((null? lset) '())
      ((null? (cdr lset)) (car lset))
      (else (intersect (car lset)
                       (intersectall (cdr lset)))))))

(define a-pair?
  (lambda (l)
    (cond
      ((or (atom? l) (null? l)) #f)
      ((null? (cdr l)) #f)
      (else (null? (cdr (cdr l)))))))

(define fst (lambda (pair) (car pair)))
(define snd (lambda (pair) (car (cdr pair))))
(define pair (lambda (s1 s2) (cons s1 (cons s2 '()))))

(define trd (lambda (l) (snd (cdr l))))

; #t if the first element of each pair in rel form a set
(define fun?
  (lambda (rel)
    (set? (firsts rel))))

(define revpair (lambda (p) (pair (snd p) (fst p))))

(define revrel
  (lambda (rel)
    (cond
      ((null? rel) '())
      (else (cons (revpair (car rel))
                  (revrel (cdr rel)))))))

(define seconds
  (lambda (l)
    (cond
      ((null? l) '())
      (else (cons (snd (car l)) (seconds (cdr l)))))))

(define fullfun?
  (lambda (rel)
    (and (set? (firsts rel))
         (set? (seconds rel)))))

; ch 8
(define remember-f
  (lambda (test? a l)
    (cond
      ((null? l) '())
      ((test? a (car l)) (cdr l))
      (else (cons (car l)
                  (remember-f test? a (cdr l)))))))

(define eq?-c (lambda (a) (lambda (x) (eq? x a))))

(define remember-c
  (lambda (test?)
    (lambda (a l)
      (cond
        ((null? l) '())
        ((test? a (car l)) (cdr l))
        (else (cons (car l)
                    ((remember-c test?) a (cdr l))))))))

(define insertL-f
  (lambda (test?)
    (lambda (new old l)
      (cond
        ((null? l) l)
        ((test? (car l) old) (cons new l))
        (else (cons (car l)
                    ((insertL-f test?) new old (cdr l))))))))

(define insertR-f
  (lambda (test?)
    (lambda (new old l)
      (cond
        ((null? l) l)
        ((test? (car l) old) (cons (car l)
                                   (cons new (cdr l))))
        (else (cons (car l)
                    ((insertR-f test?) new old (cdr l))))))))

(define insert-g
  (lambda (test? seq)
    (lambda (new old l)
      (cond
        ((null? l) l)
        ((test? (car l) old) (seq new old (car l)))
        (else (cons (car l)
                    ((insert-g test? seq) new old (cdr l))))))))

(define seqL
  (lambda (new old l)
    (cons new (cons old l))))

(define seqR
  (lambda (new old l)
    (cons old (cons new l))))

(define insertL-g
  (lambda (test?)
    (insert-g test? seqL)))

(define insertR-g
  (lambda (test?)
    (insert-g test? seqR)))

(define subst-g
  (lambda (test?)
    (insert-g test? (lambda (new old l) (cons new l)))))

(define atom-to-fun
  (lambda (x)
    (cond
      ((eq? x '+) add)
      ((eq? x 'x) mul)
      ((eq? x '^) pow)
      (else 'unknown operator))))

; exp of the form  (op e1 e2)
(define value-f
  (lambda (aexp)
    (cond
      ((atom? aexp) aexp)
      (else ((atom-to-fun (operator aexp))
             (value (fst-sub-exp aexp))
             (value (snd-sub-exp aexp)))))))

; remove a member (all occurrences)
(define multiremember-f
  (lambda (test?)
    (lambda (a lat)
      (cond
        ((null? lat) lat)
        ((test? (car lat) a) ((multiremember-f test?) a (cdr lat)))
        (else (cons (car lat) ((multiremember-f test?) a (cdr lat))))))))

; remove a member (all occurrences)
(define multirememberT
  (lambda (test? lat)
    (cond
      ((null? lat) lat)
      ((test? (car lat)) (multirememberT test? (cdr lat)))
      (else (cons (car lat) (multirememberT test? (cdr lat)))))))

(define multiremember-co
  (lambda (a lat acc)
    (cond
      ((null? lat) (acc '() '()))
      ((eq? (car lat) a)
       (multiremember-co a
                         (cdr lat)
                         (lambda (lat1 lat2)
                           (acc lat1 (cons (car lat) lat2)))))
      (else (multiremember-co a
                              (cdr lat)
                              (lambda (lat1 lat2)
                                (acc (cons (car lat) lat1) lat2)))))))

(define evens-only*
  (lambda (l)
    (cond
      ((null? l) '())
      ((list? (car l)) (cons (evens-only* (car l))
                             (evens-only* (cdr l))))
      ((odd? (car l)) (evens-only* (cdr l)))
      (else (cons (car l) (evens-only* (cdr l)))))))

(define even-odd*
  (lambda (l acc)
    (cond
      ((null? l) (acc '() '()))
      ((and (atom? (car l)) (odd? (car l)))
       (even-odd* (cdr l)
                  (lambda (evens odds)
                    (acc evens (cons (car l) odds)))))
      ((and (atom? (car l)) (even? (car l)))
       (even-odd* (cdr l)
                  (lambda (evens odds)
                    (acc (cons (car l) evens) odds))))
      (else
        (even-odd* (cdr l)
                   (lambda (evens odds)
                     (even-odd* (car l)
                                (lambda (e o)
                                  (acc (cons e evens)
                                       (cons o odds))))))))))

(define mul*
  (lambda (l)
    (cond
      ((null? l) 1)
      ((list? (car l)) (* (mul* (car l)) (mul* (cdr l))))
      (else (* (car l) (mul* (cdr l)))))))

(define add*
  (lambda (l)
    (cond
      ((null? l) 0)
      ((list? (car l)) (+ (add* (car l)) (add* (cdr l))))
      (else (+ (car l) (add* (cdr l)))))))

; ch 9
(define looking
  (lambda (a lat)
    (keep-looking a (pick 0 lat) lat)))

(define keep-looking 
  (lambda (a b lat)
    (cond
      ((eq? a b) #t)
      ((number? b) (keep-looking a (pick (sub1 b) lat) lat))
      (else #f))))

(define shift
  (lambda (apair)
    (pair (fst (fst apair)) 
          (pair (snd (fst apair))
                (snd apair)))))

(define pair-weight
  (lambda (x)
    (cond
      ((atom? x) 1)
      (else (+ (* (pair-weight (fst x)) 2)
               (pair-weight (snd x)))))))

(define align
  (lambda (x)
    (cond
      ((atom? x) x)
      ((a-pair? (fst x)) (align (shift x)))
      (else (pair (fst x) (align (snd x)))))))

(define shuffle
  (lambda (x)
    (cond
      ((atom? x) x)
      ((a-pair? (fst x)) (shuffle (revpair x)))
      (else (pair (fst x) (shuffle (snd x)))))))

(define C
  (lambda (n)
    (cond
      ((one? n) 1)
      ((even? n) (C (/ n 2)))
      (else (C (add1 (* 3 n)))))))

(define A
  (lambda (n m)
    (cond
      ((zero? n) (add1 m))
      ((zero? m) (A (sub1 n) 1))
      (else (A (sub1 n) (A n (sub1 m)))))))

(define eternity
  (lambda (x)
    (eternity x)))

