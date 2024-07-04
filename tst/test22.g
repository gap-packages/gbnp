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

### filename = "example22.g"
### author Knopper

### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES

# <#GAPDoc Label="Example22">
# <Section Label="Example22"><Heading>A module of the Hecke algebra of type
# A<M>_3</M> over GF(3)</Heading>
# This example is an extension of Example 5 from
# Linton, <Cite Key="MR94k:20022"/>. It concerns
# the Hecke Algebra of type A<M>_3</M>. By reducing mod 3 but without
# evaluating at <M>q=1</M> it is possible to obtain the following
# representation of the Hecke algebra of type A<M>_3</M> over GF(3): <M>\langle
# x, y, z\mid x^2+(1-q)*x-q,y^2+(1-q)*y-q,z^2+(1-q)*z-q,y*x*y-x*y*x, z*y*z-y*z*y,
# z*x-x*z\rangle</M>. It has a natural representation of the same dimension as
# the Lie algebra of type A<M>_3</M>, namely 4. This representation can be
# obtained with the module relations <M>\{x+1,y+1\}</M>.
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
# it is possible to enter it with and without a module. Both are used in
# Example <Ref Sect="Example18"/>. Here the relations will be entered
# without using a module. First a free associative algebra with one is created
# over the field (GF(3))
# (see also <Ref BookName="Reference" Label="FreeAssociativeAlgebraWithOne"/>).
# For convenience we use the
# variables <C>a</C> and <C>b</C> for the generators of the algebra and
# <C>e</C> for the one of the algebra.

# <L>
q:=Indeterminate(GF(3),"q");
A:=FreeAssociativeAlgebraWithOne(Field(q), "x", "y", "z");;
g:=GeneratorsOfAlgebra(A);;
x:=g[2];;y:=g[3];;z:=g[4];;e:=g[1];;q:=q*e;;
# </L>


# In order to print the variables like they are printed in the algebra <C>A</C>
# with the function <Ref Func="GBNP.ConfigPrint" Style="Text"/>:

# <L>
GBNP.ConfigPrint(A);
# </L>

# Now the relations are entered:

# <L>
twosidrels:=[x^2+(e-q)*x-q,y^2+(e-q)*y-q,z^2+(e-q)*z-q,
  y*x*y-x*y*x,z*y*z-y*z*y,z*x-x*z];
prefixrels:=[x+e,y+e];
# </L>

# First the relations are converted into NP format (see <Ref Sect="NP"/>) after
# which the function <Ref Func="SGrobnerModule" Style="Text"/> is called to
# calculate a Gröbner basis record.

# <L>
GBR:=SGrobnerModule(GP2NPList(prefixrels),GP2NPList(twosidrels));;
# </L>

# The record GBR has three members:
# the two-sided relations <C>GBR.ts</C>, the
# prefix relations <C>GBR.p</C>, and the number <C>GBR.pg</C> of generators
# of the free
# module. It is possible to print the first two using the
# function <Ref Func="PrintNPList" Style="Text"/>:

# <L>
PrintNPList(GBR.ts);
PrintNPList(GBR.p);
# </L>

# It is now possible to calculate the standard basis of the quotient module
# with the function <Ref Func="BaseQM" Style="Text"/>. This function has as
# arguments the Gröbner basis record <C>GBR</C>, the number of generators of
# the algebra (here this is 3), the number of generators of
# the module (here this is 1), and a variable <C>maxno</C> for returning
# partial bases (0 means full basis).

# <L>
B:=BaseQM(GBR,3,1,0);;
PrintNPList(B);
# </L>

# Next we write down the matrices for the right action of the generators
# on the module, by means of the command
# <Ref Func="MatricesQA" Style="Text"/>.

# <L>
MM := MatricesQA(3,B,GBR);;
for i in [1..Length(MM)] do
Display(MM[i]); Print("\n");
od;
# </L>

# </Section>
# <#/GAPDoc>
