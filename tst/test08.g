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

### filename = "example08new.g"
### authors Cohen & Gijsbers

### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES

### Last change: May 24, 2007 amc towards nonspecialized coefficients


# <#GAPDoc Label="Example08">
# <Section Label="Example08"><Heading>The Birman-Murakami-Wenzl algebra of type A<M>_2</M></Heading>
# The trace variant (see sections <Ref Sect="trace"/> and <Ref Sect="tracefun"/>) will be used for
# a presentation of the Birman-Murakami-Wenzl algebra of type A<M>_2</M>
# by generators and relations
# in order to find a proof that the algebra has dimension 15.
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

# The variables are <M>g_1</M>, <M>g_2</M>,
# <M>e_1</M>, <M>e_2</M>, in this order.
# In order to have the results printed out with these symbols, we
# invoke
# <Ref Func="GBNP.ConfigPrint" Style="Text"/>
# <L>
GBNP.ConfigPrint("g1","g2","e1","e2");
# </L>


# Unlike Example <Ref Sect="Example07"/>,
# we work with a field of rational functions.
# <L>
ll := Indeterminate(Rationals,"l");
mm := Indeterminate(Rationals,"m");
F := Field(ll,mm);;
gens := GeneratorsOfField(F);
l := gens[1];;
m := gens[2];
F1 := One(F);;
Print("identity element of F: ",F1,"\n");
# </L>


# Now enter the relations. This will be done in NP form.

# <L>
#relations Theorem 1.1
k1 := [[[3],[1,1],[1],[]],[F1,-l/m,-l,l/m]];;
k2 := [[[4],[2,2],[2],[]],[F1,-l/m,-l,l/m]];;

#relations B1
#empty set here

#relations B2:
k3 := [[[1,2,1],[2,1,2]],[F1,-F1]];;

#relations R1
k4 := [[[1,3],[3]],[F1,-1/l]];;
k5 := [[[2,4],[4]],[F1,-1/l]];;

#relations R2:
k6 := [[[3,2,3],[3]],[F1,-l]];;
k7 := [[[4,1,4],[4]],[F1,-l]];;
k8 := [[[3,4,3],[3]],[F1,-F1]];;
k9 := [[[4,3,4],[4]],[F1,-F1]];;

KI := [k1,k2,k3,k4,k5,k6,k7,k8,k9];;
# </L>

# The input can be displayed with <Ref Func="PrintNPList" Style="Text"/>:

# <L>
PrintNPList(KI);
# </L>

# Now calculate the Gröbner basis with trace information, using the function
# <Ref Func="SGrobnerTrace" Style="Text"/>:

# <L>
GB := SGrobnerTrace(KI);;
# </L>

# The full trace can be printed with <Ref Func="PrintTraceList" Style="Text"/>,
# while printing only the relations (and no trace) can be invoked by <Ref
# Func="PrintNPListTrace" Style="Text"/>. Since the total trace is very long we
# do not call <C>PrintTraceList(GB)</C> here but only show two polynomial
# expressions from the Gröbner basis
# with <Ref Func="PrintTracePol" Style="Text"/>:

# <L>
PrintNPListTrace(GB);
PrintTracePol(GB[1]);
PrintTracePol(GB[10]);
# </L>

# In order to test whether the expression for <C>GB[10]</C> is as claimed
# we use <Ref Func="EvalTrace" Style="Text"/>,

# For each traced polynomial <C>x</C> in <C>GB</C>,
# we equate the evaluated expression
# <C>x.trace</C>,
# in which each occurrence of <C>G(i)</C> is replaced by <C>KI[i]</C>
# by  use of <Ref Func="EvalTrace" Style="Text"/>,
# with <C>x.pol</C>.

# <L>
ForAll(GB,x->EvalTrace(x,KI)=x.pol);
# </L>


# As a result the dimension of the quotient algebra can be calculated with <Ref
# Func="DimQA" Style="Text"/> and the quotient algebra itself with <Ref
# Func="BaseQA" Style="Text"/>.
# <L>
GB_pols:=List(GB,x->x.pol);;
PrintNPList(GB_pols);
DimQA(GB_pols,2);
B:=BaseQA(GB_pols,2,0);;
PrintNPList(B);
# </L>

# </Section>
# <#/GAPDoc>
