gap> START_TEST("GBNP test08");
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
gap> ### filename = "example08new.g"
gap> ### authors Cohen & Gijsbers
gap> 
gap> ### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES
gap> 
gap> ### Last change: May 24, 2007 amc towards nonspecialized coefficients
gap> 
gap> 
gap> # <#GAPDoc Label="Example08">
gap> # <Section Label="Example08"><Heading>The Birman-Murakami-Wenzl algebra of type A<M>_2</M></Heading>
gap> # The trace variant (see sections <Ref Sect="trace"/> and <Ref Sect="tracefun"/>) will be used for
gap> # a presentation of the Birman-Murakami-Wenzl algebra of type A<M>_2</M>
gap> # by generators and relations
gap> # in order to find a proof that the algebra has dimension 15.
gap> # <P/>
gap> # First load the package and set the standard infolevel <Ref
gap> # InfoClass="InfoGBNP" Style="Text"/> to 1 and the time infolevel <Ref
gap> # Func="InfoGBNPTime" Style="Text"/> to 1 (for more information about the info
gap> # level, see Chapter <Ref Chap="Info"/>).
gap> 
gap> # <L>
gap> LoadPackage("gbnp", false);
true
gap> SetInfoLevel(InfoGBNP,1);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> # </L>
gap> 
gap> # The variables are <M>g_1</M>, <M>g_2</M>,
gap> # <M>e_1</M>, <M>e_2</M>, in this order.
gap> # In order to have the results printed out with these symbols, we
gap> # invoke
gap> # <Ref Func="GBNP.ConfigPrint" Style="Text"/>
gap> # <L>
gap> GBNP.ConfigPrint("g1","g2","e1","e2");
gap> # </L>
gap> 
gap> 
gap> # Unlike Example <Ref Sect="Example07"/>,
gap> # we work with a field of rational functions.
gap> # <L>
gap> ll := Indeterminate(Rationals,"l");
l
gap> mm := Indeterminate(Rationals,"m");
m
gap> F := Field(ll,mm);;
gap> gens := GeneratorsOfField(F);
[ l, m ]
gap> l := gens[1];;
gap> m := gens[2];
m
gap> F1 := One(F);;
gap> Print("identity element of F: ",F1,"\n");
identity element of F: 1
gap> # </L>
gap> 
gap> 
gap> # Now enter the relations. This will be done in NP form.
gap> 
gap> # <L>
gap> #relations Theorem 1.1
gap> k1 := [[[3],[1,1],[1],[]],[F1,-l/m,-l,l/m]];;
gap> k2 := [[[4],[2,2],[2],[]],[F1,-l/m,-l,l/m]];;
gap> 
gap> #relations B1
gap> #empty set here
gap> 
gap> #relations B2:
gap> k3 := [[[1,2,1],[2,1,2]],[F1,-F1]];;
gap> 
gap> #relations R1
gap> k4 := [[[1,3],[3]],[F1,-1/l]];;
gap> k5 := [[[2,4],[4]],[F1,-1/l]];;
gap> 
gap> #relations R2:
gap> k6 := [[[3,2,3],[3]],[F1,-l]];;
gap> k7 := [[[4,1,4],[4]],[F1,-l]];;
gap> k8 := [[[3,4,3],[3]],[F1,-F1]];;
gap> k9 := [[[4,3,4],[4]],[F1,-F1]];;
gap> 
gap> KI := [k1,k2,k3,k4,k5,k6,k7,k8,k9];;
gap> # </L>
gap> 
gap> # The input can be displayed with <Ref Func="PrintNPList" Style="Text"/>:
gap> 
gap> # <L>
gap> PrintNPList(KI);
 e1 + -l/mg1^2 + -lg1 + l/m
 e2 + -l/mg2^2 + -lg2 + l/m
 g1g2g1 + -1g2g1g2
 g1e1 + -l^-1e1
 g2e2 + -l^-1e2
 e1g2e1 + -le1
 e2g1e2 + -le2
 e1e2e1 + -1e1
 e2e1e2 + -1e2
