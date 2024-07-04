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

### filename = "example01.g"
### authors Cohen & Gijsbers

### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES

### Last change: August 22 2001.
### amc

# <#GAPDoc Label="Example01">
# <Section Label="Example01">
# <Heading>A simple commutative Gröbner basis computation</Heading>
# In this commutative example the relations are <M>x^2y-1</M>
# and <M>xy^2-1</M>;
# we add <M>xy-yx</M> to enforce that
# <M>x</M> and <M>y</M> commute.
# The answer should be <M>\{x^3-1, x-y, xy-yx\}</M>,
# as the reduction ordering is total degree first
# and then lexicographic with <M> x </M> smaller than
# <M>y</M>.
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

# Then input the relations in NP format (see Section <Ref Sect="NP"/>).
# They will be put in the list <C>Lnp</C>.

# <L>
Lnp := [ [[[1,2],[2,1]],[1,-1]]   ];
x2y := [[[1,1,2],[]],[1,-1]];
    AddSet(Lnp,x2y);
xy2 := [[[1,2,2],[]],[1,-1]];
    AddSet(Lnp,xy2);
# </L>

# The relations can be exhibited with <Ref Func="PrintNPList" Style="Text"/>:

# <L>
PrintNPList(Lnp);
# </L>

# Let the variables be printed as <M>x</M> and <M>y</M> instead of <M>a</M> and <M>b</M> by means of
# <Ref Func="GBNP.ConfigPrint" Style="Text"/>
# <L>
GBNP.ConfigPrint("x","y");
# </L>




# The Gröbner basis can now be calculated with
# <Ref Func="SGrobner" Style="Text"/>:

# <L>
GB := SGrobner(Lnp);
# </L>

# When printed, it looks like:

# <L>
PrintNPList(GB);
# </L>

# The dimension of the quotient algebra can be calculated with
# <Ref Func="DimQA" Style="Text"/>. The arguments are the Gröbner basis
# <C>GB</C> and the number of variables is <C>2</C>:

# <L>
DimQA(GB,2);
# </L>

# A basis of this quotient algebra can be calculated with <Ref Func="BaseQA"
# Style="Text"/>. The arguments are a Gröbner basis <C>GB</C>, the
# number of variables <A>t</A> (<M>=2</M>) and a variable <A>maxno</A> for
# returning partial quotient algebras (0 means full basis). The calculated
# basis will be printed as well.

# <L>
B:=BaseQA(GB,2,0);;
PrintNPList(B);
# </L>

# The strong normal form of the element <M>xyxyxyx</M> can be found by use of
# <Ref Func="StrongNormalFormNP" Style="Text"/>.
# The arguments are this element and the Gröbner basis <C>GB</C>.

# <L>
f:=[[[1,2,1,2,1,2,1]],[1]];;
PrintNP(f);
p:=StrongNormalFormNP(f,GB);;
PrintNP(p);
# </L>




# </Section>
# <#/GAPDoc>

