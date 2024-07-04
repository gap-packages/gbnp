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

### filename = "example17.g"
### authors Knopper

### THIS IS A GAP PACKAGE GBNP
### FOR COMPUTING WITH NON-COMMUTATIVE POLYNOMIALS

# <#GAPDoc Label="Example17">
# <Section Label="Example17"><Heading>An algebra over a finite field</Heading>
# A small example over a field other than the rationals, using the conversion
# functions from <Ref Sect="TransitionFunctions"/>.
# The input relations define the symmetric group of degree 3,
# denoted <M>S_3</M>.
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

# Let <C>F</C> be the field GF(2). The relations can be
# entered as elements of a free associative algebra with one <C>A</C> (see
# <Ref BookName="Reference" Label="FreeAssociativeAlgebraWithOne"/>).

# <L>
F:=GF(2);;
A:=FreeAssociativeAlgebraWithOne(F,"a","b");
g:=GeneratorsOfAlgebraWithOne(A);
# </L>

# Enter the relations <M>\{a^2-1,b^2-1,(ab)^3-1\}</M>, convert them to NP-form,
# see Section <Ref Sect="NP"/>, with <Ref Func="GP2NPList" Style="Text"/> and
# print them with <Ref Func="PrintNPList" Style="Text"/>:

# <L>
KI_GP := [ g[1]^2-g[1]^0, g[2]^2-g[1]^0, (g[1]*g[2])^3-g[1]^0];
KI:=GP2NPList(KI_GP);;
PrintNPList(KI);
# </L>

# Now calculate the Gröbner basis with <Ref Func="SGrobner" Style="Text"/> and
# print it with <Ref Func="PrintNPList" Style="Text"/>:

# <L>
GB:=SGrobner(KI);;
PrintNPList(GB);
# </L>

# Now calculate the dimension of the quotient algebra with <Ref Func="DimQA"
# Style="Text"/> (2 symbols) and a base with <Ref Func="BaseQA" Style="Text"/>
# (2 symbols, 0 for whole base) and print the base.
# This will give a list of elements of the group.

# <L>
DimQA(GB,2);
B:=BaseQA(GB,2,0);;
PrintNPList(B);
# </L>

# We can print the Gröbner basis and the basis of the quotient algebra,
# converted back to GAP polynomials with <Ref Func="NP2GPList" Style="Text"/>.
# The functions used to convert the polynomials also require the algebra as an
# argument. The result is useful for further computations in <M>A</M>.

# <L>
NP2GPList(GB,A);
NP2GPList(B,A);
# </L>

# The matrix of right multiplication with the image of the
# first variable
# can be computed by <Ref Func="MatrixQA" Style="Text"/>.
# <L>
Display(MatrixQA(1,B,GB));
# </L>




# </Section>
# <#/GAPDoc>
