# This example was taken from Dr. Edward Green's paper ``Noncommutative
# Grobner Bases, and Projective Resolutions'', and is referenced
# as ``Example 2.7'' there; please see the manual for more information.

# This example is the same as Example 1 above, except that the length
# and lexicographic orderings are created independently and then
# chained to form the usual length left-lexicographic ordering. 

LoadPackage("gbnp", false);

A := FreeAssociativeAlgebraWithOne(Rationals,"a","b","c","d");;
a := A.a;; b := A.b;; c := A.c;; d := A.d;;
polys := [c*d*a*b-c*b,b*c-d*a];;
reps := GP2NPList(polys);;

lexord := NCMonomialLeftLexicographicOrdering(A);
lenlex := NCMonomialLengthOrdering(A,lexord);

PatchGBNP(lenlex);;
gbreps := Grobner(reps);;
gb := NP2GPList(gbreps,A);

lexord2 := NCMonomialLeftLexicographicOrdering(A,[4,3,2,1]);
lenlex2 := NCMonomialLengthOrdering(A,lexord2);
PatchGBNP(lenlex2);;
gbreps2 := Grobner(reps);;
gb2 := NP2GPList(gbreps2,A);

HasNextOrdering(lenlex2);
NextOrdering(lenlex2);
LexicographicTable(NextOrdering(lenlex2));

