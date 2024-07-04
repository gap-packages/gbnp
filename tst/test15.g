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

### filename = "example15.g"
### author Krook

### THIS IS A GAP PACKAGE GBNP
### FOR COMPUTING WITH NON-COMMUTATIVE POLYNOMIALS
### ADD-ON: STUDY GROWTH OF FACTOR ALGEBRA


# <#GAPDoc Label="Example15">
# <Section Label="Example15"><Heading>A quotient algebra with exponential growth</Heading>
# This example demonstrates an instance in which the quotient
# algebra is infinite dimensional and has exponential
# growth. We start out with <C>KI</C><M>:=[y^4-y^2,x^2y-xy]</M> and obtain a
# Gröbner basis with leading terms <M>[xxy,yyy]</M>. The quotient algebra will
# thus have exponential growth since the
# cycles <M>(xyyx)^n</M> and <M>(xy)^m</M>
# intersect in the common subwords <M>xy</M> (and in <M>yx</M>). This is
# explained in <Cite Key="Krook2003"/>. The function <Ref
# Func="DetermineGrowthQA" Style="Text"/> is used for the computation.
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

# Let the variables be printed as <M>x</M> and <M>y</M> instead of <M>a</M> and <M>b</M> by means of
# <Ref Func="GBNP.ConfigPrint" Style="Text"/>
# <L>
GBNP.ConfigPrint("x","y");
# </L>


# Then input the relations in NP format (see Section <Ref Sect="NP"/>). They
# will be assigned to <C>KI</C>.

# <L>
k1 := [[[2,2,2,2],[2,2]],[1,-1]];;
k2 := [[[1,1,2],[1,2]],[1,-1]];;
KI := [k1,k2];;
PrintNPList(KI);
# </L>

# We calculate the Gröbner basis with the function <Ref Func="SGrobner"
# Style="Text"/> and print it with <Ref Func="PrintNPList" Style="Text"/>.

# <L>
GB := SGrobner(KI);;
PrintNPList(GB);
# </L>

# Next we check the dimensionality of the quotient algebra
# with the function <Ref
# Func="FinCheckQA" Style="Text"/> or the function <Ref Func="DetermineGrowthQA"
# Style="Text"/>. These functions expect as first argument a list <A>F</A>
# of leading terms of a Gröbner basis,
# which can be calculated with the function <Ref
# Func="LMonsNP" Style="Text"/> and as second argument the number of symbols
# (here equal to 2). The function <Ref Func="DetermineGrowthQA" Style="Text"/>
# will not only report whether a Gröbner basis is finite, but will also provide
# information about its growth.

# <L>
L:=LMonsNP(GB);
fd:=FinCheckQA(L,2);
fd:=DetermineGrowthQA(L,2,false);
# </L>

# Although the quotient algebra is infinite dimensional,
# multiplication of two elements can be carried out by
# <Ref Func="MulQA" Style="Text"/>.
# We print three positive powers of <M>x+y</M>.

# <L>
w := [[[1],[2]],[1,1]];;
hlp := [[[]],[1]];;
for i in [3..5] do
  hlp := MulQA(hlp, w, GB);
  Print("\n (x+y)^",i," = \n");
  PrintNP(hlp);
od;
# </L>


# </Section>
# <#/GAPDoc>
