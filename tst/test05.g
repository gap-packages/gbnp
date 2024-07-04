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

### filename = "example05.g"
### authors Cohen & Gijsbers

### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES

### Last change: August 22 2001.
### amc

# <#GAPDoc Label="Example05">
# <Section Label="Example05"><Heading>The gcd of some univariate polynomials</Heading>
# A list of univariate polynomials is generated. The result of the
# Gröbner basis computation on this list should be a single
# monic polynomial, their gcd.
# <P/>
# First load the package and set the standard infolevel <Ref
# InfoClass="InfoGBNP" Style="Text"/> to 2 and the time infolevel <Ref
# Func="InfoGBNPTime" Style="Text"/> to 1
# (for more information about the info
# level, see Chapter <Ref Chap="Info"/>).

# <L>
LoadPackage("gbnp", false);
SetInfoLevel(InfoGBNP,2);
SetInfoLevel(InfoGBNPTime,0);
# </L>

# Let the single variable be printed as x by means of
# <Ref Func="GBNP.ConfigPrint" Style="Text"/>
# <L>
GBNP.ConfigPrint("x");
# </L>

# Now input the relations in NP format (see <Ref Sect="NP"/>). They will be
# assigned to <C>KI</C>.

# <L>
p0 := [[[1,1,1],[1,1],[1],[]],[1,2,2,1]];;
p1 := [[[1,1,1,1],[1,1],[]],[1,1,1]];;
KI := [p0,p1];;

for i in [2..12] do
    h := AddNP(AddNP(KI[i],KI[i-1],1,3),
        AddNP(BimulNP([1],KI[i],[]),KI[i-1],2,1),3,-5);
    Add(KI,h);
od;
# </L>

# The relations can be shown with <Ref Func="PrintNPList" Style="Text"/>:

# <L>
PrintNPList(KI);
Length(KI);
# </L>

# The Gröbner basis can now be calculated with
# <Ref Func="SGrobner" Style="Text"/>:

# <L>
GB := SGrobner(KI);;
# </L>

# Printed it looks like:

# <L>
PrintNPList(GB);
# </L>

# </Section>
# <#/GAPDoc>
