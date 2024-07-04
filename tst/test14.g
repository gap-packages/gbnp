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

### filename = "example14.g"
### authors Cohen & Gijsbers & Krook
### This example was added by Chris Krook.

### THIS IS A GAP PACKAGE GBNP
### FOR COMPUTING WITH NON-COMMUTATIVE POLYNOMIALS
### ADD-ON: STUDY GROWTH OF FACTOR ALGEBRA


# <#GAPDoc Label="Example14">
# <Section Label="Example14"><Heading>Preprocessing for Weyl group computations</Heading>
# This example extends Example <Ref Sect="Example03"/> with the
# following action: after the Gröbner basis computation, we first check if the
# quotient algebra is finite dimensional or infinite dimensional before we
# possibly try to compute that dimension. Preprocessing of the set of leading
# terms of the Gröbner basis is used to speed up the check.
# The functions <Ref Func="PreprocessAnalysisQA" Style="Text"/>
# and <Ref Func="FinCheckQA" Style="Text"/> are used for the computations. Even
# without preprocessing this already goes fast. Still, preprocessing can speed
# up more involved cases. For instance, after adapting this example to run
# for E7,  we found that
# preprocessing speeds up the computation from 400 secs to about 40 secs. (Be
# aware that Gröbner basis computation will take a while for E7.)
# <P/>
# More information about the preprocessing can be found in the preprint <Q>The
# dimensionality of quotient algebras</Q> <Cite Key="Krook2003"/> which is part
# of the documentation.
# <P/>
# Note: there is no information on the amount of preprocessing which is
# optimal, but in general for big examples, even full preprocessing is better
# than using no preprocessing at all.
# <P/>
# Note: Example <Ref Sect="Example13"/> also determines if the
# quotient algebra appearing
# here is finite or infinite dimensional but does not use
# preprocessing.
# <P/>
# First load the package and set the standard infolevel <Ref
# InfoClass="InfoGBNP" Style="Text"/> to 0 and the time infolevel <Ref
# Func="InfoGBNPTime" Style="Text"/> to 2 (for more information about the info
# level, see Chapter <Ref Chap="Info"/>).

# <L>
LoadPackage("gbnp", false);
SetInfoLevel(InfoGBNP,0);
SetInfoLevel(InfoGBNPTime,0);
# </L>

# Then input the relations in NP format (see Section <Ref Sect="NP"/>). They
# will be assigned to <C>KI</C>.

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

# Check the dimensionality of the quotient algebra.
# We will check whether it is finite dimensional or infinite
# dimensional. In case of finite dimensionality we can compute this dimension.
# <P/>
# The function <Ref Func="FinCheckQA" Style="Text"/>, which is used to check
# finite dimensionality has as first argument the list of
# leading monomials of a
# Gröbner basis and as second argument the number of symbols. The monomials
# can be calculated with <Ref Func="LMonsNP" Style="Text"/>. They then will be
# preprocessed using 4 recursions. If you want full preprocessing, use 0
# instead of 4 as a parameter for the number of recursions.

# <L>
L:=LMonsNP(GB);;
L:=PreprocessAnalysisQA(L,6,4);;
fd:=FinCheckQA(L,6);
# </L>

# If a quotient algebra is finite dimensional, the dimension can be calculated
# with <Ref Func="DimQA" Style="Text"/>, the arguments are the Gröbner basis
# <C>GB</C> and the number of symbols <C>6</C>. Since <Ref
# InfoClass="InfoGBNPTime" Style="Text"/> is set to 2, we get timing
# information from <Ref Func="DimQA" Style="Text"/>:

# <L>
dim := DimQA(GB,6);
# </L>
# </Section>
# <#/GAPDoc>
