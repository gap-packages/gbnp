gap> START_TEST("NMO functions");
gap> ######################### BEGIN COPYRIGHT MESSAGE #########################
gap> # GBNP - computing Gröbner bases of noncommutative polynomials
gap> # Copyright 2001-2010 by Arjeh M. Cohen, Dié A.H. Gijsbers, Jan Willem
gap> # Knopper, Chris Krook. Address: Discrete Algebra and Geometry (DAM) group
gap> # at the Department of Mathematics and Computer Science of Eindhoven
gap> # University of Technology.
gap> #
gap> # For acknowledgements see the manual. The manual can be found in several
gap> # formats in the doc subdirectory of the GBNP distribution. The
gap> # acknowledgements formatted as text can be found in the file chap0.txt.
gap> #
gap> # GBNP is free software; you can redistribute it and/or modify it under
gap> # the terms of the Lesser GNU General Public License as published by the
gap> # Free Software Foundation (FSF); either version 2.1 of the License, or
gap> # (at your option) any later version. For details, see the file 'LGPL' in
gap> # the doc subdirectory of the GBNP distribution or see the FSF's own site:
gap> # https://www.gnu.org/licenses/lgpl.html
gap> ########################## END COPYRIGHT MESSAGE ##########################
gap> 
gap> # First load the gap package (before the example)
gap> 
gap> LoadPackage("gbnp", false);
true
gap> 
gap> # NMO Example 1 is taken from Dr. Edward Green's paper
gap> # Noncommutative Gröbner Bases, and Projective Resolutions,
gap> # and is referenced as Example 2.7 there;
gap> # please see <Cite Key="Green1997"/> for more information.
gap> #
gap> # remove any previous orderings
gap> UnpatchGBNP();
LtNP restored.
GtNP restored.
gap> # Create a noncommutative free algebra on 4 gens over the Rationals
gap> A := FreeAssociativeAlgebraWithOne(Rationals,"a","b","c","d");
<algebra-with-one over Rationals, with 4 generators>
gap> # Label the generators of the algebra:
gap> a := A.a; b := A.b; c := A.c; d := A.d;
(1)*a
(1)*b
(1)*c
(1)*d
gap> # Set up our polynomials, and convert them to NP format:
gap> polys := [ c*d*a*b-c*b, b*c-d*a ];
[ (-1)*c*b+(1)*c*d*a*b, (1)*b*c+(-1)*d*a ]
gap> reps := GP2NPList( polys );
[ [ [ [ 3, 4, 1, 2 ], [ 3, 2 ] ], [ 1, -1 ] ],
           [ [ [ 4, 1 ], [ 2, 3 ] ], [ -1, 1 ] ] ]
gap> # Compute the Gröbner basis via GBNP using its default
gap> # (length left-lexicographic) ordering; that is,
gap> # without patching GBNP with an NMO ordering:
gap> gbreps := Grobner( reps );;
gap> gb := NP2GPList( gbreps, A );
[ (1)*d*a+(-1)*b*c, (1)*(c*b)^2+(-1)*c*b ]
gap> 
gap> # Create a length left-lexicographic ordering,
gap> # with generators ordered: a &lt; b  &lt; c &lt; d.
gap> # Note: this is the default ordering of generators by NMO,
gap> # if none is provided:
gap> ml := NCMonomialLeftLengthLexOrdering( A );
NCMonomialLeftLengthLexicographicOrdering([ (1)*a, (1)*b, (1)*c, (1)*d ])
gap> 
gap> # Patch GBNP with the ordering <C>ml</C>, and then run the same example.
gap> # We should get the same answer as above:
gap> PatchGBNP( ml );
LtNP patched.
GtNP patched.
gap> gbreps := Grobner( reps );;
gap> gb := NP2GPList( gbreps, A );
[ (1)*d*a+(-1)*b*c, (1)*(c*b)^2+(-1)*c*b ]
gap> 
gap> # Now create a Length-Lexicographic ordering on the generators
gap> # such that  d &lt; c &lt; b &lt; a
gap> ml2 := NCMonomialLeftLengthLexOrdering( A, [4,3,2,1] );
NCMonomialLeftLengthLexicographicOrdering([ (1)*d, (1)*c, (1)*b, (1)*a ])
gap> 
gap> # Compute the Gröbner basis w.r.t this new ordering on the same algebra:
gap> PatchGBNP( ml2 );
LtNP patched.
GtNP patched.
gap> gbreps2 := SGrobner( reps );;
gap> gb2 := NP2GPList( gbreps2, A );
[ (1)*b*c+(-1)*d*a, (1)*c*d*a*b+(-1)*c*b, (1)*(d*a)^2*b+(-1)*d*a*b,
  (1)*c*(d*a)^2+(-1)*c*d*a, (1)*(d*a)^3+(-1)*(d*a)^2 ]
