######################### BEGIN COPYRIGHT MESSAGE #########################
# GBNP - computing Gröbner bases of noncommutative polynomials
# Copyright 2001-2010 by Arjeh M. Cohen, Dié A.H. Gijsbers, Jan Willem
# Knopper, Chris Krook. Address: Discrete Algebra and Geometry (DAM) group
# at the Department of Mathematics and Computer Science of Eindhoven
# University of Technology.
#
# For acknowledgements see the manual. The manual can be found in several
# formats in the doc subdirectory of the GBNP distribution. The
# acknowledgements formatted as text can be found in the file chap0.txt.
#
# GBNP is free software; you can redistribute it and/or modify it under
# the terms of the Lesser GNU General Public License as published by the
# Free Software Foundation (FSF); either version 2.1 of the License, or
# (at your option) any later version. For details, see the file 'LGPL' in
# the doc subdirectory of the GBNP distribution or see the FSF's own site:
# https://www.gnu.org/licenses/lgpl.html
########################## END COPYRIGHT MESSAGE ##########################

# First load the gap package (before the example)

LoadPackage("gbnp", false);

# NMO Example 1 is taken from Dr. Edward Green's paper
# Noncommutative Gröbner Bases, and Projective Resolutions,
# and is referenced as Example 2.7 there;
# please see <Cite Key="Green1997"/> for more information.
#
Print( "starting NMO test 1:\n" );
# remove any previous orderings
UnpatchGBNP();
# Create a noncommutative free algebra on 4 gens over the Rationals
A := FreeAssociativeAlgebraWithOne(Rationals,"a","b","c","d");
# Label the generators of the algebra:
a := A.a; b := A.b; c := A.c; d := A.d;
# Set up our polynomials, and convert them to NP format:
polys := [ c*d*a*b-c*b, b*c-d*a ];

Print( "polys = ", polys, "\n" );
reps := GP2NPList( polys );
Print( " reps = ", reps, "\n" );

# Compute the Gröbner basis via GBNP using its default
# (length left-lexicographic) ordering; that is,
# without patching GBNP with an NMO ordering:
gbreps := Grobner( reps );;

Print( "gbreps = ", gbreps, "\n" );
gb := NP2GPList( gbreps, A );
Print( "    gb = ", gb, "\n" );

# Create a length left-lexicographic ordering,
# with generators ordered: a &lt; b  &lt; c &lt; d.
# Note: this is the default ordering of generators by NMO,
# if none is provided:
ml := NCMonomialLeftLengthLexOrdering( A );

# Patch GBNP with the ordering <C>ml</C>, and then run the same example.
# We should get the same answer as above:
PatchGBNP( ml );
gbreps := Grobner( reps );;
gb := NP2GPList( gbreps, A );
Print( "    gb = ", gb, "\n" );

# Now create a Length-Lexicographic ordering on the generators
# such that  d &lt; c &lt; b &lt; a
ml2 := NCMonomialLeftLengthLexOrdering( A, [4,3,2,1] );

# Compute the Gröbner basis w.r.t this new ordering on the same algebra:
PatchGBNP( ml2 );
gbreps2 := SGrobner( reps );;
gb2 := NP2GPList( gbreps2, A );
Print( "    gb2 = ", gb2, "\n" );


# NMO Example 2 is the same as Example 1 above, except that the length
# and left-lexicographic orderings are created independently and then
# chained to form the usual length left-lexicographic ordering.
# Hence, all results should be the same.
Print( "\nstarting NMO test 2:\n" );
# remove any previous orderings
UnpatchGBNP();
# Create a noncommutative free algebra on 4 generators over the
# Rationals, label, and set up the example:
A := FreeAssociativeAlgebraWithOne(Rationals,"a","b","c","d");;
a := A.a;; b := A.b;; c := A.c;; d := A.d;;
# revert to the default ordering
PatchGBNP( ml );
polys := [ c*d*a*b-c*b, b*c-d*a ];;
reps := GP2NPList( polys );;

Print( "in test 2, reps = ", reps, "\n" );
Print( "and Grobner(reps) = ", Grobner(reps), "\n" );

# Create left-lexicographic ordering with a &lt; b  &lt; c &lt; d:
lexord := NCMonomialLeftLexicographicOrdering( A );

# Create a length ordering on monomials in <M>A</M>,
# with ties broken by the lexicographic order lexord:
lenlex := NCMonomialLengthOrdering( A, lexord );

# Patch GBNP and proceed with our example:
PatchGBNP( lenlex );;
gbreps := Grobner( reps );;

Print( "gbreps = ", gbreps, "\n" );

gb := NP2GPList( gbreps, A );

Print( "gb = ", gb, "\n" );

# Now, proceed similarly, with the lexicographic order
# such that d &lt; c  &lt; b &lt; a:
lexord2 := NCMonomialLeftLexicographicOrdering( A, [4,3,2,1] );
lenlex2 := NCMonomialLengthOrdering( A, lexord2 );

