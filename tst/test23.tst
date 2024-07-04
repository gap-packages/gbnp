gap> START_TEST("GBNP test23");
gap> ######################### BEGIN COPYRIGHT MESSAGE #########################
gap> # GBNP - computing Gröbner bases of noncommutative polynomials
gap> # Copyright 2001-2010 by Arjeh M. Cohen, Dié A.H. Gijsbers, Jan Willem
gap> # Knopper, Chris Krook. Address: Discrete Algebra and Geometry (DAM) group
gap> # at the Department of Mathematics and Computer Science of Eindhoven
gap> # University of Technology.
gap> #
gap> # For acknowledgements see the manual. The manual can be found in several
gap> # formats in the doc subdirectory of the GBNP distribution. The
gap> # acknowledgements formatted as text can be found in the file chap0.txt.
gap> #
gap> # GBNP is free software; you can redistribute it and/or modify it under
gap> # the terms of the Lesser GNU General Public License as published by the
gap> # Free Software Foundation (FSF); either version 2.1 of the License, or
gap> # (at your option) any later version. For details, see the file 'LGPL' in
gap> # the doc subdirectory of the GBNP distribution or see the FSF's own site:
gap> # https://www.gnu.org/licenses/lgpl.html
gap> ########################## END COPYRIGHT MESSAGE ##########################
gap> 
gap> ### filename = "example23.g"
gap> ### author Knopper
gap> 
gap> ### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES
gap> 
gap> # <#GAPDoc Label="Example23">
gap> # <Section Label="Example23"><Heading>Generalized Temperley-Lieb algebras</Heading>
gap> # This example shows how the dimension of a Generalized Temperley-Lieb
gap> # Algebra of type A, D, or E can be calculated. For <M>\textrm{A}_{n-1}</M>
gap> # this is the usual Temperley-Lieb Algebra on <M>n</M> strands with dimension
gap> # <M>\textrm{dim TL}(A_{n-1})={{2n \choose n}}/{(n+1)}</M>. For more
gap> # information see <Cite Key="Graham1995"/>.
gap> # <P/>
gap> # First load the package and set the standard infolevel <Ref
gap> # InfoClass="InfoGBNP" Style="Text"/> to 0 and the time infolevel <Ref
gap> # Func="InfoGBNPTime" Style="Text"/> to 1 (for more information about timing;
gap> # see Chapter <Ref Chap="Info"/>).
gap> 
gap> # <L>
gap> LoadPackage("gbnp", false);
true
gap> SetInfoLevel(InfoGBNP,0);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> # </L>
gap> 
gap> # The relations are generated automatically from the Coxeter diagram.
gap> # This example
gap> # can be easily adapted by specifying the number of points and the set of edges
gap> # describing another Coxeter diagram. First enter the number of points,
gap> # <C>numpoints</C>.
gap> 
gap> # <L>
gap> numpoints:=8;
8
gap> # </L>
gap> 
gap> # Now define some edges describing the diagrams of <M>\textrm{E}_n</M>,
gap> # (these can be easily extended). In this example the dimension of the
gap> # Generalized Temperley-Lieb algebra of type <M>\textrm{E}_8</M> will be
gap> # calculated. For <M>\textrm{A}_{1\ldots 10}</M> the command
gap> # <P/>
gap> # <C>edges:=[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10]];</C>
gap> # <P/>
gap> # can be used. For <M>\textrm{D}_{1\ldots 10}</M> the command
gap> # <P/>
gap> # <C>edges:=[[1,3],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10]];</C> can
gap> # <P/>
gap> # be used.
gap> 
gap> # <L>
gap> edges:=[[1,3],[2,4],[3,4],[4,5],[5,6],[6,7],[7,8]]; # for E6..8
[ [ 1, 3 ], [ 2, 4 ], [ 3, 4 ], [ 4, 5 ], [ 5, 6 ], [ 6, 7 ], [ 7, 8 ] ]
gap> # </L>
gap> 
gap> # Now enter the relations as GAP polynomials. First a free associative algebra
gap> # with identity element is created over the Rationals (see also <Ref BookName="Reference"
gap> # Label="FreeAssociativeAlgebraWithOne"/>). For convenience the generators are
gap> # stored in <C>gens</C>.
gap> 
gap> # <L>
gap> A:=FreeAssociativeAlgebraWithOne(Rationals,numpoints,"e");;
gap> e := GeneratorsOfAlgebraWithOne(A);
[ (1)*e.1, (1)*e.2, (1)*e.3, (1)*e.4, (1)*e.5, (1)*e.6, (1)*e.7, (1)*e.8 ]
gap> # </L>
gap> 
gap> # It is possible to print symbols like they are printed in the algebra <C>A</C>
gap> # with the function <Ref Func="GBNP.ConfigPrint" Style="Text"/>:
gap> 
gap> # <L>
gap> GBNP.ConfigPrint(A);
gap> # </L>
gap> 
gap> # Now the relations are generated automatically. For this we need to make sure
gap> # the edges are sorted and converted to a set.
gap> 
gap> # <L>
gap> edges:=Set(edges, x->SortedList(x));
[ [ 1, 3 ], [ 2, 4 ], [ 3, 4 ], [ 4, 5 ], [ 5, 6 ], [ 6, 7 ], [ 7, 8 ] ]
gap> # </L>
gap> 
gap> # Now the relations can be generated. The relations are <M>e_i*e_i=e_i</M>, for
gap> # all <M>i</M> and <M>e_i*e_j*e_i=e_i</M> for all <M>i</M>,<M>j</M> that are
gap> # connected in the Coxeter diagram and <M>e_i*e_j=e_j*e_i</M> for all <M>i</M>,
gap> # <M>j</M> that are not connected in the Coxeter diagram.
gap> 
gap> # <L>
gap> rels:=[];;
gap> for i in [1..numpoints] do
>   for j in [1..numpoints] do
>     if (i=j) then
>       # if i=j then add e.i*e.i=e.i
>       Add(rels, e[i]*e[i]-e[i]);
>     elif ([i,j] in edges) or ([j,i] in edges) then
>       # if {i,j} is an edge then add e.i*e.j*e.i=e.i
>       Add(rels, e[i]*e[j]*e[i]- e[i]);
>     else
>       # if {i,j} is not an edge then add e.i*e.j=e.j*e.i
>       # (note: this causes double rules, but that's ok)
>       Add(rels, e[i]*e[j]- e[j]*e[i]);
>     fi;
>   od;
> od;
gap> # </L>
gap> 
gap> # Then the relations are converted into NP format (see <Ref Sect="NP"/>) after
gap> # which the function <Ref Func="SGrobner" Style="Text"/> is called to
gap> # calculate a Gröbner basis.
gap> 
gap> # <L>
gap> relsNP:=GP2NPList(rels);;
gap> GB:=SGrobner(relsNP);;
gap> # </L>
gap> 
gap> # It is now possible to calculate the dimension of the quotient algebra
gap> # with the function <Ref Func="DimQA" Style="Text"/>. This function has as
gap> # arguments the Gröbner basis <C>GB</C> and the number of generators of the
gap> # algebra (here this is <C>numpoints</C>). To get the full basis the function
gap> # <Ref Func="BaseQA" Style="Text"/> can be used.
gap> 
gap> # <L>
gap> DimQA(GB,numpoints);
10846
gap> # </L>
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> STOP_TEST("test23.g",10000);
