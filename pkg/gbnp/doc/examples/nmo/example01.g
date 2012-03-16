# This example was taken from Dr. Edward Green's paper ``Noncommutative
# Grobner Bases, and Projective Resolutions'', and is referenced
# as ``Example 2.7'' there; please see the manual for more information.

LoadPackage("gbnp");
A := FreeAssociativeAlgebraWithOne(Rationals,"a","b","c","d");
a := A.a; b := A.b; c := A.c; d := A.d;
polys := [c*d*a*b-c*b,b*c-d*a];
reps := GP2NPList(polys);
gbreps := Grobner(reps);
gb := NP2GPList(gbreps,A);

ml := NCMonomialLeftLengthLexOrdering(A);
PatchGBNP(ml);
gbreps := Grobner(reps);;
gb := NP2GPList(gbreps,A);

ml2 := NCMonomialLeftLengthLexOrdering(A,[4,3,2,1]);
PatchGBNP(ml2);
gbreps2 := SGrobner(reps);;
gb2 := NP2GPList(gbreps2,A);
