gap> START_TEST("GBNP test07");
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
gap> ### filename = "exampleNoah.g"
gap> ### authors Cohen & Wales
gap> 
gap> ### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES
gap> 
gap> ### Last change: Aug 12 2008, amc.
gap> ### dahg
gap> ## [A.M. Cohen, D.A.H. Gijsbers  D.B. Wales, BMW Algebras of simply laced type, J. Algebra, 286 (2005) 107--153].
gap> 
gap> # <#GAPDoc Label="Example07">
gap> # <Section Label="Example07"><Heading>The Birman-Murakami-Wenzl algebra of type A<M>_3</M></Heading>
gap> # We study the Birman-Murakami-Wenzl algebra of type A<M>_3</M> as an algebra
gap> # given by generators and relations.
gap> # A reference for the relations used is <Cite Key="MR2124811"/>.
gap> # <P/>
gap> 
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
gap> # The variables are <M>g_1</M>, <M>g_2</M>, <M>g_3</M>,
gap> # <M>e_1</M>, <M>e_2</M>, <M>e_3</M>, in this order.
gap> # In order to have the results printed out with these symbols, we
gap> # invoke
gap> # <Ref Func="GBNP.ConfigPrint" Style="Text"/>
gap> # <L>
gap> GBNP.ConfigPrint("g1","g2","g3","e1","e2","e3");
gap> # </L>
gap> 
gap> 
gap> # Now enter the relations. This will be done in NP form (see <Ref Sect="NP"/>).
gap> # The inderminates <M>m</M> and <M>l</M>
gap> # in the coefficient ring of the Birman-Murakami-Wenzl algebra
gap> # are specialized to 7 and 11 in order to make the computations more efficient.
gap> # <L>
gap> m:= 7;;
gap> l:= 11;;
gap> 
gap> #relations Theorem 1.1
gap> k1 := [[[4],[1,1],[1],[]],[1,-l/m,-l,l/m]];;
gap> k2 := [[[5],[2,2],[2],[]],[1,-l/m,-l,l/m]];;
gap> k3 := [[[6],[3,3],[3],[]],[1,-l/m,-l,l/m]];;
gap> 
gap> #relations B1
gap> #empty set here
gap> 
gap> #relations B2:
gap> k4 := [[[1,2,1],[2,1,2]],[1,-1]];;
gap> k5 := [[[2,3,2],[3,2,3]],[1,-1]];;
gap> k6 := [[[1,3],[3,1]],[1,-1]];;
gap> 
gap> #relations R1
gap> kr1 := [[[1,4],[4]],[1,-1/l]];;
gap> kr2 := [[[2,5],[5]],[1,-1/l]];;
gap> kr3 := [[[3,6],[6]],[1,-1/l]];;
gap> 
gap> #relations R2:
gap> kr4 := [[[4,2,4],[4]],[1,-l]];;
gap> kr5 := [[[5,1,5],[5]],[1,-l]];;
gap> kr6 := [[[5,3,5],[5]],[1,-l]];;
gap> kr7 := [[[6,2,6],[6]],[1,-l]];;
gap> 
gap> #relations R2'
gap> km1 := [[[4,5,4],[4]],[1,-1]];;
gap> km2 := [[[5,4,5],[5]],[1,-1]];;
gap> km3 := [[[5,6,5],[5]],[1,-1]];;
gap> km4 := [[[6,5,6],[6]],[1,-1]];;
gap> 
gap> KI := [k1,k2,k3,k4,k5,k6,kr1,kr2,kr3,kr4,kr5,kr6,kr7,km1,km2,km3,km4];;
gap> # </L>
gap> 
gap> # Now print the relations with <Ref Func="PrintNPList" Style="Text"/>:
gap> 
gap> # <L>
gap> PrintNPList(KI);
 e1 - 11/7g1^2 - 11g1 + 11/7
 e2 - 11/7g2^2 - 11g2 + 11/7
 e3 - 11/7g3^2 - 11g3 + 11/7
 g1g2g1 - g2g1g2
 g2g3g2 - g3g2g3
 g1g3 - g3g1
 g1e1 - 1/11e1
 g2e2 - 1/11e2
 g3e3 - 1/11e3
 e1g2e1 - 11e1
 e2g1e2 - 11e2
 e2g3e2 - 11e2
 e3g2e3 - 11e3
 e1e2e1 - e1
 e2e1e2 - e2
 e2e3e2 - e2
 e3e2e3 - e3
