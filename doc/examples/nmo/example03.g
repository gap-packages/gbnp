# Example 3 is taken from the book "Ideals, Varieties, and Algorithms",
# (example 2, p. 93-94), and it is a commutative example.

# First, we set up the problem and find a Grobner basis w.r.t. the length
# left-lexicographic ordering implicitly assumed in {\GBNP}:

LoadPackage("gbnp", false);
A3 := FreeAssociativeAlgebraWithOne(Rationals,"x","y","z");;
x := A3.x;; y := A3.y;; z := A3.z;; id := One(A3);;
polys3 := [ x^2 + y^2 + z^2 - id, x^2 + z^2 - y, x-z,
            x*y-y*x, x*z-z*x, y*z-z*y];;
reps3 := GP2NPList(polys3);;
gb3 := Grobner(reps3);;
NP2GPList(gb3,A3);

ml3 := NCMonomialLeftLexicographicOrdering(A3,[3,2,1]);
PatchGBNP(ml3);
gb3 := Grobner(reps3);;
NP2GPList(gb3,A3);

