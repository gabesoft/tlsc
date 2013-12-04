(member? 'x '(a b c x y z))
(member? 'w '(a b c x y z))

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

(multiremember 'a '(a b c d e x y a b c a w z a b a))