gap> 
gap> 
gap> # NMO Example 2 is the same as Example 1 above, except that the length
gap> # and left-lexicographic orderings are created independently and then
gap> # chained to form the usual length left-lexicographic ordering.
gap> # Hence, all results should be the same.
gap> 
gap> # remove any previous orderings
gap> UnpatchGBNP();
LtNP restored.
GtNP restored.
gap> # Create a noncommutative free algebra on 4 generators over the
gap> # Rationals, label, and set up the example:
gap> A := FreeAssociativeAlgebraWithOne(Rationals,"a","b","c","d");;
gap> a := A.a;; b := A.b;; c := A.c;; d := A.d;;
gap> polys := [ c*d*a*b-c*b, b*c-d*a ];;
gap> reps := GP2NPList( polys );;
gap> # Create left-lexicographic ordering with a &lt; b  &lt; c &lt; d:
gap> lexord := NCMonomialLeftLexicographicOrdering( A );
NCMonomialLeftLexicographicOrdering([ (1)*a, (1)*b, (1)*c, (1)*d ])
gap> # Create a length ordering on monomials in <M>A</M>,
gap> # with ties broken by the lexicographic order lexord:
gap> lenlex := NCMonomialLengthOrdering( A, lexord );
NCMonomialLengthOrdering([ (1)*a, (1)*b, (1)*c, (1)*d ])
gap> 
gap> # Patch GBNP and proceed with our example:
gap> PatchGBNP( lenlex );;
LtNP patched.
GtNP patched.
gap> gbreps := Grobner( reps );;
gap> gb := NP2GPList( gbreps, A );
[ (1)*d*a+(-1)*b*c, (1)*(c*b)^2+(-1)*c*b ]
gap> 
gap> # Now, proceed similarly, with the lexicographic order
gap> # such that d &lt; c  &lt; b &lt; a:
gap> lexord2 := NCMonomialLeftLexicographicOrdering( A, [4,3,2,1] );
NCMonomialLeftLexicographicOrdering([ (1)*d, (1)*c, (1)*b, (1)*a ])
gap> lenlex2 := NCMonomialLengthOrdering( A, lexord2 );
NCMonomialLengthOrdering([ (1)*a, (1)*b, (1)*c, (1)*d ])
gap> PatchGBNP( lenlex2 );;
LtNP patched.
GtNP patched.
gap> gbreps2 := Grobner( reps );;
gap> gb2 := NP2GPList( gbreps2, A );
[ (1)*b*c+(-1)*d*a, (1)*c*d*a*b+(-1)*c*b, (1)*(d*a)^2*b+(-1)*d*a*b,
  (1)*c*(d*a)^2+(-1)*c*d*a, (1)*(d*a)^3+(-1)*(d*a)^2 ]
gap> # An important point can be made here.  Notice that when the lenlex2
gap> # length ordering is created, a lexicographic (generator) ordering
gap> # table is assigned internally to the ordering since one was not
gap> # provided to it.
gap> # This is justa convenience for lexicographically-dependent orderings,
gap> # and in the case of the length order, it is not used.
gap> # Only the lex table for <C>lexord2</C> is ever used.
gap> # Some clarification may be provided in examining:
gap> HasNextOrdering( lenlex2 );
true
gap> NextOrdering( lenlex2 );
NCMonomialLeftLexicographicOrdering([ (1)*d, (1)*c, (1)*b, (1)*a ])
gap> LexicographicTable( NextOrdering( lenlex2 ) );
[ (1)*d, (1)*c, (1)*b, (1)*a ]
gap> 
gap> 
gap> # NMO Example 3 is taken from the book
gap> # 'Ideals, Varieties, and Algorithms', (<Cite Key="CLO97"/>,
gap> # Example 2, p. 93-94); it is a commutative example.
gap> # First, set up the problem and find a Gröbner basis w.r.t. the length
gap> # left-lexicographic ordering implicitly assumed in GBNP:
gap> # remove any previous orderings
gap> UnpatchGBNP();
LtNP restored.
GtNP restored.
gap> A3 := FreeAssociativeAlgebraWithOne( Rationals, "x", "y", "z" );;
gap> x := A3.x;; y := A3.y;; z := A3.z;; id := One(A3);;
gap> polys3 := [ x^2 + y^2 + z^2 - id, x^2 + z^2 - y, x-z,
>                x*y-y*x, x*z-z*x, y*z-z*y];;
gap> reps3 := GP2NPList( polys3 );;
gap> gb3 := Grobner( reps3 );;
gap> NP2GPList( gb3, A3 );
[ (1)*z+(-1)*x, (1)*x^2+(-1/2)*y, (1)*y*x+(-1)*x*y,
  (1)*y^2+(1)*y+(-1)*<identity ...> ]
