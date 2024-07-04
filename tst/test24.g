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

### filename = "example24.g"
### author amc
### amc last edited 31 May 2007

# <#GAPDoc Label="Example24">
# <Section Label="Example24"><Heading>Serre's exercise</Heading>

# <L>
LoadPackage("gbnp", false);
SetInfoLevel(InfoGBNP,1);
SetInfoLevel(InfoGBNPTime,0);
# </L>

# In Serre's book <Cite Key="MR1954121"/> the following exercise can be found:
# Prove  that the group
# <M> \left\langle \{a,b,c\}\mid \{ bab^{-1}a^{-2}, cbc^{-1}b^{-2}, aca^{-1}c^{-2}\}\right\rangle</M>
# is the trivial group.
# Here we solve the exercise by running the trace variant of the
# Gröbner basis function with input the set of equations
# <M>ba - a^2 b, cb - b^2c, ac - c^2a</M>
# together with relations forcing that <M>a,b,c</M> are invertible
# with inverse <M>A,B,C</M>.

# <L>
KI := [ [[[2,1],[1,1,2]],[1,-1]],
        [[[3,2],[2,2,3]],[1,-1]],
        [[[1,3],[3,3,1]],[1,-1]],
        [[[1,4], []],[1,-1]],
        [[[4,1], []],[1,-1]],
        [[[2,5], []],[1,-1]],
        [[[5,2], []],[1,-1]],
        [[[3,6], []],[1,-1]],
        [[[6,3], []],[1,-1]],
      ];;
PrintNPList(KI);
# </L>

# We use <Ref Func="SGrobnerTrace" Style="Text"/>,
# the trace variant of the Gröbner basis computation,

# <L>
GB := SGrobnerTrace(KI);;
# </L>

# The dimension of the quotient algebra is 1, showing that the group algebra
# is 1-dimensional. This implies that the group with the above presentation
# is trivial.
# <L>
GBpols := List([1..Length(GB)], x -> GB[x].pol);;
PrintNPList(GBpols);
DimQA(GBpols,6);
# </L>

# Since the output is large and might spoil the exercise,
# we confine ourselves to
# the printing first polynomial <C>GB[1]</C> and the length of its trace.
# As the trace polynomial expresses
# <C>GB[1]</C>, which is equal to <M>a-1</M>, as a combination of the binomials
# in <C>KI</C>, it gives a proof that <M>a</M> can be rewritten within the
# group to the trivial element. It is easy to derive from this that
# <M>b</M> and <M>c</M> are also trivial in the group.
# This justifies the restriction to <C>GB[1]</C>.

# <L>
PrintNP(GB[1].pol);
Length(GB[1].trace);
# </L>

# </Section>
# <#/GAPDoc>