gap> Length(KI);
17
gap> # </L>
gap> 
gap> # Now calculate the Gröbner basis with <Ref Func="SGrobner" Style="Text"/>:
gap> 
gap> # <L>
gap> GB := SGrobner(KI);;
#I  number of entered polynomials is 17
#I  number of polynomials after reduction is 17
#I  End of phase I
#I  End of phase II
#I  End of phase III
#I  End of phase IV
gap> PrintNPList(GB);
 g1^2 - 7/11e1 + 7g1 - 1
 g1e1 - 1/11e1
 g2^2 - 7/11e2 + 7g2 - 1
 g2e2 - 1/11e2
 g3g1 - g1g3
 g3^2 - 7/11e3 + 7g3 - 1
 g3e3 - 1/11e3
 e1g1 - 1/11e1
 e1g3 - g3e1
 e1^2 + 43/77e1
 e2g2 - 1/11e2
 e2^2 + 43/77e2
 e3g1 - g1e3
 e3g3 - 1/11e3
 e3e1 - e1e3
 e3^2 + 43/77e3
 g1g2e1 - e2e1
 g1g3e1 - 1/11g3e1
 g1e2e1 + 7e2e1 - g2e1 - 7e1
 g2g1g2 - g1g2g1
 g2g1e2 - e1e2
 g2g3e2 - e3e2
 g2e1g2 - g1e2g1 - 7e2g1 + 7e1g2 + 7g2e1 - 7g1e2 - 49e2 + 49e1
 g2e1e2 + 7e1e2 - g1e2 - 7e2
 g2e3e2 + 7e3e2 - g3e2 - 7e2
 g3g2g3 - g2g3g2
 g3g2e3 - e2e3
 g3e1e3 - 1/11e1e3
 g3e2g3 - g2e3g2 - 7e3g2 + 7e2g3 + 7g3e2 - 7g2e3 - 49e3 + 49e2
 g3e2e3 + 7e2e3 - g2e3 - 7e3
 e1g2g1 - e1e2
 e1g2e1 - 11e1
 e1e2g1 + 7e1e2 - e1g2 - 7e1
 e1e2e1 - e1
 e2g1g2 - e2e1
 e2g1e2 - 11e2
 e2g3g2 - e2e3
 e2g3e2 - 11e2
 e2e1g2 + 7e2e1 - e2g1 - 7e2
 e2e1e2 - e2
 e2e3g2 + 7e2e3 - e2g3 - 7e2
 e2e3e2 - e2
 e3g2g3 - e3e2
 e3g2e3 - 11e3
 e3e2g3 + 7e3e2 - e3g2 - 7e3
 e3e2e3 - e3
 g1g2g3e1 - e2g3e1
 g1g3g2e1 - g3e2e1
 g1g3e2e1 + 7g3e2e1 - g3g2e1 - 7g3e1
 g1e2g3e1 + 7e2g3e1 - g2g3e1 - 7g3e1
 g1e3g2e1 - e3e2e1
 g1e3e2e1 + 7e3e2e1 - e3g2e1 - 7e1e3
 g3g2g1g3 - g2g3g2g1
 g3g2g1e3 - e2g1e3
 g3g2e1e3 - e2e1e3
 g3e1g2e3 - e1e2e3
 g3e1e2e3 + 7e1e2e3 - e1g2e3 - 7e1e3
 g3e2g1g3 - g2e3g2g1 - 7e3g2g1 + 7e2g1g3 + 7g3e2g1 - 7g2g1e3 + 49e2g1 - 49g1e3\

 g3e2g1e3 + 7e2g1e3 - g2g1e3 - 7g1e3
 g3e2e1e3 + 7e2e1e3 - g2e1e3 - 7e1e3
 e1g2g3g2 - g3e1g2g3
 e1g2g3e1 - 11g3e1
 e1g2e3g2 - g3e1e2g3 + 7e1e3g2 - 7e1e2g3 + 7e1g2e3 - 7g3e1e2 + 49e1e3 - 49e1e2\

 e1e2g3e1 - g3e1
 e1e3g2g1 - e1e3e2
 e1e3g2e1 - 11e1e3
 e1e3e2g1 + 7e1e3e2 - e1e3g2 - 7e1e3
 e1e3e2e1 - e1e3
 e2g3e1e2 - e2g1e3e2
 e2e1e3e2 + 7e2g1e3e2 - e2g1g3e2 - 77e2
 e3g2g1g3 - e3e2g1
 e3g2g1e3 - 11g1e3
 e3g2e1e3 - 11e1e3
 e3e2g1g3 + 7e3e2g1 - e3g2g1 - 7g1e3
 e3e2g1e3 - g1e3
 e3e2e1e3 - e1e3
 g1g2g1g3e2 - g2g1e3e2
 g1g2g1e3e2 + 7g2g1e3e2 - g2g1g3e2 - 7e1e2
 g1g2g3g2e1 - g2e3g2e1 - 7e3g2e1 + 7e2g3e1 + 7g3e2e1 - 7g2e1e3 + 49e2e1 - 49e1\
