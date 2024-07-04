gap> START_TEST("GBNP test15");
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
gap> ### filename = "example15.g"
gap> ### author Krook
gap> 
gap> ### THIS IS A GAP PACKAGE GBNP
gap> ### FOR COMPUTING WITH NON-COMMUTATIVE POLYNOMIALS
gap> ### ADD-ON: STUDY GROWTH OF FACTOR ALGEBRA
gap> 
gap> 
gap> # <#GAPDoc Label="Example15">
gap> # <Section Label="Example15"><Heading>A quotient algebra with exponential growth</Heading>
gap> # This example demonstrates an instance in which the quotient
gap> # algebra is infinite dimensional and has exponential
gap> # growth. We start out with <C>KI</C><M>:=[y^4-y^2,x^2y-xy]</M> and obtain a
gap> # Gröbner basis with leading terms <M>[xxy,yyy]</M>. The quotient algebra will
gap> # thus have exponential growth since the
gap> # cycles <M>(xyyx)^n</M> and <M>(xy)^m</M>
gap> # intersect in the common subwords <M>xy</M> (and in <M>yx</M>). This is
gap> # explained in <Cite Key="Krook2003"/>. The function <Ref
gap> # Func="DetermineGrowthQA" Style="Text"/> is used for the computation.
gap> # <P/>
gap> # First load the package and set the standard infolevel <Ref
gap> # InfoClass="InfoGBNP" Style="Text"/> to 2 and the time infolevel <Ref
gap> # Func="InfoGBNPTime" Style="Text"/> to 1 (for more information about the info
gap> # level, see Chapter <Ref Chap="Info"/>).
gap> 
gap> # <L>
gap> LoadPackage("gbnp", false);
true
gap> SetInfoLevel(InfoGBNP,2);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> # </L>
gap> 
gap> # Let the variables be printed as <M>x</M> and <M>y</M> instead of <M>a</M> and <M>b</M> by means of
gap> # <Ref Func="GBNP.ConfigPrint" Style="Text"/>
gap> # <L>
gap> GBNP.ConfigPrint("x","y");
gap> # </L>
gap> 
gap> 
gap> # Then input the relations in NP format (see Section <Ref Sect="NP"/>). They
gap> # will be assigned to <C>KI</C>.
gap> 
gap> # <L>
gap> k1 := [[[2,2,2,2],[2,2]],[1,-1]];;
gap> k2 := [[[1,1,2],[1,2]],[1,-1]];;
gap> KI := [k1,k2];;
gap> PrintNPList(KI);
 y^4 - y^2
 x^2y - xy
gap> # </L>
gap> 
gap> # We calculate the Gröbner basis with the function <Ref Func="SGrobner"
gap> # Style="Text"/> and print it with <Ref Func="PrintNPList" Style="Text"/>.
gap> 
gap> # <L>
gap> GB := SGrobner(KI);;
#I  number of entered polynomials is 2
#I  number of polynomials after reduction is 2
#I  End of phase I
#I  End of phase II
#I  List of todo lengths is [ 0 ]
#I  End of phase III
#I  G: Cleaning finished, 0 polynomials reduced
#I  End of phase IV
gap> PrintNPList(GB);
 x^2y - xy
 y^4 - y^2
gap> # </L>
gap> 
gap> # Next we check the dimensionality of the quotient algebra
gap> # with the function <Ref
gap> # Func="FinCheckQA" Style="Text"/> or the function <Ref Func="DetermineGrowthQA"
gap> # Style="Text"/>. These functions expect as first argument a list <A>F</A>
gap> # of leading terms of a Gröbner basis,
gap> # which can be calculated with the function <Ref
gap> # Func="LMonsNP" Style="Text"/> and as second argument the number of symbols
gap> # (here equal to 2). The function <Ref Func="DetermineGrowthQA" Style="Text"/>
gap> # will not only report whether a Gröbner basis is finite, but will also provide
gap> # information about its growth.
gap> 
gap> # <L>
gap> L:=LMonsNP(GB);
[ [ 1, 1, 2 ], [ 2, 2, 2, 2 ] ]
gap> fd:=FinCheckQA(L,2);
false
gap> fd:=DetermineGrowthQA(L,2,false);
"exponential growth"
gap> # </L>
gap> 
gap> # Although the quotient algebra is infinite dimensional,
gap> # multiplication of two elements can be carried out by
gap> # <Ref Func="MulQA" Style="Text"/>.
gap> # We print three positive powers of <M>x+y</M>.
gap> 
gap> # <L>
gap> w := [[[1],[2]],[1,1]];;
gap> hlp := [[[]],[1]];;
gap> for i in [3..5] do
>   hlp := MulQA(hlp, w, GB);
>   Print("\n (x+y)^",i," = \n");
>   PrintNP(hlp);
> od;

 (x+y)^3 =
 y + x

 (x+y)^4 =
 y^2 + yx + xy + x^2

 (x+y)^5 =
 y^3 + y^2x + yxy + yx^2 + xy^2 + xyx + x^3 + xy
gap> # </L>
gap> 
gap> 
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> STOP_TEST("test15.g",10000);