gap> 
gap> # The example, as presented in the book, uses a left-lexicographic
gap> # ordering with z &lt; y  &lt; x.  We create the ordering in NMO,
gap> # patch GBNP,and get the result expected:
gap> ml3 := NCMonomialLeftLexicographicOrdering( A3, [3,2,1] );
NCMonomialLeftLexicographicOrdering([ (1)*z, (1)*y, (1)*x ])
gap> PatchGBNP( ml3 );
LtNP patched.
GtNP patched.
gap> gb3 := Grobner( reps3 );;
gap> NP2GPList( gb3, A3 );
[ (1)*z^4+(1/2)*z^2+(-1/4)*<identity ...>, (1)*y+(-2)*z^2, (1)*x+(-1\
)*z ]
gap> 
gap> 
gap> # NMO Example 4 was taken from page 339 of the book
gap> # 'Some Tapas of Computer Algebra' by A.M. Cohen, H. Cuypers, H. Sterk,
gap> # <Cite Key="CohenCuypersSterk1999"/>;
gap> # it also appears as Example 6 in the GBNP example set.
gap> # A noncommutative free algebra on 6 generators over the Rationals
gap> # is created in GAP, and the generators are labeled:
gap> # remove any previous orderings
gap> UnpatchGBNP();
LtNP restored.
GtNP restored.
gap> A4 := FreeAssociativeAlgebraWithOne(Rationals,"a","b","c","d","e","f");;
gap> a := A4.a;; b := A4.b;; c := A4.c;; d := A4.d;; e := A4.e;; f := A4.f;;
gap> # Set up list of noncommutative polynomials:
gap> polys4 := [ e*a, a^3 + f*a, a^9 + c*a^3, a^81 + c*a^9 + d*a^3,
>                a^27 + d*a^81 + e*a^9 + f*a^3, b + c*a^27 + e*a^81 + f*a^9,
>                c*b + d*a^27 + f*a^81, a + d*b + e*a^27, c*a + e*b + f*a^27,
>                d*a + f*b, b^3 - b, a*b - b*a, a*c - c*a, a*d - d*a,
>                a*e - e*a, a*f - f*a, b*c - c*b, b*d - d*b, b*e - e*b,
>                b*f - f*b, c*d - d*c, c*e - e*c, c*f - f*c, d*e - e*d,
>                d*f - f*d, e*f - f*e ];;
gap> reps4 := GP2NPList( polys4 );;
gap> # Create a length left-lex ordering with the following (default)
gap> # ordering on the generators: a &lt; b  &lt; c &lt; d &lt; e &lt; f:
gap> ml4 := NCMonomialLeftLengthLexOrdering( A4 );
NCMonomialLeftLengthLexicographicOrdering([ (1)*a, (1)*b, (1)*c, (1)*d,
   (1)*e, (1)*f ])
gap> # Patch GBNP and compute the Gröbner basis w.r.t the ordering ml4:
gap> PatchGBNP( ml4 );
LtNP patched.
GtNP patched.
gap> gb4 := Grobner( reps4 );;
gap> NP2GPList( gb4, A4 );
[ (1)*a, (1)*b, (1)*d*c+(-1)*c*d, (1)*e*c+(-1)*c*e,
  (1)*e*d+(-1)*d*e, (1)*f*c+(-1)*c*f,
  (1)*f*d+(-1)*d*f, (1)*f*e+(-1)*e*f ]
gap> 
gap> STOP_TEST("NMO functions",10000);
