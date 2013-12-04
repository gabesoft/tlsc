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
