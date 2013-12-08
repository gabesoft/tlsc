(member? 'x '(a b c x y z))
(member? 'x '(a b c w y z))

(two-in-a-row? '(a b c c d e f f g))
(two-in-a-row? '(a b c d e f g))

(two-in-a-row-b? '(a b c c d e f f g))
(two-in-a-row-b? '(a b c d e f g))

(two-in-a-row-d? '(a b c c d e f f g))
(two-in-a-row-d? '(a b c d e f g))

(sum-of-prefixes '())
(sum-of-prefixes '(1 1 1 1 1))
(sum-of-prefixes '(2 1 9 17 0))

(pick 2 '(4 3 2 1 9))

(scramble '(1 1 1 3 4 2 1 1 9 2))
(scramble '(1 2 3 4 5 6 7 8 9))
(scramble '(1 2 3 1 2 3 4 1 8 2 10))

(multirember 'a '(a b c d e x y a b c a w z a b a))
((multirember-f eq?) 'a '(a b c d e x y a b c a w z a b a))

(union '(a b c d e) '(c d e f g h))
(intersect '(a b c d e) '(c d e f g h))

(intersectall '((a b c d) (c d e f) (c d e f g) (x y z c b d)))
(intersectall '((a b c d) () (c d e f g) (x y z c b d)))
(intersectall '((a)))
(intersectall '())
(intersectall '((a b) (b d)))

(rember 'a '(b c d a x y z))
(rember-beyond-first 'a '(b c d a x y z))
(rember-upto-last 'a '(b c a d a x y z))

(leftmost '(((((a b) c (d)) e) f) g h))
(leftmost '(((((() a b) c (d)) e) f) g h))

(eqlist? '(a b c) '(a b c))
(eqlist? '(a (b c)) '(a (b c)))
(eqlist? '(a (b c)) '(a b c))
(eqlist? '(a b c) '(a b c d))

(rember1* 'a '(((b c d) ((b a d) f)) e))
(rember1* 'a '(((b a d) ((b a d) f)) e))
(rember1* 'a '(((b c d) ((b x d) f)) e))

(depth* '(((((() a b) c (d)) e) f) g h))
(depth* '(((b c d) ((b x d) f)) e))
(depth* '((a (b)) (c)))
(depth* '((a (b)) ((c (d) e))))
(depth* '((p) e (e p)))
(depth* '(c (b (a b) a) a))
(depth* '(m ((b u) (m) (a (i))) u))
(depth* '(() ((b u) (m) (a (b))) u))

(leftmost-b '(((((a b) c (d)) e) f) g h))
(leftmost-b '(((((() a b) c (d)) e) f) g h))

(remember-last 'a)
(remember-last 'b)
(remember-last 'c)

(deep 4)
(deep 0)
(deep 1)

(deepR 3)
(deepR 5)

(find 4 '(1 2 3 4 5 6) '(a b c d e f))
(find 8 '(1 2 3 4 5 6) '(a b c d e f))

(deepM 3)
(deepM 5)
(deepM 4)
(deepM 3)
(deepM 6)
