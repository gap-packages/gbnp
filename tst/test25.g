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

### filename = "example25.g"
### author amc
### amc last edited 1 June 2007

# <#GAPDoc Label="Example25">
# <Section Label="Example25"><Heading>Baur and Draisma's transformations</Heading>

# <L>
LoadPackage("gbnp", false);
SetInfoLevel(InfoGBNP,0);
SetInfoLevel(InfoGBNPTime,0);
# </L>

# The paper <Cite Key="MR2090062"/> by Baur and Draisma
# uses the computation of a quotient
# algebra of dimension 37, which we
# repeat here.
# The set of equations, after specialisation of the scalars to 1,
# is as follows.

# <L>
KI := [ [[[2,2]],[1]],
        [[[1,1]],[1]],
        [[[3,3]],[1]],
        [[[1,2,1],[1]],[1,-1]],
        [[[2,1,2],[2]],[1,-1]],
        [[[3,2,3],[3]],[1,-1]],
        [[[2,3,2],[2]],[1,-1]],
        [[[1,3,1],[1]],[1,-1]],
        [[[3,1,3],[3]],[1,-1]],
        [[[1,2,3,1,2,3,1],[1,3,2,1,3,2,1],[1]],[1,1,-1]],
        [[[3,1,2,3,1,2,3],[3,2,1,3,2,1,3],[3]],[1,1,-1]],
        [[[2,3,1,2,3,1,2],[2,1,3,2,1,3,2],[2]],[1,1,-1]],
      ];;
PrintNPList(KI);
# </L>

# We carry out a traced Gröbner basis computation by use of
# <Ref Func="SGrobnerTrace" Style="Text"/>,
# and form the usual Gröbner basis by extracting the polynomials
# from the traced polynomials using the field indicator <C>.pol</C>.
# <L>
GBT := SGrobnerTrace(KI);;
GB := List([1..Length(GBT)], i -> GBT[i].pol);;
# </L>

# The dimension of the quotient algebra is computable with
# <Ref Func="DimQA" Style="Text"/>.
# <L>
DimQA(GB,3);
# </L>

# In order to express the
# last GB element, viz.
# <L>
PrintNP(GB[Length(GB)]);
# </L>
# as a combination of elements of <C>KI</C>,
# we use <Ref Func="PrintTracePol" Style="Text"/>:
# <L>
PrintTracePol(GBT[Length(GBT)]);
# </L>


# We compute matrices for left multiplication by generators
# using <Ref Func="MatricesQA" Style="Text"/>
# and determine the minimal polynomial of the sum of the three matrices.

# <L>
B := BaseQA(GB,3,0);;
M := MatricesQA(3,B,GB);;
f := MinimalPolynomial(Rationals,M[1]+M[2]+M[3]);
Factors(f);
# </L>

# It turns out that there are three non-zero numbers <M>u,v,w</M>
# such that the eigenvalues of the sum are <M>0,u,v,w,-u,-v,-w</M>.
# This is the information used in  <Cite Key="MR2090062"/>.
# </Section>
# <#/GAPDoc>
