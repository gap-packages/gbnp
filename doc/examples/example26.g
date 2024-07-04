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

### filename = "exampleColagen.g"
### authors Cohen & Gijsbers

### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES

# <#GAPDoc Label="ExampleColagen">
# <Section Label="ExampleColagen"><Heading>The cola gene puzzle</Heading>
# <P/>
# A prize question appearing in the January 2005 issue of
# the Dutch journal "Natuur en Techniek" asked for a DNA change
# of cows so that they could produce Cola instead of milk.
# A team of genetic manipulators
# has tools to perform the following
# five DNA string operations. (Here the strings before and
# after the equality sign can be interchanged at will.)
# <P/>
# operation 1: TCAT = T;
# <P/>
# operation 2: GAG =  AG;
# <P/>
# operation 3: CTC =  TC;
# <P/>
# operation 4: AGTA =  A;
# <P/>
# operation 5: TAT =  CT.
# <P/>
# The first question is to show how they can transform the
# milk gene TAGCTAGCTAGCT to the
# cola gene CTGACTGACT.
# <P/>
# A second question is to show that mad cow disease related
# retro virus CTGCTACTGACT can be avoided at all times.
# Can this be guaranteed?
# <P/>
# We answer these questions using the trace functions of the
# Gröbner basis package GBNP in Section <Ref Sect="tracefun"/>.
# <P/>
# First load the package and set the standard infolevel <Ref
# InfoClass="InfoGBNP" Style="Text"/> to 0 and the time infolevel <Ref
# Func="InfoGBNPTime" Style="Text"/> to 0 to minimize the printing of
# data regarding the computation (for more information about the info
# level, see Chapter <Ref Chap="Info"/>).

# <L>
LoadPackage("gbnp", false);
SetInfoLevel(InfoGBNP,0);
SetInfoLevel(InfoGBNPTime,0);
# </L>


# We introduce the free algebra <C>ALG</C>
# on the generators corresponding to the four letters in the DNA code
# and express the milk gene and cola gene as monomials in this algebra.

# <L>
ALG:=FreeAssociativeAlgebraWithOne(Rationals, "A", "C", "G", "T");;
g:=GeneratorsOfAlgebra(ALG);;
A:=g[2];;
C:=g[3];;
G:=g[4];;
T:=g[5];;

milk := T*A*G*C*T*A*G*C*T*A*G*C*T;;
cola := C*T*G*A*C*T*G*A*C*T;;
# </L>


# We next enter the set  <M>K</M> of binomials <M>x-y</M>
# corresponding to the five operations <M>x = y</M> listed above.
# We enter the binomials as members of <C>ALG</C> and
# let <C>KNP</C> be the corresponding set of NP polynomials.

# <L>
rule1 := T*C*A*T - T;;
rule2 :=  G*A*G -  A*G;;
rule3 :=  C*T*C - T*C;;
rule4 := A*G*T*A - A;;
rule5 := T*A*T -  C*T;;
K := [rule1,rule2,rule3,rule4,rule5];;
KNP := List(K,x-> GP2NP(x));;
# </L>

# We stipulate how the variables will be printed and print <C>KNP</C>.
# See  <Ref Func="PrintNPList" Style="Text"/>.

# <L>
GBNP.ConfigPrint("A","C","G","T");
PrintNPList(KNP);
# </L>


# Now calculate the usual Gröbner basis with <Ref Func="SGrobner"
# Style="Text"/>.

# <L>
GB := SGrobner(KNP);;
# </L>


# Compare milk and cola after taking their strong normal forms
# with respect to <C>GB</C>
# using
# <Ref Func="StrongNormalFormNP" Style="Text"/>.
# We observe that they have the same normal form and so there is
# a way to transform the milk gene into the cola gene.

# <L>
milkNP := GP2NP(milk);;
colaNP := GP2NP(cola);;
milkRed := NP2GP(StrongNormalFormNP(milkNP,GB),ALG);
colaRed := NP2GP(StrongNormalFormNP(colaNP,GB),ALG);
# </L>

# But this information does not yet show us how to perform the transformation.
# To this end we calculate the Gröbner basis with trace information,
# using the function
# <Ref Func="SGrobnerTrace" Style="Text"/>.

# <L>
GTrace := SGrobnerTrace(KNP);;
# </L>

# The full trace can be printed with <Ref Func="PrintTraceList" Style="Text"/>,
# but we only print the relations (and no trace) by invoking <Ref
# Func="PrintNPListTrace" Style="Text"/>.

