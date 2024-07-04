gap> START_TEST("GBNP test25");
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
gap> ### filename = "example25.g"
gap> ### author amc
gap> ### amc last edited 1 June 2007
gap> 
gap> # <#GAPDoc Label="Example25">
gap> # <Section Label="Example25"><Heading>Baur and Draisma's transformations</Heading>
gap> 
gap> # <L>
gap> LoadPackage("gbnp", false);
true
gap> SetInfoLevel(InfoGBNP,0);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> # </L>
gap> 
gap> # The paper <Cite Key="MR2090062"/> by Baur and Draisma
gap> # uses the computation of a quotient
gap> # algebra of dimension 37, which we
gap> # repeat here.
gap> # The set of equations, after specialisation of the scalars to 1,
gap> # is as follows.
gap> 
gap> # <L>
gap> KI := [ [[[2,2]],[1]],
>         [[[1,1]],[1]],
>         [[[3,3]],[1]],
>         [[[1,2,1],[1]],[1,-1]],
>         [[[2,1,2],[2]],[1,-1]],
>         [[[3,2,3],[3]],[1,-1]],
>         [[[2,3,2],[2]],[1,-1]],
>         [[[1,3,1],[1]],[1,-1]],
>         [[[3,1,3],[3]],[1,-1]],
>         [[[1,2,3,1,2,3,1],[1,3,2,1,3,2,1],[1]],[1,1,-1]],
>         [[[3,1,2,3,1,2,3],[3,2,1,3,2,1,3],[3]],[1,1,-1]],
>         [[[2,3,1,2,3,1,2],[2,1,3,2,1,3,2],[2]],[1,1,-1]],
>       ];;
gap> PrintNPList(KI);
 b^2
 a^2
 c^2
 aba - a
 bab - b
 cbc - c
 bcb - b
 aca - a
 cac - c
 abcabca + acbacba - a
 cabcabc + cbacbac - c
 bcabcab + bacbacb - b
gap> # </L>
gap> 
gap> # We carry out a traced Gröbner basis computation by use of
gap> # <Ref Func="SGrobnerTrace" Style="Text"/>,
gap> # and form the usual Gröbner basis by extracting the polynomials
gap> # from the traced polynomials using the field indicator <C>.pol</C>.
gap> # <L>
gap> GBT := SGrobnerTrace(KI);;
gap> GB := List([1..Length(GBT)], i -> GBT[i].pol);;
gap> # </L>
gap> 
gap> # The dimension of the quotient algebra is computable with
gap> # <Ref Func="DimQA" Style="Text"/>.
gap> # <L>
gap> DimQA(GB,3);
37
gap> # </L>
gap> 
gap> # In order to express the
gap> # last GB element, viz.
gap> # <L>
gap> PrintNP(GB[Length(GB)]);
 cabcabca + cbacba - ca
gap> # </L>
gap> # as a combination of elements of <C>KI</C>,
gap> # we use <Ref Func="PrintTracePol" Style="Text"/>:
gap> # <L>
gap> PrintTracePol(GBT[Length(GBT)]);
- G(9)bacba + cG(10)
gap> # </L>
gap> 
gap> 
gap> # We compute matrices for left multiplication by generators
gap> # using <Ref Func="MatricesQA" Style="Text"/>
gap> # and determine the minimal polynomial of the sum of the three matrices.
gap> 
gap> # <L>
gap> # add the next command in case other tests have changed the alphabet:
gap> GBNP.ConfigPrint("x");
gap> B := BaseQA(GB,3,0);;
gap> M := MatricesQA(3,B,GB);;
gap> f := MinimalPolynomial(Rationals,M[1]+M[2]+M[3]);
x_1^7-6*x_1^5+9*x_1^3-3*x_1
gap> Factors(f);
[ x_1, x_1^6-6*x_1^4+9*x_1^2-3 ]
gap> # </L>
gap> 
gap> # It turns out that there are three non-zero numbers <M>u,v,w</M>
gap> # such that the eigenvalues of the sum are <M>0,u,v,w,-u,-v,-w</M>.
gap> # This is the information used in  <Cite Key="MR2090062"/>.
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> STOP_TEST("test25.g",10000);
