# Example 3 is taken from the book "Ideals, Varieties, and Algorithms",
# (example 2, p. 93-94), and it is a commutative example.

# First, we set up the problem and find a Grobner basis w.r.t. the length
# left-lexicographic ordering implicitly assumed in {\GBNP}:

LoadPackage("gbnp");
A := FreeAssociativeAlgebraWithOne(Rationals,"x","y","z");;
x := A.x;; y := A.y;; z := A.z;; id := One(A);;
polys := [ x^2 + y^2 + z^2 - id, x^2 + z^2 - y, x-z,
           x*y-y*x, x*z-z*x, y*z-z*y];;
reps := GP2NPList(polys);;
gb := Grobner(reps);;
NP2GPList(gb,A);

ml := NCMonomialLeftLexicographicOrdering(A,[3,2,1]);
PatchGBNP(ml);
gb := Grobner(reps);;
NP2GPList(gb,A);

