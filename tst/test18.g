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

### filename = "example18.g"
### author Knopper

### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES


# <#GAPDoc Label="Example18">
# <Section Label="Example18"><Heading>The dihedral group of order 8</Heading>
# In this example (Example 1 from Linton <Cite
# Key="MR94k:20022"/>) the two-sided relations give the group algebra
# of the group with presentation
# <M>\langle a,b \mid a^4=b^2=(ab)^2=1\rangle</M>, the dihedral group of order 8.
# It is possible to construct a permutation module of degree 4, over a field
# <C>k</C>. In this example <C>k</C> will be the field of rational numbers.
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

# Now enter the relations as GAP polynomials. It is possible to enter them with
# and without module generators. First it is shown how to enter the relations
# without using a module. It is possible to enter them with a free associative
# algebra with one over the field (the rational numbers) (see also <Ref
# BookName="Reference" Label="FreeAssociativeAlgebraWithOne"/>). For
# convenience we use the variables <C>a</C> and <C>b</C> for the generators of
# the algebra and <C>e</C> for the one of the algebra.

# <L>
A:=FreeAssociativeAlgebraWithOne(Rationals, "a", "b");
a:=A.a;;b:=A.b;;e:=One(A);;
# </L>

# Now the relations are entered:

# <L>
twosidrels:=[a^4-e,b^2-e,(a*b)^2-e];;
prefixrels:=[b-e];;
# </L>

# First the relations are converted into NP format, see Section <Ref
# Sect="NP"/>, after which the function <Ref Func="SGrobnerModule"
# Style="Text"/> is called to calculate a Gröbner basis record.

# <L>
GBR:=SGrobnerModule(GP2NPList(prefixrels),GP2NPList(twosidrels));;
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
# the algebra (2), the number of generators of the module (1),
# and a variable <C>maxno</C> for returning partial bases
# (0 means full basis).

# <L>
B:=BaseQM(GBR,2,1,0);;
PrintNPList(B);
# </L>

# It is also possible to use a module with one generator to enter these
# relations:

# <L>
D:=A^1;;
gd:=GeneratorsOfLeftModule(D);;
prefixrelsdom:=[gd[1]*(b-e)];;
# </L>

# It is possible to use the two-sided Gröbner basis which was already
# calculated.

# <L>
GBR:=SGrobnerModule(GP2NPList(prefixrelsdom),GBR.ts);;
PrintNPList(GBR.p);;
B:=BaseQM(GBR,2,1,0);;
PrintNPList(B);
# </L>


# To compute the image of right multiplication of the basis element
# <C>B[Length(B)]</C> of the module with the quotient algebra element
# corresponding to
# <M>ab</M> we use the function <Ref Func="MulQM" Style="Text"/> with
# arguments <C>B[Length(B)]</C>, <C>GB2NP(a*b)</C>, and <C>GBR</C>
# We subsequently use  <Ref Func="PrintNP" Style="Text"/> to display the result
# as a 1-dimensional vector with an entry from <M>A</M>.

# <L>
v := MulQM(B[Length(B)],GP2NP(a*b),GBR);
PrintNP(v);
# </L>

# </Section>
# <#/GAPDoc>
