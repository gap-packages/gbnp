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

### filename = "example13.g"
### authors Cohen & Gijsbers & Krook
### This example was added by Chris Krook.

### THIS IS A GAP PACKAGE GBNP
### FOR COMPUTING WITH NON-COMMUTATIVE POLYNOMIALS
### ADD-ON: STUDY GROWTH OF FACTOR ALGEBRA

# <#GAPDoc Label="Example13">
# <Section Label="Example13"><Heading> Finiteness of the Weyl group of type E<M>_6</M></Heading>
# <P/>
# This example extends <Ref Sect="Example03"/>, which
# computes the order of the Weyl group of type E<M>_6</M>.
# <P/>
# Here, before the dimension is calculated, it is checked whether the quotient
# algebra is finite dimensional or infinite dimensional. The function <Ref
# Func="FinCheckQA" Style="Text"/> is used for this computation. For the use
# of <Ref Func="PreprocessAnalysisQA" Style="Text"/> to speed up the check,
# see Example <Ref Sect="Example14"/>.
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

# Then input the relations in NP format (see Section <Ref Sect="NP"/>). They
# will be assigned to <C>KI</C>. These relations are the same as those in
# Example 3.

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

# The Gröbner basis can now be calculated with
# <Ref Func="SGrobner" Style="Text"/>:

# <L>
GB := SGrobner(KI);;
# </L>

# We will check whether the quotient algebra is finite dimensional or infinite
# dimensional.
# The function <Ref Func="FinCheckQA" Style="Text"/> exists for this purpose.
# Its first argument is the list
# of leading monomials of a
# Gröbner basis and its second argument the number of symbols. The leading
# monomials can be calculated with <Ref Func="LMonsNP" Style="Text"/>.

# <L>
L:=LMonsNP(GB);;
FinCheckQA(L,6);
# </L>

# If a quotient algebra is finite dimensional, the dimension can be calculated
# with <Ref Func="DimQA" Style="Text"/>, the arguments are the Gröbner basis
# <C>GB</C> and the number of symbols <C>6</C>. Since <Ref
# InfoClass="InfoGBNPTime" Style="Text"/> is set to 2, we get
# timing information from <Ref Func="DimQA" Style="Text"/>:

# <L>
dim := DimQA(GB,6);
# </L>
# </Section>
# <#/GAPDoc>
