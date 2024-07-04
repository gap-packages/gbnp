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


# <#GAPDoc Label="Example10">
# <Section Label="Example10"><Heading>A commutative example by Mora</Heading>
# Here we present a commutative example from page 339 of
# <Q>An introduction to commutative and non-commutative Gröbner Bases</Q>, by
# Teo Mora <Cite Key="TCS::Mora1994:131"/>.
# It involves the seven variables <M>a,b,c,d,e,f,g</M>.
# In order to force commuting between each pair from <M>\{a,b,c,d,e,f,g\}</M>,
# we let part of the input equations
# be the homogeneous binomials of the form
# <M>xy - yx</M>.
# GBNP is built for non-commutative polynomial arithmetic, and should handle
# the commutative case by means of this forced commutation. But it should not
# be considered as a serious alternative to the well-known Gröbner bases
# packages when it comes to efficiency.
# <P/>
# First load the package and set the standard infolevel <Ref
# InfoClass="InfoGBNP" Style="Text"/> to 1 and the time infolevel <Ref
# Func="InfoGBNPTime" Style="Text"/> to 1 (for more information about the info
# level, see Chapter <Ref Chap="Info"/>).

# <L>
LoadPackage("gbnp", false);
SetInfoLevel(InfoGBNP,1);
SetInfoLevel(InfoGBNPTime,0);
# </L>

# The relations will be entered as GAP polynomials and converted to NP form
# (see <Ref Sect="NP"/>) with <Ref Func="GP2NPList" Style="Text"/>.

# <L>
F:=GF(7);; ef:=One(F);;
A:=FreeAssociativeAlgebraWithOne(F, "a", "b", "c", "d", "e", "f", "g");
gens:=GeneratorsOfAlgebra(A);
a:=gens[2];; b:=gens[3];; c:=gens[4];; d:=gens[5];; e:=gens[6];; f:=gens[7];;
g:=gens[8];; ea:=gens[1];;

rels := [ a^3 + f*a,
	a^9 + c*a^3 + g*a,
	a^81 + c*a^9 + d*a^3,
	c*a^81 + d*a^9 + e*a^3,
	a^27 + d*a^81 + e*a^9 + f*a^3,
	b + c*a^27 + e*a^81 + f*a^9 + g*a^3,
	c*b + d*a^27 + f*a^81 + g*a^9,
	a + d*b + e*a^27 + g*a^81,
	c*a + e*b + f*a^27,
	d*a + f*b + g*a^27,
	e*a + g*b,
	b^3 - b ];;
# </L>

# Some relations added to enforce commutativity.

# <L>
for i in [1..6] do
    for j in [i+1..7] do
        Add(rels,gens[i+1]*gens[j+1]-gens[j+1]*gens[i+1]);
    od;
od;
# </L>

# Now the relations are converted to NP form (see <Ref Sect="NP"/>) with the
# function <Ref Func="GP2NPList" Style="Text"/>.

# <L>
KI:=GP2NPList(rels);;
# </L>

# The Gröbner basis can be calculated with <Ref Func="SGrobner" Style="Text"/>
# and printed with <Ref Func="PrintNPList" Style="Text"/>.

# <L>
GB := SGrobner(KI);;
PrintNPList(GB);
# </L>


# To determine whether the quotient algebra is finite dimensional
# we invoke <Ref Func="FinCheckQA" Style="Text"/>, using as arguments
# the leading monomials of <C>GB</C> and 7, the number of variables involved.
# The leading monomials of <C>GB</C> are obtained by
# <Ref Func="LMonsNP" Style="Text"/>.

# <L>
F := LMonsNP(GB);;
FinCheckQA(F,7);
# </L>


# Thus, the quotient algebra turns out to be infinite dimensional.
# This is no surprise as the Gröbner basis shows it is actually
# the free commutative algebra generated by <M>c,d,e,f,g</M>.
# In particular, it has polynomial growth of degree 5. This is confirmed
# by application of
# <Ref Func="DetermineGrowthQA" Style="Text"/>, with the first two arguments
# as for <C>FinCheckQA</C> above and third argument <C>false</C>, indicating
# that an interval for the degree of the polynomial degree will suffice.
# <L>
DetermineGrowthQA(F,7,false);
# </L>
# It turns out that this quick version already gives an exact answer.
# More time consuming would be the algorithm run with third argument
# equal to <C>true</C>.
# <L>
DetermineGrowthQA(F,7,true);
# </L>

# </Section>
# <#/GAPDoc>
