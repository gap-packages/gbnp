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

### filename = "example19.g"
### author Knopper
### amc edited 22 March 2007

### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES
### Last change: September 25 2003
### jwk

# <#GAPDoc Label="Example19">
# <Section Label="Example19"><Heading>The dihedral group of order 8 on another module</Heading>
# In this example (Example 2 from Linton <Cite Key="MR94k:20022"/>) the two-sided relations give the group algebra
# of the group with presentation
# <M>\langle a,b\mid a^4=b^2=(ab)^2=1\rangle</M>, the dihedral group of order 8.
# This module relation fixes the all-one vector of Example <Ref Sect="Example18"/>:
# <M>1 + a(1+a+b)</M>.
# <P/>
# First load the package and set the standard infolevel <Ref
# InfoClass="InfoGBNP" Style="Text"/> to 0 and the time infolevel <Ref
# Func="InfoGBNPTime" Style="Text"/> to 0 (for more information about the info
# level, see Chapter <Ref Chap="Info"/>).

# <L>
LoadPackage("gbnp", false);
SetInfoLevel(InfoGBNP,0);
SetInfoLevel(InfoGBNPTime,0);
# </L>

# We will enter the relations as GAP polynomials. It is possible to enter these
# with and without a module.
# How to do this is shown in <Ref Sect="Example18"/>.
# The relations here are entered without a module, since the module is
# only one-dimensional.
# It is possible to enter them using a free associative algebra with one over
# the field (the rational numbers) (see also <Ref BookName="Reference"
# Label="FreeAssociativeAlgebraWithOne"/>). For convenience we use the
# variables <C>a</C> and <C>b</C> for the generators of the algebra and
# <C>e</C> for the one of the algebra.

# <L>
A:=FreeAssociativeAlgebraWithOne(Rationals, "a", "b");
g:=GeneratorsOfAlgebra(A);;
a:=g[2];;b:=g[3];;e:=g[1];;
# </L>

# Now the relations are entered:

# <L>
twosidrels:=[a^4-e,b^2-e,(a*b)^2-e];;
prefrels:=[ b-e, e + a * (e + a + b) ];;
# </L>

# First the relations are converted into NP format (see <Ref Sect="NP"/>) after
# which the function <Ref Func="SGrobnerModule" Style="Text"/> is called to
# calculate a Gröbner basis record.

# <L>
GBR:=SGrobnerModule(GP2NPList(prefrels),GP2NPList(twosidrels));;
# </L>

# The record GBR has two members: the two-sided relations <C>GBR.ts</C> and the
# prefix relations <C>GBR.p</C>. It is possible to print these using the
# function <Ref Func="PrintNPList" Style="Text"/>:

# <L>
PrintNPList(GBR.ts);
PrintNPList(GBR.p);
# </L>

# It is now possible to calculate the standard basis of the quotient module
# with the function <Ref Func="BaseQM" Style="Text"/>. This function has as
# arguments the Gröbner basis record <C>GBR</C>, the number of generators of
# the algebra (here it is 2), the number of generators of the mdoule
# (here it is 1), and a variable <C>maxno</C> for returning partial
# bases (0 means full basis).

# <L>
B:=BaseQM(GBR,2,1,0);;
PrintNPList(B);
# </L>
# </Section>
# <#/GAPDoc>
