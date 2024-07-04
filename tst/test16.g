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

### filename = "example16.g"
### authors Cohen & Gijsbers & Krook

### THIS IS A GAP PACKAGE GBNP
### FOR COMPUTING WITH NON-COMMUTATIVE POLYNOMIALS
### ADD-ON: STUDY GROWTH OF FACTOR ALGEBRA


# <#GAPDoc Label="Example16">
# <Section Label="Example16"><Heading>A commutative quotient algebra of polynomial growth</Heading>
# This example extends <Ref Sect="Example06"/>,
# a commutative example from Some Tapas of Computer Algebra <Cite
# Key="CohenCuypersSterk1999"/>, page 339.
# <P/>
# The result of the Gröbner basis computation
# should be the union of <M>\{a,b\}</M> and
# the set of 6 homogeneous binomials
# (that is, polynomials with two terms) of degree 2 forcing
# commuting between <M>c</M>, <M>d</M>, <M>e</M>, and <M>f</M>, as before.
# After computation of the Gröbner basis, the quotient algebra is studied and
# found to be infinite dimensional of polynomial growth of degree 4. The
# function <Ref Func="DetermineGrowthQA" Style="Text"/> is used for this
# computation. Then part of its Hilbert series is computed. The function <Ref
# Func="HilbertSeriesQA" Style="Text"/> is used for the computations.
# <P/>
# First load the package and set the standard infolevel <Ref
# InfoClass="InfoGBNP" Style="Text"/> to 2 and the time infolevel <Ref
# Func="InfoGBNPTime" Style="Text"/> to 1 (for more information about the info
# level, see Chapter <Ref Chap="Info"/>).

# <L>
LoadPackage("gbnp", false);
SetInfoLevel(InfoGBNP,2);
SetInfoLevel(InfoGBNPTime,0);
# </L>

# Now define some functions which will help in the construction of relations.
# The function <C>powermon(i, exp)</C> will return the monomial <M>i^{exp}</M>.
# The function <C>comm(aa, bb)</C> will return a relation forcing commutativity
# between its two arguments <C>aa</C> and <C>bb</C>.

# <L>
powermon := function(base, exp)
 local ans,i;
 ans := [];
 for i in [1..exp] do ans :=  Concatenation(ans,[base]); od;
 return ans;
end;;

comm := function(aa,bb)
  return [[[aa,bb],[bb,aa]],[1,-1]];
end;;
# </L>

# Now the relations are entered:

# <L>
p1 := [[[5,1]],[1]];;
p2 := [[powermon(1,3),[6,1]],[1,1]];;
p3 := [[powermon(1,9),Concatenation([3],powermon(1,3))],[1,1]];;
p4 := [[powermon(1,81),Concatenation([3],powermon(1,9)),Concatenation([4],
        powermon(1,3))],[1,1,1]];;
p5 := [[Concatenation([3],powermon(1,81)),Concatenation([4],powermon(1,9)),
        Concatenation([5],powermon(1,3))],[1,1,1]];;
p6 := [[powermon(1,27),Concatenation([4],powermon(1,81)),Concatenation([5],
        powermon(1,9)),Concatenation([6],powermon(1,3))],[1,1,1,1]];;
p7 := [[powermon(2,1),Concatenation([3],powermon(1,27)),Concatenation([5],
        powermon(1,81)),Concatenation([6],powermon(1,9))],[1,1,1,1]];;
p8 := [[Concatenation([3],powermon(2,1)),Concatenation([4],powermon(1,27)),
        Concatenation([6],powermon(1,81))],[1,1,1]];;
p9 := [[Concatenation([],powermon(1,1)),Concatenation([4],powermon(2,1)),
        Concatenation([5],powermon(1,27))],[1,1,1]];;
p10 := [[Concatenation([3],powermon(1,1)),Concatenation([5],powermon(2,1)),
        Concatenation([6],powermon(1,27))],[1,1,1]];;
p11 := [[Concatenation([4],powermon(1,1)),Concatenation([6],powermon(2,1))],
        [1,1]];;
p12 := [[Concatenation([],powermon(2,3)),Concatenation([],powermon(2,1))],
        [1,-1]];;
KI := [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12];;
for i in [1..5] do
    for j in [i+1..6] do
        Add(KI,comm(i,j));
    od;
od;
# </L>

# The relations can be shown with <Ref Func="PrintNPList" Style="Text"/>:

# <L>
PrintNPList(KI);
# </L>

# It is usually easier to use the function <Ref Func="GP2NP" Style="Text"/> or
# the function <Ref Func="GP2NPList" Style="Text"/> to enter relations.
# Entering the first twelve relations and then converting them with <Ref
# Func="GP2NPList" Style="Text"/> is demonstrated in example 6 (<Ref
# Sect="Example06"/>). More about converting can be read in Section <Ref
# Sect="TransitionFunctions"/>.
# <P/>
# The Gröbner basis can now be calculated with <Ref Func="SGrobner"
# Style="Text"/> and printed with <Ref Func="PrintNPList" Style="Text"/>.

# <L>
GB := SGrobner(KI);
PrintNPList(GB);
# </L>

# The growth of the quotient algebra can be studied with <Ref
# Func="DetermineGrowthQA" Style="Text"/>. The first argument is the list
# of leading
# monomials, which can be calculated with <Ref Func="LMonsNP" Style="Text"/>.
# The second argument is the size of the alphabet.

# <L>
L:=LMonsNP(GB);;
DetermineGrowthQA(L,6,false);
# </L>

# Now compute the first 10 terms of the Hilbert Series with <Ref
# Func="HilbertSeriesQA" Style="Text"/>
# (note that trailing zeroes are removed):

# <L>
HilbertSeriesQA(L,6,10);
# </L>
# </Section>
# <#/GAPDoc>
