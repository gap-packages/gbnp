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

### filename = "Icosahedron.g"
### author Arjeh M. Cohen

# <#GAPDoc Label="Example04">
# <Section Label="Example04">
# <Heading>The icosahedral group</Heading>
# In this example
# the two-sided relations give the group algebra of
# the group with presentation
# <M>\langle a,b,c \mid a^2=b^2=c^2=(ab)^3=(bc)^5=(ac)^2=1\rangle</M>,
# the icosahedral group of order 120.
# This is the Coxeter group of type H<M>_3</M>.
# The module under construction is a 3-dimensional reflection representation,
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

# Create the field containing the golden ratio <C>tau</C>.

# <L>
x := Indeterminate(Rationals,"x");
p := x^2+ x-1;
K := AlgebraicExtension(Rationals,p);
tau:=RootOfDefiningPolynomial(K);
# </L>

# Create the free algebra with three generators over this field:

# <L>
A:=FreeAssociativeAlgebraWithOne(K, "a", "b", "c");
e:=One(A);; a:=A.a;; b:=A.b;; c:=A.c;;
# </L>

# The ideal for a quotient of the icosahedral group algebra over this field,
# in which <C>b</C><M>*</M><C>c</C> has a quadratic minimal polynomial
# involving <C>tau</C>:

# <L>
#(b*c)^2-tau*b*c+e
Irels:=[a^2-e,b^2-e,c^2-e,a*b*a-b*a*b,((b*c)^2-tau*b*c+e)*(b*c-e),a*c-c*a];
# </L>

# We now give module relations. The first two describe group elements
# of a vector stabilizer, the third forces the central element <M>(abc)^5</M>
# to be nontrivial.

# <L>
Mrels:=[b*c-e,b-e,(a*b*c)^5+e];;
# </L>

# First the relations are converted into NP format (see <Ref Sect="NP"/>) with
# the function <Ref Func="GP2NPList" Style="Text"/>.
# Next the function
# <Ref Func="SGrobnerModule" Style="Text"/> is called to calculate a Gröbner basis
# record (see <Ref Sect="GBR"/>).

# <L>
GBR:=SGrobnerModule(GP2NPList(Mrels),GP2NPList(Irels));;
PrintNPList(GBR.ts);;
PrintNPList(GBR.p);;
# </L>

# It is now possible to calculate the basis of the quotient algebra
# with the function <Ref Func="BaseQM" Style="Text"/>. This function has as
# arguments the Gröbner basis record <C>GBR</C>, the number of generators of
# the algebra (in this case 3), the number of generators of the
# free module in which the vectors are chosen (in this case 1),
# and a variable <C>maxno</C> for returning
# partial quotient algebras (0 means full basis).

# <L>
B:=BaseQM(GBR,3,1,0);;
PrintNPList(B);
# </L>

# Calculate the dimension of the quotient algebra
# with the function <Ref Func="DimQM" Style="Text"/>. This function has as
# arguments the Gröbner basis record <C>GBR</C>,
# the number of generators of
# the algebra (in this case 3) and
# the number of generators of
# the module (in this case 1).



# <L>
DimQM(GBR,3,1);
# </L>

# Next we write down the matrices for the right action of the generators
# on the module by means of
# <Ref Func="MatrixQA" Style="Text"/>.

# <L>
aa := MatrixQA(1,B,GBR);;
Display(aa);
bb := MatrixQA(2,B,GBR);;
Display(bb);
cc := MatrixQA(3,B,GBR);;
Display(cc);
# </L>

# Finally we check the defining relations for the icosahedral group
# on the three new matrix generators. This can be done by verifying if the
# result is equal to the identity matrix or with the function <Ref
# BookName="Reference" Func="IsOne" Style="Text"/>.

# <L>
ee := IdentityMat(3,K);;
Display(ee);
aa^2 = ee;
IsOne(aa^2);
IsOne(bb^2);
IsOne(cc^2);
IsOne((aa*bb)^3);
IsOne((aa*cc)^2);
IsOne((bb*cc)^5);
# </L>
# </Section>
# <#/GAPDoc>