e3
 g1g2e3g2e1 + 7g2e3g2e1 - g2g3g2e1 + 7e3e2e1 + 49e3g2e1 + 7e2e1e3 - 7g3g2e1 + \
49g2e1e3 - 7g2g3e1 + 343e1e3 - 49g3e1 - 49g2e1 - 350e1
 g1e2g1g3e2 + 7e2g1g3e2 - g2e1e3e2 - 7g2g3e1e2 - 7e1e3e2 - 49g3e1e2 + 77g1e2 +\
 539e2
 g1e2g1e3e2 + 7e2g1e3e2 - g2g3e1e2 - 7g3e1e2
 g2g3e1g2g3 - g1e2g1g3g2 - 7e2g1g3g2 + 7g3e1g2g3 + 7g2g3e1g2 + 49g3e1g2 - 7g1e\
2e3 - 49e2e3
 g2g3e1e2g3 - g1e2g1e3g2 - 7e2g1e3g2 + 7g3e1e2g3 + 7g2g3e1e2 - 7g1e2g1e3 - 49e\
2g1e3 + 49g3e1e2
 e2g1g3g2g1 - e2g1e3g2
 e2g1g3e2g1 - e2e1e3g2 - 7e2g3e1g2 + 7e2g1g3e2 - 7e2e1e3 - 49e2g3e1 + 77e2g1 +\
 539e2
 e2g1e3g2g1 + 7e2g1e3g2 - e2g1g3g2 - 7e2e1
 e2g1e3e2g1 - e2g3e1g2 + 7e2g1e3e2 - 7e2g3e1
 e2g3e1g2g3 + 7e2g3e1g2 - e2g1g3g2 - 7e2e3
gap> # </L>
gap> 
gap> # Now calculate the dimension of the quotient algebra with <Ref Func="DimQA"
gap> # Style="Text"/> (the second argument is the number of symbols):
gap> 
gap> # <L>
gap> DimQA(GB,6);
105
gap> # </L>
gap> 
gap> # The conclusion is that the BMW algebra of type A3 has dimension 105.
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> STOP_TEST("test07.g",10000);
