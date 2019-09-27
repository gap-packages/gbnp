# Many examples provided with {\GBNP} have been tested with the native
# length left-lex ordering patched with the same ordering but a {\NMO}
# version.  All such examples tested thus far work as intended, as
# the following example shows.  It was taken from the book page 339 of
# ``Some Tapas of Computer Algebra'' by A.M. Cohen, H. Cuypers, H. Sterk,
# \cite{CCS99}; it also appears as example 6 in the {\GBNP} example set.


LoadPackage("gbnp", false);

A := FreeAssociativeAlgebraWithOne(Rationals,"a","b","c","d","e","f");;
a := A.a;; b := A.b;; c := A.c;; d := A.d;; e := A.e;; f := A.f;;

polys := [ e*a, a^3 + f*a, a^9 + c*a^3, a^81 + c*a^9 + d*a^3,
           a^27 + d*a^81 + e*a^9 + f*a^3, b + c*a^27 + e*a^81 + f*a^9,
           c*b + d*a^27 + f*a^81, a + d*b + e*a^27, c*a + e*b + f*a^27,
           d*a + f*b, b^3 - b, a*b - b*a, a*c - c*a, a*d - d*a,
           a*e - e*a, a*f - f*a, b*c - c*b, b*d - d*b, b*e - e*b,
           b*f - f*b, c*d - d*c, c*e - e*c, c*f - f*c, d*e - e*d,
           d*f - f*d, e*f - f*e
];;
reps := GP2NPList(polys);;

ml := NCMonomialLeftLengthLexOrdering(A);
PatchGBNP(ml);
gb := Grobner(reps);;
NP2GPList(gb,A);
