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

### filename = "example09.g"
### authors Cohen & Gijsbers
### vs 0.8.1

### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES

### Last change: amc May 24 2007.
### dahg

# <#GAPDoc Label="Example09">
# <Section Label="Example09"><Heading>Tracing an example by Mora</Heading>
# This example of a non-commutative Gröbner basis computation
# is from page 18 of
# <Q>An introduction to commutative and non-commutative Gröbner Bases</Q>, by
# Teo Mora <Cite Key="TCS::Mora1994:131"/>.
# The traced version of the algorithm will be used.
# The input is <M>\{xyx-y,yxy-y\}</M>.
# The answer should be <M>\{yy-xy,yx-xy,xxy-y\}</M>.
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

# Let the variables be printed as <M>x</M> and <M>y</M> instead of <M>a</M> and <M>b</M> by means of
# <Ref Func="GBNP.ConfigPrint" Style="Text"/>
# <L>
GBNP.ConfigPrint("x","y");
# </L>

# Next we input the relations in NP format (see Section <Ref Sect="NP"/>). They
# will be assigned to <C>KI</C>.

# <L>
xyx := [[[1,2,1],[2]],[1,-1]];;
yxy := [[[2,1,2],[2]],[1,-1]];;
KI:=[xyx,yxy];;
# </L>

# The relations can be shown with <Ref Func="PrintNPList" Style="Text"/>:

# <L>
PrintNPList(KI);
# </L>

# The Gröbner basis with trace can now be calculated with
# <Ref Func="SGrobnerTrace" Style="Text"/>:

# <L>
GB := SGrobnerTrace(KI);
# </L>

# The Gröbner basis can be printed with
# <Ref Func="PrintNPListTrace" Style="Text"/>:

# <L>
PrintNPListTrace(GB);
# </L>

# The trace of the Gröbner basis can be printed with
# <Ref Func="PrintTraceList" Style="Text"/>:

# <L>
PrintTraceList(GB);
# </L>

# </Section>
# <#/GAPDoc>