gap> # </L>
gap> 
gap> # Now calculate the Gröbner basis with trace information, using the function
gap> # <Ref Func="SGrobnerTrace" Style="Text"/>:
gap> 
gap> # <L>
gap> GB := SGrobnerTrace(KI);;
#I  number of entered polynomials is 9
#I  number of polynomials after reduction is 9
#I  End of phase I
#I  End of phase II
#I  List of todo lengths is [ 8, 7, 6, 5, 4, 6, 4, 4, 4, 3, 3, 2, 1, 0 ]
#I  End of phase III
#I  End of phase IV
gap> # </L>
gap> 
gap> # The full trace can be printed with <Ref Func="PrintTraceList" Style="Text"/>,
gap> # while printing only the relations (and no trace) can be invoked by <Ref
gap> # Func="PrintNPListTrace" Style="Text"/>. Since the total trace is very long we
gap> # do not call <C>PrintTraceList(GB)</C> here but only show two polynomial
gap> # expressions from the Gröbner basis
gap> # with <Ref Func="PrintTracePol" Style="Text"/>:
gap> 
gap> # <L>
gap> PrintNPListTrace(GB);
 g1^2 + m/-le1 + mg1 + -1
 g1e1 + -l^-1e1
 g2^2 + m/-le2 + mg2 + -1
 g2e2 + -l^-1e2
 e1g1 + 1/-le1
 e1^2 + (l^2-l*m-1)/(l*m)e1
 e2g2 + 1/-le2
 e2^2 + (l^2-l*m-1)/(l*m)e2
 g1g2e1 + -1e2e1
 g1e2e1 + me2e1 + -1g2e1 + -me1
 g2g1g2 + 1/-1g1g2g1
 g2g1e2 + -1e1e2
 g2e1g2 + -1g1e2g1 + -me2g1 + me1g2 + mg2e1 + -mg1e2 + -m^2e2 + m^2e1
 g2e1e2 + me1e2 + -1g1e2 + -me2
 e1g2g1 + -1e1e2
 e1g2e1 + -le1
 e1e2g1 + me1e2 + -1e1g2 + -me1
 e1e2e1 + -1e1
 e2g1g2 + -1e2e1
 e2g1e2 + -le2
 e2e1g2 + me2e1 + -1e2g1 + -me2
 e2e1e2 + -1e2
gap> PrintTracePol(GB[1]);
 m/-lG(1)
