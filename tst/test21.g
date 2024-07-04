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

### filename = "example21.g"
### author Knoppe21

### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES

# <#GAPDoc Label="Example21">
# <Section Label="Example21"><Heading>The symmetric inverse monoid for a set of size four</Heading>
# The algebra we will consider is from Example 4 from Linton <Cite Key="MR94k:20022"/>.
# Its monomials form the symmetric inverse monoid, that is, the monoid of all
# partial bijections on a given set, for a set of size four. The presentation
# is <M>\langle s_1,s_2,s_3,e\mid s_i^2=(s_1s_2)^3=(s_2s_3)^3=(s_1s_3)^2=1, e^2=e,
# s_1e=es_1,s_2e=es_2,es_3e=(es_3)^2=(s_3e)^2\rangle</M>. The dimension of the
# monoid algebra is 209. The monoid has a natural representation of degree 4 by means of
# partial permutation matrices, which can be obtained by taking
# prefix relations <M>\{e,s_1-1, s_2-1, s_3e-s_3\}</M>.
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

# Now enter the relations as GAP polynomials. The module is one dimensional so
# it is possible to enter it with and without a module. In Example 18 (<Ref
# Sect="Example18"/>) both ways are shown. Here the relations will be entered
# without a module, with a free associative algebra with one over the field
# (the rational numbers) (see also <Ref BookName="Reference"
# Label="FreeAssociativeAlgebraWithOne"/>). For convenience we use the
# variables <C>s1</C>, <C>s2</C>, <C>s3</C>, and <C>e</C> for the generators of
# the algebra, and <C>o</C> for the identity element of the algebra.

# <L>
A:=FreeAssociativeAlgebraWithOne(Rationals, "s1", "s2", "s3", "e");
g:=GeneratorsOfAlgebra(A);;
s1:=g[2];;s2:=g[3];;s3:=g[4];;e:=g[5];;o:=g[1];;
# </L>

# It is possible to print symbols like they are printed in the algebra <C>A</C>
# with the function <Ref Func="GBNP.ConfigPrint" Style="Text"/>:

# <L>
GBNP.ConfigPrint(A);
# </L>

# Now the relations are entered:

# <L>
twosidrels:=[s1^2-o,s2^2-o,s3^2-o,(s1*s2)^3-o,(s2*s3)^3-o,(s1*s3)^2-o,
        e^2-e,s1*e-e*s1,s2*e-e*s2,e*s3*e-(e*s3)^2,e*s3*e-(s3*e)^2];
prefixrels:=[e,s1-o,s2-o,s3*e-s3];
# </L>

# First the relations are converted into NP format (see <Ref Sect="NP"/>) and
# next the function <Ref Func="SGrobnerModule" Style="Text"/> is called to
# calculate a Gröbner basis record.

# <L>
GBR:=SGrobnerModule(GP2NPList(prefixrels),GP2NPList(twosidrels));;
# </L>

# The record GBR has two members: the two-sided relations <C>GBR.ts</C> and the
# prefix relations <C>GBR.p</C>. We print these using the
# function <Ref Func="PrintNPList" Style="Text"/>:

# <L>
PrintNPList(GBR.ts);
PrintNPList(GBR.p);
# </L>

# It is now possible to calculate the standard basis of the quotient module
# with the function <Ref Func="BaseQM" Style="Text"/>. This function has as
# arguments the Gröbner basis record <C>GBR</C>, the number of generators of
# the algebra (here this is 4), the number of generators of
# the module (here this is 1),  and
# a variable <C>maxno</C> for returning partial bases (0 means full
# basis).

# <L>
B:=BaseQM(GBR,4,1,0);;
PrintNPList(B);
# </L>


# Next we write down the matrices for the right action of the generators
# on the module. First by means of the list command
# <Ref Func="MatricesQA" Style="Text"/>, next one by one by means of
# <Ref Func="MatrixQA" Style="Text"/> within a loop.

# <L>
MatricesQA(4,B,GBR);
for i in [1..4] do
  Display(MatrixQA(i,B,GBR)); Print("\n");
od;
# </L>

# </Section>
# <#/GAPDoc>

