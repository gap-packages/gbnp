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

### filename = "exampleNoah.g"
### authors Cohen & Wales

### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES

### Last change: Aug 12 2008, amc.
### dahg
## [A.M. Cohen, D.A.H. Gijsbers  D.B. Wales, BMW Algebras of simply laced type, J. Algebra, 286 (2005) 107--153].

# <#GAPDoc Label="Example07">
# <Section Label="Example07"><Heading>The Birman-Murakami-Wenzl algebra of type A<M>_3</M></Heading>
# We study the Birman-Murakami-Wenzl algebra of type A<M>_3</M> as an algebra
# given by generators and relations.
# A reference for the relations used is <Cite Key="MR2124811"/>.
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

# The variables are <M>g_1</M>, <M>g_2</M>, <M>g_3</M>,
# <M>e_1</M>, <M>e_2</M>, <M>e_3</M>, in this order.
# In order to have the results printed out with these symbols, we
# invoke
# <Ref Func="GBNP.ConfigPrint" Style="Text"/>
# <L>
GBNP.ConfigPrint("g1","g2","g3","e1","e2","e3");
# </L>


# Now enter the relations. This will be done in NP form (see <Ref Sect="NP"/>).
# The inderminates <M>m</M> and <M>l</M>
# in the coefficient ring of the Birman-Murakami-Wenzl algebra
# are specialized to 7 and 11 in order to make the computations more efficient.
# <L>
m:= 7;;
l:= 11;;

#relations Theorem 1.1
k1 := [[[4],[1,1],[1],[]],[1,-l/m,-l,l/m]];;
k2 := [[[5],[2,2],[2],[]],[1,-l/m,-l,l/m]];;
k3 := [[[6],[3,3],[3],[]],[1,-l/m,-l,l/m]];;

#relations B1
#empty set here

#relations B2:
k4 := [[[1,2,1],[2,1,2]],[1,-1]];;
k5 := [[[2,3,2],[3,2,3]],[1,-1]];;
k6 := [[[1,3],[3,1]],[1,-1]];;

#relations R1
kr1 := [[[1,4],[4]],[1,-1/l]];;
kr2 := [[[2,5],[5]],[1,-1/l]];;
kr3 := [[[3,6],[6]],[1,-1/l]];;

#relations R2:
kr4 := [[[4,2,4],[4]],[1,-l]];;
kr5 := [[[5,1,5],[5]],[1,-l]];;
kr6 := [[[5,3,5],[5]],[1,-l]];;
kr7 := [[[6,2,6],[6]],[1,-l]];;

#relations R2'
km1 := [[[4,5,4],[4]],[1,-1]];;
km2 := [[[5,4,5],[5]],[1,-1]];;
km3 := [[[5,6,5],[5]],[1,-1]];;
km4 := [[[6,5,6],[6]],[1,-1]];;

KI := [k1,k2,k3,k4,k5,k6,kr1,kr2,kr3,kr4,kr5,kr6,kr7,km1,km2,km3,km4];;
# </L>

# Now print the relations with <Ref Func="PrintNPList" Style="Text"/>:

# <L>
PrintNPList(KI);
Length(KI);
# </L>

# Now calculate the Gröbner basis with <Ref Func="SGrobner" Style="Text"/>:

# <L>
GB := SGrobner(KI);;
PrintNPList(GB);
# </L>

# Now calculate the dimension of the quotient algebra with <Ref Func="DimQA"
# Style="Text"/> (the second argument is the number of symbols):

# <L>
DimQA(GB,6);
# </L>

# The conclusion is that the BMW algebra of type A3 has dimension 105.
# </Section>
# <#/GAPDoc>
