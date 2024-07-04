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

### filename = "example23.g"
### author Knopper

### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES

# <#GAPDoc Label="Example23">
# <Section Label="Example23"><Heading>Generalized Temperley-Lieb algebras</Heading>
# This example shows how the dimension of a Generalized Temperley-Lieb
# Algebra of type A, D, or E can be calculated. For <M>\textrm{A}_{n-1}</M>
# this is the usual Temperley-Lieb Algebra on <M>n</M> strands with dimension
# <M>\textrm{dim TL}(A_{n-1})={{2n \choose n}}/{(n+1)}</M>. For more
# information see <Cite Key="Graham1995"/>.
# <P/>
# First load the package and set the standard infolevel <Ref
# InfoClass="InfoGBNP" Style="Text"/> to 0 and the time infolevel <Ref
# Func="InfoGBNPTime" Style="Text"/> to 1 (for more information about timing;
# see Chapter <Ref Chap="Info"/>).

# <L>
LoadPackage("gbnp", false);
SetInfoLevel(InfoGBNP,0);
SetInfoLevel(InfoGBNPTime,0);
# </L>

# The relations are generated automatically from the Coxeter diagram.
# This example
# can be easily adapted by specifying the number of points and the set of edges
# describing another Coxeter diagram. First enter the number of points,
# <C>numpoints</C>.

# <L>
numpoints:=8;
# </L>

# Now define some edges describing the diagrams of <M>\textrm{E}_n</M>,
# (these can be easily extended). In this example the dimension of the
# Generalized Temperley-Lieb algebra of type <M>\textrm{E}_8</M> will be
# calculated. For <M>\textrm{A}_{1\ldots 10}</M> the command
# <P/>
# <C>edges:=[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10]];</C>
# <P/>
# can be used. For <M>\textrm{D}_{1\ldots 10}</M> the command
# <P/>
# <C>edges:=[[1,3],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10]];</C> can
# <P/>
# be used.

# <L>
edges:=[[1,3],[2,4],[3,4],[4,5],[5,6],[6,7],[7,8]]; # for E6..8
# </L>

# Now enter the relations as GAP polynomials. First a free associative algebra
# with identity element is created over the Rationals (see also <Ref BookName="Reference"
# Label="FreeAssociativeAlgebraWithOne"/>). For convenience the generators are
# stored in <C>gens</C>.

# <L>
A:=FreeAssociativeAlgebraWithOne(Rationals,numpoints,"e");;
e := GeneratorsOfAlgebraWithOne(A);
# </L>

# It is possible to print symbols like they are printed in the algebra <C>A</C>
# with the function <Ref Func="GBNP.ConfigPrint" Style="Text"/>:

# <L>
GBNP.ConfigPrint(A);
# </L>

# Now the relations are generated automatically. For this we need to make sure
# the edges are sorted and converted to a set.

# <L>
edges:=Set(edges, x->SortedList(x));
# </L>

# Now the relations can be generated. The relations are <M>e_i*e_i=e_i</M>, for
# all <M>i</M> and <M>e_i*e_j*e_i=e_i</M> for all <M>i</M>,<M>j</M> that are
# connected in the Coxeter diagram and <M>e_i*e_j=e_j*e_i</M> for all <M>i</M>,
# <M>j</M> that are not connected in the Coxeter diagram.

# <L>
rels:=[];;
for i in [1..numpoints] do
  for j in [1..numpoints] do
    if (i=j) then
      # if i=j then add e.i*e.i=e.i
      Add(rels, e[i]*e[i]-e[i]);
    elif ([i,j] in edges) or ([j,i] in edges) then
      # if {i,j} is an edge then add e.i*e.j*e.i=e.i
      Add(rels, e[i]*e[j]*e[i]- e[i]);
    else
      # if {i,j} is not an edge then add e.i*e.j=e.j*e.i
      # (note: this causes double rules, but that's ok)
      Add(rels, e[i]*e[j]- e[j]*e[i]);
    fi;
  od;
od;
# </L>

# Then the relations are converted into NP format (see <Ref Sect="NP"/>) after
# which the function <Ref Func="SGrobner" Style="Text"/> is called to
# calculate a Gröbner basis.

# <L>
relsNP:=GP2NPList(rels);;
GB:=SGrobner(relsNP);;
# </L>

# It is now possible to calculate the dimension of the quotient algebra
# with the function <Ref Func="DimQA" Style="Text"/>. This function has as
# arguments the Gröbner basis <C>GB</C> and the number of generators of the
# algebra (here this is <C>numpoints</C>). To get the full basis the function
# <Ref Func="BaseQA" Style="Text"/> can be used.

# <L>
DimQA(GB,numpoints);
# </L>
# </Section>
# <#/GAPDoc>
