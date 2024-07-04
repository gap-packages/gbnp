gap> START_TEST("GBNP test01");
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
gap> ### filename = "example01.g"
gap> ### authors Cohen & Gijsbers
gap> 
gap> ### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES
gap> 
gap> ### Last change: August 22 2001.
gap> ### amc
gap> 
gap> # <#GAPDoc Label="Example01">
gap> # <Section Label="Example01">
gap> # <Heading>A simple commutative Gröbner basis computation</Heading>
gap> # In this commutative example the relations are <M>x^2y-1</M>
gap> # and <M>xy^2-1</M>;
gap> # we add <M>xy-yx</M> to enforce that
gap> # <M>x</M> and <M>y</M> commute.
gap> # The answer should be <M>\{x^3-1, x-y, xy-yx\}</M>,
gap> # as the reduction ordering is total degree first
gap> # and then lexicographic with <M> x </M> smaller than
gap> # <M>y</M>.
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
gap> # Then input the relations in NP format (see Section <Ref Sect="NP"/>).
gap> # They will be put in the list <C>Lnp</C>.
gap> 
gap> # <L>
gap> Lnp := [ [[[1,2],[2,1]],[1,-1]]   ];
[ [ [ [ 1, 2 ], [ 2, 1 ] ], [ 1, -1 ] ] ]
gap> x2y := [[[1,1,2],[]],[1,-1]];
[ [ [ 1, 1, 2 ], [  ] ], [ 1, -1 ] ]
gap>     AddSet(Lnp,x2y);
gap> xy2 := [[[1,2,2],[]],[1,-1]];
[ [ [ 1, 2, 2 ], [  ] ], [ 1, -1 ] ]
gap>     AddSet(Lnp,xy2);
gap> # </L>
gap> 
gap> # The relations can be exhibited with <Ref Func="PrintNPList" Style="Text"/>:
gap> 
gap> # <L>
gap> PrintNPList(Lnp);
 a^2b - 1
 ab - ba
 ab^2 - 1
gap> # </L>
gap> 
gap> # Let the variables be printed as <M>x</M> and <M>y</M> instead of <M>a</M> and <M>b</M> by means of
gap> # <Ref Func="GBNP.ConfigPrint" Style="Text"/>
gap> # <L>
gap> GBNP.ConfigPrint("x","y");
gap> # </L>
gap> 
gap> 
gap> 
gap> 
gap> # The Gröbner basis can now be calculated with
gap> # <Ref Func="SGrobner" Style="Text"/>:
gap> 
gap> # <L>
gap> GB := SGrobner(Lnp);
#I  number of entered polynomials is 3
#I  number of polynomials after reduction is 3
#I  End of phase I
#I  End of phase II
#I  length of G =1
#I  length of todo is 1
#I  length of G =2
#I  length of todo is 0
#I  List of todo lengths is [ 1, 1, 0 ]
#I  End of phase III
#I  G: Cleaning finished, 0 polynomials reduced
#I  End of phase IV
[ [ [ [ 2 ], [ 1 ] ], [ 1, -1 ] ], [ [ [ 1, 1, 1 ], [  ] ], [ 1, -1 ] ] ]
gap> # </L>
gap> 
gap> # When printed, it looks like:
gap> 
gap> # <L>
gap> PrintNPList(GB);
 y - x
 x^3 - 1
gap> # </L>
gap> 
gap> # The dimension of the quotient algebra can be calculated with
gap> # <Ref Func="DimQA" Style="Text"/>. The arguments are the Gröbner basis
gap> # <C>GB</C> and the number of variables is <C>2</C>:
gap> 
gap> # <L>
gap> DimQA(GB,2);
3
gap> # </L>
gap> 
gap> # A basis of this quotient algebra can be calculated with <Ref Func="BaseQA"
gap> # Style="Text"/>. The arguments are a Gröbner basis <C>GB</C>, the
gap> # number of variables <A>t</A> (<M>=2</M>) and a variable <A>maxno</A> for
gap> # returning partial quotient algebras (0 means full basis). The calculated
gap> # basis will be printed as well.
gap> 
gap> # <L>
gap> B:=BaseQA(GB,2,0);;
gap> PrintNPList(B);
 1
 x
 x^2
gap> # </L>
gap> 
gap> # The strong normal form of the element <M>xyxyxyx</M> can be found by use of
gap> # <Ref Func="StrongNormalFormNP" Style="Text"/>.
gap> # The arguments are this element and the Gröbner basis <C>GB</C>.
gap> 
gap> # <L>
gap> f:=[[[1,2,1,2,1,2,1]],[1]];;
gap> PrintNP(f);
 xyxyxyx
gap> p:=StrongNormalFormNP(f,GB);;
gap> PrintNP(p);
 x
gap> # </L>
gap> 
gap> 
gap> 
gap> 
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> 
gap> STOP_TEST("test01.g",10000);