# not sure what the point is of printing out these functions
# so commenting them out for now
# GtNP1 := GtNP;
# Print( "*********************\n", GtNP, "\n**************************\n" );
# PatchGBNP( lenlex2 );;
# Print( "*********************\n", GtNP, "\n**************************\n" );
# GtNP2 := GtNP;
# Print( "GtNP1 = GtNP2 ?  ", GtNP1 = GtNP2, "\n" );

gbreps2 := Grobner( reps );;
Print( "gbreps2 = ", gbreps2, "\n" );
gb2 := NP2GPList( gbreps2, A );
Print( "gb2 = ", gb2, "\n" );

# An important point can be made here.  Notice that when the lenlex2
# length ordering is created, a lexicographic (generator) ordering
# table is assigned internally to the ordering since one was not
# provided to it.
# This is just a convenience for lexicographically-dependent orderings,
# and in the case of the length order, it is not used.
# Only the lex table for <C>lexord2</C> is ever used.
# Some clarification may be provided in examining:
HasNextOrdering( lenlex2 );
NextOrdering( lenlex2 );
Print( "LexicographicTable( NextOrdering( lenlex2 ) ) = " );
Print( LexicographicTable( NextOrdering( lenlex2 ) ), "\n" );


# NMO Example 3 is taken from the book
# 'Ideals, Varieties, and Algorithms', (<Cite Key="CLO97"/>,
# Example 2, p. 93-94); it is a commutative example.
Print( "starting NMO test 3:\n" );
# remove any previous orderings
UnpatchGBNP();
# First, set up the problem and find a Gröbner basis w.r.t. the length
# left-lexicographic ordering implicitly assumed in GBNP:
A3 := FreeAssociativeAlgebraWithOne( Rationals, "x", "y", "z" );;
x := A3.x;; y := A3.y;; z := A3.z;; id := One(A3);;
polys3 := [ x^2 + y^2 + z^2 - id, x^2 + z^2 - y, x-z,
            x*y-y*x, x*z-z*x, y*z-z*y];;
reps3 := GP2NPList( polys3 );;
gb3 := Grobner( reps3 );;
Print( "in Example 3 gb3 = ", gb3, "\n" );
Print( NP2GPList( gb3, A3 ), "\n" ) ;

# The example, as presented in the book, uses a left-lexicographic
# ordering with z &lt; y  &lt; x.  We create the ordering in NMO,
# patch GBNP,and get the result expected:
ml3 := NCMonomialLeftLexicographicOrdering( A3, [3,2,1] );
PatchGBNP( ml3 );
gb3 := Grobner( reps3 );;
Print( "in Example 3, using ml3, gb3 = ", gb3, "\n" );
Print( NP2GPList( gb3, A3 ), "\n" ) ;


# NMO Example 4 was taken from page 339 of the book
# 'Some Tapas of Computer Algebra' by A.M. Cohen, H. Cuypers, H. Sterk,
# <Cite Key="CohenCuypersSterk1999"/>;
# it also appears as Example 6 in the GBNP example set.
# A noncommutative free algebra on 6 generators over the Rationals
# is created in GAP, and the generators are labeled:
Print( "starting NMO test 4:\n" );
# remove any previous orderings
UnpatchGBNP();
A4 := FreeAssociativeAlgebraWithOne(Rationals,"a","b","c","d","e","f");;
a := A4.a;; b := A4.b;; c := A4.c;; d := A4.d;; e := A4.e;; f := A4.f;;
# install the default ordering
lexord4 := NCMonomialLeftLexicographicOrdering( A4 );
Print( "lexord4 = ", lexord4, "\n" );
# Set up list of noncommutative polynomials:
polys4 := [ e*a, a^3 + f*a, a^9 + c*a^3, a^81 + c*a^9 + d*a^3,
            a^27 + d*a^81 + e*a^9 + f*a^3, b + c*a^27 + e*a^81 + f*a^9,
            c*b + d*a^27 + f*a^81, a + d*b + e*a^27, c*a + e*b + f*a^27,
            d*a + f*b, b^3 - b, a*b - b*a, a*c - c*a, a*d - d*a,
            a*e - e*a, a*f - f*a, b*c - c*b, b*d - d*b, b*e - e*b,
            b*f - f*b, c*d - d*c, c*e - e*c, c*f - f*c, d*e - e*d,
            d*f - f*d, e*f - f*e ];;
reps4 := GP2NPList( polys4 );;
# Create a length left-lex ordering with the following (default)
# ordering on the generators: a &lt; b  &lt; c &lt; d &lt; e &lt; f:
ml4 := NCMonomialLeftLengthLexOrdering( A4 );
# Patch GBNP and compute the Gröbner basis w.r.t the ordering ml4:
PatchGBNP( ml4 );
gb4 := Grobner( reps4 );;
Print( "in Example 4 gb4 = ", gb4, "\n" );
Print( NP2GPList( gb4, A4 ), "\n" ) ;
