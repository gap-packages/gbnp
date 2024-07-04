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

### filename = "example03.g"
### authors Cohen & Gijsbers

### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES

### Last change: August 22 2001.
### amc

# <#GAPDoc Label="Example03">
# <Section Label="Example03"><Heading>The order of the Weyl group of type E<M>_6</M></Heading>
# In order to show how the order of a finite group of manageable size with a manageable
# presentation can be computed, we determine the order of the Weyl group of type E<M>_6</M>.
# This number is well known to be 51840.
# <P/>
# First load the package and set the standard infolevel <Ref
# InfoClass="InfoGBNP" Style="Text"/> to 1 and the time infolevel <Ref
# Func="InfoGBNPTime" Style="Text"/> to 2 (for more information about the info
# level, see Chapter <Ref Chap="Info"/>).

# <L>
LoadPackage("gbnp", false);
SetInfoLevel(InfoGBNP,1);
SetInfoLevel(InfoGBNPTime,0);
# </L>

# Then input the relations in NP format (see <Ref Sect="NP"/>).
# They come from the presentation of the Weyl group as a Coxeter group.
# This means that there are six variables, one for each generator.
# We let the corresponding variables be printed as <M>r_1</M>, ..., <M>r_6</M> by means of
# <Ref Func="GBNP.ConfigPrint" Style="Text"/>
# <L>
GBNP.ConfigPrint(6,"r");
# </L>


# The relations are binomial and represent the group relations,
# which express that the generators are involutions (that is,
# have order 2) and that the orders of the products of any two generators
# is specified by the Coxeter diagram (see any book on Coxeter groups for details).
# The relations will be
# assigned to <C>KI</C>.

# <L>
k1 := [[[1,3,1],[3,1,3]],[1,-1]];;
k2 := [[[4,3,4],[3,4,3]],[1,-1]];;
k3 := [[[4,2,4],[2,4,2]],[1,-1]];;
k4 := [[[4,5,4],[5,4,5]],[1,-1]];;
k5 := [[[6,5,6],[5,6,5]],[1,-1]];;
k6 := [[[1,2],[2,1]],[1,-1]];;
k7 := [[[1,4],[4,1]],[1,-1]];;
k8 := [[[1,5],[5,1]],[1,-1]];;
k9 := [[[1,6],[6,1]],[1,-1]];;
k10 := [[[2,3],[3,2]],[1,-1]];;
k11 := [[[2,5],[5,2]],[1,-1]];;
k12 := [[[2,6],[6,2]],[1,-1]];;
k13 := [[[3,5],[5,3]],[1,-1]];;
k14 := [[[3,6],[6,3]],[1,-1]];;
k15 := [[[4,6],[6,4]],[1,-1]];;
k16 := [[[1,1],[]],[1,-1]];;
k17 := [[[2,2],[]],[1,-1]];;
k18 := [[[3,3],[]],[1,-1]];;
k19 := [[[4,4],[]],[1,-1]];;
k20 := [[[5,5],[]],[1,-1]];;
k21 := [[[6,6],[]],[1,-1]];;
KI := [k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,
       k11,k12,k13,k14,k15,k16,k17,k18,k19,k20,k21
      ];;
# </L>

# The relations can be shown with <Ref Func="PrintNPList" Style="Text"/>:

# <L>
PrintNPList(KI);
# </L>

# The Gröbner basis can now be calculated with
# <Ref Func="SGrobner" Style="Text"/>:

# <L>
GB := SGrobner(KI);;
PrintNPList(GB);
# </L>

# The base of the quotient algebra can be calculated with <Ref Func="BaseQA"
# Style="Text"/>, which has as arguments a Gröbner basis <C>GB</C>, a number
# of symbols <C>6</C> and a maximum terms to be found (here 0 is entered, for
# a full base) . Since it is very long we will not print it here.

# <L>
B:=BaseQA(GB,6,0);;
# </L>

# The dimension of the quotient algebra can be calculated with
# <Ref Func="DimQA" Style="Text"/>, the arguments are the Gröbner basis
# <C>GB</C> and the number of symbols <C>6</C>. Since <Ref
# InfoClass="InfoGBNPTime" Style="Text"/> is set to 2, we get
# timing information from <Ref Func="DimQA" Style="Text"/>:

# <L>
DimQA(GB,6);
# </L>

# Note that the calculation of the dimension takes almost as long as
# calculating the base. Since we have already calculated a base <C>B</C> it is
# much more efficient to calculate the dimension with <C>Length</C>:

# <L>
Length(B);
# </L>

# </Section>
# <#/GAPDoc>
