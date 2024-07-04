# Many examples provided with {\GBNP} have been tested with the native
# length left-lex ordering patched with the same ordering but a {\NMO}
# version.  All such examples tested thus far work as intended, as
# the following example shows.  It was taken from the book page 339 of
# ``Some Tapas of Computer Algebra'' by A.M. Cohen, H. Cuypers, H. Sterk,
# \cite{CCS99}; it also appears as example 6 in the {\GBNP} example set.


LoadPackage("gbnp", false);

A4 := FreeAssociativeAlgebraWithOne(Rationals,"a","b","c","d","e","f");;
a := A4.a;; b := A4.b;; c := A4.c;; d := A4.d;; e := A4.e;; f := A4.f;;

polys4 := [ e*a, a^3 + f*a, a^9 + c*a^3, a^81 + c*a^9 + d*a^3,
            a^27 + d*a^81 + e*a^9 + f*a^3, b + c*a^27 + e*a^81 + f*a^9,
            c*b + d*a^27 + f*a^81, a + d*b + e*a^27, c*a + e*b + f*a^27,
            d*a + f*b, b^3 - b, a*b - b*a, a*c - c*a, a*d - d*a,
            a*e - e*a, a*f - f*a, b*c - c*b, b*d - d*b, b*e - e*b,
            b*f - f*b, c*d - d*c, c*e - e*c, c*f - f*c, d*e - e*d,
            d*f - f*d, e*f - f*e
];;
reps4 := GP2NPList(polys4);;

ml4 := NCMonomialLeftLengthLexOrdering(A4);
PatchGBNP(ml4);
gb4 := Grobner(reps4);;
NP2GPList(gb4,A4);
