(plus 8 9)

(addtup '(1 2 3 4 5 6))

(mul 179 53)

(tup+ '(1 2 3 4) '(9 8 7 6))
(tup+ '(1 2) '(9 8 7 6))
(tup+ '(1 2 3 4) '(9 8))

(gt 112 78)
(gt 12 78)
(gt 3 3)

(lt 112 78)
(lt 12 78)
(lt 3 3)

(eq 112 78)
(eq 12 78)
(eq 3 3)

(pow 1 1)
(pow 2 3)
(pow 5 3)

(div 7 2)
(div 125 5)
(div 13 4)

(length '(a b c d))
(len '(a b c d))

(pick 4 '(a b c d e f))
(rempick 4 '(a b c d e f))

(no-nums '(a 1 b 2 c 3 d))
(all-nums '(a 1 b 2 c 3 d))

(eqan? 'a 1)
(eqan? 'a 'a)
(eqan? 1 1)

(occur 'a '(a b c d a b c d a))
(one? 1)
(one? 'b)
(one? 2)

(rmember* 'a '(((a b) a b) (a b) a b c (d (e (f g a h)) a) a b))
(insertR* 'x 'a '(((a b) a b) (a b) a b c (d (e (f g a h)) a) a b))
(insertL* 'x 'a '(((a b) a b) (a b) a b c (d (e (f g a h)) a) a b))
(occur* 'a '(((a b) a b) (a b) a b c (d (e (f g a h)) a) a b))
(subst* 'x 'a '(((a b) a b) (a b) a b c (d (e (f g a h)) a) a b))


(member* 'a '(((b c d) e) f (g (h (k (l m) a) x) y) (z)))
(member* 'a '(((b c d) e) f (g (h (k (l m) w) x) y) (z)))

(leftmost '(((a b) a b) (a b) a b c (d (e (f g a h)) a) a b))
(leftmost '(((b c d) e) f (g (h (k (l m) w) x) y) (z)))

(eqlist? '(((b c d) e) f (g (h (k (l m) w) x) y) (z))
         '(((b c d) e) f (g (h (k (l m) w) x) y) (z)))
(eqlist? '(((b c d) e) f (g (h (k (l m) w) x) y) (z))
         '(((b c d) e) f (g (h (k (l n) w) x) y) (z)))

(equal? '(((b c d) e) f (g (h (k (l m) w) x) y) (z))
         '(((b c d) e) f (g (h (k (l m) w) x) y) (z)))
(equal? '(((b c d) e) f (g (h (k (l m) w) x) y) (z))
         '(((b c d) e) f (g (h (k (l n) w) x) y) (z)))
(equal? 'a 'b)
(equal? 'a 'c)
(equal? 'a 'a)

(rmember '((a b) a b) '(((a b) a b) (a b) a b c (d (e (f g a h)) a) a b))

(numbered? '(3 + (4 + 5)))
(numbered? '(3 + (4 x (6 ^ 7))))
(numbered? '(3 + (4 x (c ^ 7))))

(value1 4)
(value1 '(3 + 4))
(value1 '(3 x 4))
(value1 '(5 + (6 x 2)))
(value1 '((3 x 4) + (5 + (6 x 2))))
(value1 '((2 + (3 x 5)) ^ (2 + 1)))

(fst-sub-exp '(+ 1 2))
(snd-sub-exp '(+ 1 2))
(operator '(+ 1 2))

(value 4)
(value '(+ 3 4))
(value '(x 3 4))
(value '(+ 5 (x 6 2)))
(value '(+ (x 3 4) (+ 5 (x 6 2))))
(value '(^ (+ 2 (x 3 5)) (+ 2 1)))

(set? '(a b c d a b c))
(set? '(a b c d x y z))
(set? '(a))
(set? '(apple 3 pear 4 9 apple 3 4))

(makeset '(apple peach pear peach plum apple lemon peach))
(makeset '(a b c d a b c x y a b c))

(makeset2 '(apple peach pear peach plum apple lemon peach))
(makeset2 '(a b c d a b c x y a b c))
(makeset2 '(apple 3 pear 4 9 apple 3 4))

(subset? '(a b e f) '(a b c d e f g h i j))
(subset? '(a b e f) '(a b c d e y g h i j))
(subset? '(a b c d) '(a b e))

(eqset? '(a b c d) '(a b c d))
(eqset? '(a b c d) '(a b x d))

(intersect? '(a b) '(x y z b d))
(intersect? '(a b) '(x y z w d))

(intersect '(a b) '(x y z b d))
(intersect '(a b) '(x y z w d))
(intersect '(a b c) '(x y a z b e f g))

(union '(a b) '(x y z b d))
(union '(a b) '(x y z w d))
(union '(a b c) '(x y a z b e f g))

(difference '(a b) '(x y z b d))
(difference '(a b) '(x y z w d))
(difference '(a b c) '(x y a z b e f g))

(intersectall '((a b c d) (x y a b) (z w b c) (z f g a b)))
(intersectall '((a b c d) (x y a b) (a z w b c) (z f g a b)))

(a-pair? '(a b))
(a-pair? '(a b c))
(a-pair? '(a))
(a-pair? '((a) (b)))

(pair 'a 'b)
(fst (pair 'a 'b))
(snd (pair 'a 'b))
(trd '(a b c d))

(fun? '((8 3) (4 2) (7 6) (6 2) (3 4)))
(fun? '((d 4) (b 0) (b 9) (e 5) (g 4)))

(revrel '((8 3) (4 2) (7 6) (6 2) (3 4)))

(fullfun? '((8 3) (4 2) (7 6) (6 2) (3 4)))
(fullfun? '((8 3) (4 2) (7 6) (6 5) (3 4)))