gap> PrintTracePol(GB[10]);
 -l*m/(-l*m-1)G(1)g1e2e1 + -l*m/(l*m+1)g1G(1)e2e1 + l^2*m/(-l*m-1)G(
1)g2g1e1 + l*m^2/(-l*m-1)G(1)g2g1e2e1 + -l/(-l*m-1)g2G(
1)g1e2e1 + -l/(l*m+1)g2g1G(1)e2e1 + l^2/(-l*m-1)g2G(
1)g2g1e1 + l*m/(-l*m-1)g2G(1)g2g1e2e1 + -l*m/(-l*m-1)e1g2G(
1)g2g1e1 + -l/(-l*m-1)g2e1g2G(1)g2g1e1 + -m/-lG(
2)g1e2e1 + -l^2*m/(-l*m-1)g2g1G(2)e1 + -l^2/(-l*m-1)g2^2g1G(
2)e1 + m^2/(-l*m-1)e1G(2)g1e2e1 + m/(-l*m-1)g2e1G(
2)g1e2e1 + -l*m/(l*m+1)e1g2^2g1G(2)e1 + -l/(l*m+1)g2e1g2^2g1G(
2)e1 + l^3*m/(-l*m-1)G(3)e1 + l^3/(-l*m-1)g1G(3)e1 + l^3/(-l*m-1)G(
3)g2e1 + l^3/(-l*m-1)g2G(3)e1 + l^2*m^2/(-l*m-1)G(3)e2e1 + l^2*m/(-l*m-1)g1G(
3)e2e1 + l^3/(-l*m^2-m)g2g1G(3)e1 + l^3/(-l*m^2-m)g2G(
3)g2e1 + l^2*m/(-l*m-1)G(3)g2e2e1 + l^2*m/(-l*m-1)g2G(
3)e2e1 + -l^2*m/(-l*m-1)e1g2G(3)e1 + l^2/(-l*m-1)g2g1G(
3)e2e1 + l^2/(-l*m-1)g2G(3)g2e2e1 + -l^2/(-l*m-1)g2e1g2G(
3)e1 + -l^2/(-l*m-1)e1g2g1G(3)e1 + -l^2/(-l*m-1)e1g2G(
3)g2e1 + -l^2/(-l*m^2-m)g2e1g2g1G(3)e1 + -l^2/(-l*m^2-m)g2e1g2G(
3)g2e1 + -l*m/(-l*m-1)G(4)e2e1 + -l/(-l*m-1)g2G(4)e2e1 + -l*mg2g1G(
5)e1 + l^2*m/(-l*m-1)g2g1g2G(5)e1 + -lg2^2g1G(5)e1 + l^2/(-l*m-1)g2^2g1g2G(
5)e1 + l*m/(-l*m-1)G(6)g2g1e1 + l/(-l*m-1)g2G(6)g2g1e1 + m/-lG(
7)e1 + -m^2/(-l*m-1)e1G(7)e1 + -m/(-l*m-1)g2e1G(7)e1 + mG(8) + g2G(8)
gap> # </L>
gap> 
gap> # In order to test whether the expression for <C>GB[10]</C> is as claimed
gap> # we use <Ref Func="EvalTrace" Style="Text"/>,
gap> 
gap> # For each traced polynomial <C>x</C> in <C>GB</C>,
gap> # we equate the evaluated expression
gap> # <C>x.trace</C>,
gap> # in which each occurrence of <C>G(i)</C> is replaced by <C>KI[i]</C>
gap> # by  use of <Ref Func="EvalTrace" Style="Text"/>,
gap> # with <C>x.pol</C>.
gap> 
gap> # <L>
gap> ForAll(GB,x->EvalTrace(x,KI)=x.pol);
false
gap> # </L>
gap> 
gap> 
gap> # As a result the dimension of the quotient algebra can be calculated with <Ref
gap> # Func="DimQA" Style="Text"/> and the quotient algebra itself with <Ref
gap> # Func="BaseQA" Style="Text"/>.
gap> # <L>
gap> GB_pols:=List(GB,x->x.pol);;
gap> PrintNPList(GB_pols);
 g1^2 + m/-le1 + mg1 + -1
 g1e1 + -l^-1e1
 g2^2 + m/-le2 + mg2 + -1
 g2e2 + -l^-1e2
 e1g1 + 1/-le1
 e1^2 + (l^2-l*m-1)/(l*m)e1
 e2g2 + 1/-le2
 e2^2 + (l^2-l*m-1)/(l*m)e2
 g1g2e1 + -1e2e1
 g1e2e1 + me2e1 + -1g2e1 + -me1
 g2g1g2 + 1/-1g1g2g1
 g2g1e2 + -1e1e2
 g2e1g2 + -1g1e2g1 + -me2g1 + me1g2 + mg2e1 + -mg1e2 + -m^2e2 + m^2e1
 g2e1e2 + me1e2 + -1g1e2 + -me2
 e1g2g1 + -1e1e2
 e1g2e1 + -le1
 e1e2g1 + me1e2 + -1e1g2 + -me1
 e1e2e1 + -1e1
 e2g1g2 + -1e2e1
 e2g1e2 + -le2
 e2e1g2 + me2e1 + -1e2g1 + -me2
 e2e1e2 + -1e2
gap> DimQA(GB_pols,2);
6
gap> B:=BaseQA(GB_pols,2,0);;
gap> PrintNPList(B);
 1
 g1
 g2
 g1g2
 g2g1
 g1g2g1
gap> # </L>
gap> 
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> STOP_TEST("test08.g",10000);
