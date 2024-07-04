gap> START_TEST("GBNP test09");
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
gap> ### filename = "example09.g"
gap> ### authors Cohen & Gijsbers
gap> ### vs 0.8.1
gap> 
gap> ### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES
gap> 
gap> ### Last change: amc May 24 2007.
gap> ### dahg
gap> 
gap> # <#GAPDoc Label="Example09">
gap> # <Section Label="Example09"><Heading>Tracing an example by Mora</Heading>
gap> # This example of a non-commutative Gröbner basis computation
gap> # is from page 18 of
gap> # <Q>An introduction to commutative and non-commutative Gröbner Bases</Q>, by
gap> # Teo Mora <Cite Key="TCS::Mora1994:131"/>.
gap> # The traced version of the algorithm will be used.
gap> # The input is <M>\{xyx-y,yxy-y\}</M>.
gap> # The answer should be <M>\{yy-xy,yx-xy,xxy-y\}</M>.
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
gap> # Next we input the relations in NP format (see Section <Ref Sect="NP"/>). They
gap> # will be assigned to <C>KI</C>.
gap> 
gap> # <L>
gap> xyx := [[[1,2,1],[2]],[1,-1]];;
gap> yxy := [[[2,1,2],[2]],[1,-1]];;
gap> KI:=[xyx,yxy];;
gap> # </L>
gap> 
gap> # The relations can be shown with <Ref Func="PrintNPList" Style="Text"/>:
gap> 
gap> # <L>
gap> PrintNPList(KI);
 xyx - y
 yxy - y
gap> # </L>
gap> 
gap> # The Gröbner basis with trace can now be calculated with
gap> # <Ref Func="SGrobnerTrace" Style="Text"/>:
gap> 
gap> # <L>
gap> GB := SGrobnerTrace(KI);
#I  number of entered polynomials is 2
#I  number of polynomials after reduction is 2
#I  End of phase I
#I  End of phase II
#I  j =2
#I  Current number of elements in todo is 1
#I  j =3
#I  Current number of elements in todo is 0
#I  List of todo lengths is [ 2, 1, 0 ]
#I  End of phase III
#I  End of phase IV
[ rec( pol := [ [ [ 2, 1 ], [ 1, 2 ] ], [ 1, -1 ] ],
      trace := [ [ [  ], 1, [ 2 ], -1 ], [ [ 2 ], 1, [  ], 1 ],
          [ [ 1 ], 2, [  ], 1 ], [ [  ], 2, [ 1 ], -1 ] ] ),
  rec( pol := [ [ [ 2, 2 ], [ 1, 2 ] ], [ 1, -1 ] ],
      trace := [ [ [ 2 ], 1, [  ], -1 ], [ [  ], 1, [ 2 ], -1 ],
          [ [ 2 ], 1, [  ], 1 ], [ [  ], 2, [ 1 ], 1 ], [ [ 1 ], 2, [  ], 1 ],
          [ [  ], 2, [ 1 ], -1 ] ] ),
  rec( pol := [ [ [ 1, 1, 2 ], [ 2 ] ], [ 1, -1 ] ],
      trace := [ [ [  ], 1, [  ], 1 ], [ [ 1 ], 1, [ 2 ], 1 ],
          [ [ 1, 2 ], 1, [  ], -1 ], [ [ 1, 1 ], 2, [  ], -1 ],
          [ [ 1 ], 2, [ 1 ], 1 ] ] ) ]
gap> # </L>
gap> 
gap> # The Gröbner basis can be printed with
gap> # <Ref Func="PrintNPListTrace" Style="Text"/>:
gap> 
gap> # <L>
gap> PrintNPListTrace(GB);
 yx - xy
 y^2 - xy
 x^2y - y
gap> # </L>
gap> 
gap> # The trace of the Gröbner basis can be printed with
gap> # <Ref Func="PrintTraceList" Style="Text"/>:
gap> 
gap> # <L>
gap> PrintTraceList(GB);
- G(1)y + yG(1) - G(2)x + xG(2)

- G(1)y + xG(2)

 G(1) + xG(1)y - xyG(1) + xG(2)x - x^2G(2)
gap> # </L>
gap> 
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> STOP_TEST("test09.g",10000);
