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

### filename = "example20.g"
### author Knopper
### amc last edited 25 May 2007 problem with GBNP(y[1]+y[2])

# <#GAPDoc Label="Example20">
# <Section Label="Example20"><Heading>The dihedral group on a non-cyclic module</Heading>
# In this example (Example 3 from Linton <Cite Key="MR94k:20022"/>),
# the two-sided relations give the group algebra of
# the group with presentation
# <M>\langle a,b\mid a^4=b^2=(ab)^2=1\rangle</M>, the dihedral group of order 8.
# The module under construction is a non-cyclic module,
# obtained by taking two copies of the
# representation of Example <Ref Sect="Example18"/> and fusing
# their one-dimensional submodules.
# <P/>
# Load the package and set the standard infolevel <Ref
# InfoClass="InfoGBNP" Style="Text"/> to 1 and the time infolevel <Ref
# Func="InfoGBNPTime" Style="Text"/> to 1 (for more information about the info
# level, see Chapter <Ref Chap="Info"/>).

# <L>
LoadPackage("gbnp", false);
SetInfoLevel(InfoGBNP,1);
SetInfoLevel(InfoGBNPTime,0);
# </L>

# Create the free associative algebra to enter the relations in:

# <L>
A:=FreeAssociativeAlgebraWithOne(Rationals, "a", "b");
g:=GeneratorsOfAlgebra(A);;
a:=g[2];;b:=g[3];;e:=g[1];;
# </L>

# Now the relations are entered:

# <L>
twosidrels:=[a^4-e,b^2-e,(a*b)^2-e];;
D:=A^2;;
y:=GeneratorsOfLeftModule(D);;
modrels:=[y[1]*b-y[1], y[2]*b-y[2], y[1]+y[1]*a*(e+a+b) -y[2]-y[2]*a*(e+a+b)];;
# </L>

# First the relations are converted into NP format (see <Ref Sect="NP"/>) with
# the function <Ref Func="GP2NPList" Style="Text"/>.
# They are printed in raw form and subsequently
# in a more legible format.

# <L>
modrelsNP:=GP2NPList(modrels);
PrintNPList(modrelsNP);
# </L>

# Next the function
# <Ref Func="SGrobnerModule" Style="Text"/> is called to calculate a Gröbner basis
# record (see <Ref Sect="GBR"/>).

# <L>
GBR:=SGrobnerModule(modrelsNP,GP2NPList(twosidrels));;
# </L>

# The record <C>GBR</C> has two members: the two-sided relations <C>GBR.ts</C>
# and the prefix relations <C>GBR.p</C>. It is possible to print these using
# the function <Ref Func="PrintNPList" Style="Text"/>:

# <L>
PrintNPList(GBR.ts);
PrintNPList(GBR.p);
# </L>

# It is now possible to calculate the standard basis of the quotient module
# with the function <Ref Func="BaseQM" Style="Text"/>. This function has as
# arguments the Gröbner basis record <C>GBR</C>, the number of generators of
# the algebra (in this case 2),
# the number of generators of
# the module (in this case 2), and a variable <C>maxno</C> for returning
# partial bases (0 means full basis).

# <L>
B:=BaseQM(GBR,2,2,0);;
PrintNPList(B);
# </L>

# It is also possible to convert each member of the list <C>B</C> of
# polynomials in NP form to GAP polynomials to do further calculations within
# the algebra or module. This can be done with the function <Ref
# Func="NP2GPList" Style="Text"/>.

# <L>
NP2GPList(B,D);
# </L>

# Individual GAP polynomials can be
# obtained from polynomials in NP form
# with the function <Ref Func="NP2GP" Style="Text"/>.
# This also holds for elements of the free module <C>D</C>
# in NP form.

# <L>
Display(NP2GP(B[Length(B)],D));
# </L>

# Next we write down the matrices for the right action of the generators
# on the module by means of
# <Ref Func="MatrixQA" Style="Text"/>.

# <L>
Display(MatrixQA(1,B,GBR));
Display(MatrixQA(2,B,GBR));
# </L>

# In order to compute the image of the vector  <M>2y[1]+3y[2]</M> of the two standard generators of the module
# under the action of the element <M>aab</M>, we use
# <Ref Func="StrongNormalFormNPM" Style="Text"/>. Its first argument will be the vector
# and its second the Gröbner basis.
# The transformation <Ref Func="GP2NP" Style="Text"/> to the NP format
# needs to be applied to the vector
# before it can be used as an argument.
# <L>
v:=StrongNormalFormNPM(GP2NP((y[1]*2+y[2]*3)*a*a*b), GBR);;
PrintNP(v);
# </L>


# </Section>
# <#/GAPDoc>