# <L>
PrintNPListTrace(GTrace);
# </L>


# In order to display a proof that <M>milk-cola</M>
# belongs to the ideal
# we use <Ref Func="StrongNormalFormTraceDiff" Style="Text"/>,
# The result is a record, <C>p</C> say, containing
# <C>milk-cola</C> in the field <C>p.pol</C>
# (the normal form will be subtracted from the argument <C>milk-cola</C>
# to obtain <C>p.pol</C>, but the normal form is zero
# because the argument belongs to the ideal generated by <C>K</C>).
# The other field of the record <C>p</C> is
# <C>p.trace</C>, the traced polynomial, which is best displayed
# by use of <Ref Func="PrintTracePol" Style="Text"/>.

# <L>
p := StrongNormalFormTraceDiff(CleanNP(GP2NP(milk-cola)),GTrace);;
NP2GP(p.pol,ALG);
PrintTracePol(p);
# </L>

# In order to give a precise answer to the first question
# we need to work a little on <C>p.trace</C>. To do so, we
# introduce the following function, which creates the NP polynomial
# corresponding
# to the <C>i</C>-th term in the expression <C>p.trace</C>
# of <C>p.pol</C> as a linear combination of members of <C>KNP</C>.
# It is used to obtain the list <C>EvalList</C> of polynomials
# for all <C>i</C>.

# <L>
EvalTracePol := function(i,p,KNP)
  local x,pi;
  pi := p.trace[i];
  x := BimulNP(pi[1],KNP[pi[2]],pi[3]);
  return  [x[1],pi[4]*x[2]];
end;;

lev :=  Length(p.trace);;
EvalList := List([1..lev], y -> CleanNP(EvalTracePol(y,p,KNP)));;
# </L>

# In order to find the rewrite from the milk gene to the cola gene
# as required for an answer to the first question,
# we match leading terms recursively.

# <L>
UnusedIndices := Set([1..lev]);;
RunningTerm :=  milkNP[1][1];;
stepno := 0;;
NP2GP(milkNP,ALG);
while Length(UnusedIndices) > 0 do
  i := 0;
  notfnd := true;
  while i < lev and notfnd do
    i := i+1;
    if EvalList[i][1][1] = RunningTerm and i in UnusedIndices then
       notfnd := false;
       RemoveSet(UnusedIndices, i);
       RunningTerm :=  EvalList[i][1][2];
       stepno := stepno+1;
    elif EvalList[i][1][2] = RunningTerm and i in UnusedIndices then
       notfnd := false;
       RemoveSet(UnusedIndices, i);
       RunningTerm :=  EvalList[i][1][1];
       stepno := stepno+1;
    fi;
  od;
  if i = lev and notfnd = true then Print("error not fnd in"); fi;
  Print(" -(",stepno,")- ");
  PrintNP([[p.trace[i][1]],[1]]);
  Print("         K[",p.trace[i][2],"]\n        ");
  PrintNP([[p.trace[i][3]],[1]]);
  Print(" --> ");
  PrintNP([[EvalList[i][1][2]],[1]]);
od;;
NP2GP(colaNP,ALG);
# </L>


# And now the second question regarding the retro virus.

# <L>
retro := C*T*G*C*T*A*C*T*G*A*C*T;;
# </L>


# We compute the Strong Normal Form
# <Ref Func="StrongNormalFormNP" Style="Text"/>
# of <C>retro</C> with respect to <C>GB</C>.
# As it is <C>TGT</C>, distinct to <C>T</C>, the strong normal form of milk,
# there is no transformation from milk to retro.
# <L>
NP2GP(StrongNormalFormNP(CleanNP(GP2NP(retro)),GB), ALG);
# </L>


# Of course, here too we can verify the reduction,
# by computing <Ref Func="StrongNormalFormTraceDiff" Style="Text"/>
# with input the NP polynomial corresponding to <C>retro</C>
# and with respect to <C>K</C>;
# it is called <C>retroTrace</C>.
# The symbol <C>G</C> in expression like <C>G(2)</C>
# are not to be confused with the single symbols <C>G</C>
# representing the DNA element.

# <L>
retroTrace := StrongNormalFormTraceDiff(CleanNP(GP2NP(retro)),GTrace);;
PrintTracePol(retroTrace);
# </L>

# </Section>
# <#/GAPDoc>
