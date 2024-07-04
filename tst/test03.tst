gap> START_TEST("GBNP test03");
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
gap> ### filename = "example03.g"
gap> ### authors Cohen & Gijsbers
gap> 
gap> ### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES
gap> 
gap> ### Last change: August 22 2001.
gap> ### amc
gap> 
gap> # <#GAPDoc Label="Example03">
gap> # <Section Label="Example03"><Heading>The order of the Weyl group of type E<M>_6</M></Heading>
gap> # In order to show how the order of a finite group of manageable size with a manageable
gap> # presentation can be computed, we determine the order of the Weyl group of type E<M>_6</M>.
gap> # This number is well known to be 51840.
gap> # <P/>
gap> # First load the package and set the standard infolevel <Ref
gap> # InfoClass="InfoGBNP" Style="Text"/> to 1 and the time infolevel <Ref
gap> # Func="InfoGBNPTime" Style="Text"/> to 2 (for more information about the info
gap> # level, see Chapter <Ref Chap="Info"/>).
gap> 
gap> # <L>
gap> LoadPackage("gbnp", false);
true
gap> SetInfoLevel(InfoGBNP,1);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> # </L>
gap> 
gap> # Then input the relations in NP format (see <Ref Sect="NP"/>).
gap> # They come from the presentation of the Weyl group as a Coxeter group.
gap> # This means that there are six variables, one for each generator.
gap> # We let the corresponding variables be printed as <M>r_1</M>, ..., <M>r_6</M> by means of
gap> # <Ref Func="GBNP.ConfigPrint" Style="Text"/>
gap> # <L>
gap> GBNP.ConfigPrint(6,"r");
gap> # </L>
gap> 
gap> 
gap> # The relations are binomial and represent the group relations,
gap> # which express that the generators are involutions (that is,
gap> # have order 2) and that the orders of the products of any two generators
gap> # is specified by the Coxeter diagram (see any book on Coxeter groups for details).
gap> # The relations will be
gap> # assigned to <C>KI</C>.
gap> 
gap> # <L>
gap> k1 := [[[1,3,1],[3,1,3]],[1,-1]];;
gap> k2 := [[[4,3,4],[3,4,3]],[1,-1]];;
gap> k3 := [[[4,2,4],[2,4,2]],[1,-1]];;
gap> k4 := [[[4,5,4],[5,4,5]],[1,-1]];;
gap> k5 := [[[6,5,6],[5,6,5]],[1,-1]];;
gap> k6 := [[[1,2],[2,1]],[1,-1]];;
gap> k7 := [[[1,4],[4,1]],[1,-1]];;
gap> k8 := [[[1,5],[5,1]],[1,-1]];;
gap> k9 := [[[1,6],[6,1]],[1,-1]];;
gap> k10 := [[[2,3],[3,2]],[1,-1]];;
gap> k11 := [[[2,5],[5,2]],[1,-1]];;
gap> k12 := [[[2,6],[6,2]],[1,-1]];;
gap> k13 := [[[3,5],[5,3]],[1,-1]];;
gap> k14 := [[[3,6],[6,3]],[1,-1]];;
gap> k15 := [[[4,6],[6,4]],[1,-1]];;
gap> k16 := [[[1,1],[]],[1,-1]];;
gap> k17 := [[[2,2],[]],[1,-1]];;
gap> k18 := [[[3,3],[]],[1,-1]];;
gap> k19 := [[[4,4],[]],[1,-1]];;
gap> k20 := [[[5,5],[]],[1,-1]];;
gap> k21 := [[[6,6],[]],[1,-1]];;
gap> KI := [k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,
>        k11,k12,k13,k14,k15,k16,k17,k18,k19,k20,k21
>       ];;
gap> # </L>
gap> 
gap> # The relations can be shown with <Ref Func="PrintNPList" Style="Text"/>:
gap> 
gap> # <L>
gap> PrintNPList(KI);
 r.1r.3r.1 - r.3r.1r.3
 r.4r.3r.4 - r.3r.4r.3
 r.4r.2r.4 - r.2r.4r.2
 r.4r.5r.4 - r.5r.4r.5
 r.6r.5r.6 - r.5r.6r.5
 r.1r.2 - r.2r.1
 r.1r.4 - r.4r.1
 r.1r.5 - r.5r.1
 r.1r.6 - r.6r.1
 r.2r.3 - r.3r.2
 r.2r.5 - r.5r.2
 r.2r.6 - r.6r.2
 r.3r.5 - r.5r.3
 r.3r.6 - r.6r.3
 r.4r.6 - r.6r.4
 r.1^2 - 1
 r.2^2 - 1
 r.3^2 - 1
 r.4^2 - 1
 r.5^2 - 1
 r.6^2 - 1
gap> # </L>
gap> 
gap> # The Gröbner basis can now be calculated with
gap> # <Ref Func="SGrobner" Style="Text"/>:
gap> 
gap> # <L>
gap> GB := SGrobner(KI);;
#I  number of entered polynomials is 21
#I  number of polynomials after reduction is 21
#I  End of phase I
#I  End of phase II
#I  End of phase III
#I  End of phase IV
gap> PrintNPList(GB);
 r.1^2 - 1
 r.2r.1 - r.1r.2
 r.2^2 - 1
 r.3r.2 - r.2r.3
 r.3^2 - 1
 r.4r.1 - r.1r.4
 r.4^2 - 1
 r.5r.1 - r.1r.5
 r.5r.2 - r.2r.5
 r.5r.3 - r.3r.5
 r.5^2 - 1
 r.6r.1 - r.1r.6
 r.6r.2 - r.2r.6
 r.6r.3 - r.3r.6
 r.6r.4 - r.4r.6
 r.6^2 - 1
 r.3r.1r.2 - r.2r.3r.1
 r.3r.1r.3 - r.1r.3r.1
 r.4r.2r.4 - r.2r.4r.2
 r.4r.3r.4 - r.3r.4r.3
 r.5r.4r.5 - r.4r.5r.4
 r.6r.5r.6 - r.5r.6r.5
 r.4r.3r.1r.4 - r.3r.4r.3r.1
 r.5r.4r.2r.5 - r.4r.5r.4r.2
 r.5r.4r.3r.5 - r.4r.5r.4r.3
 r.6r.5r.4r.6 - r.5r.6r.5r.4
 r.4r.2r.3r.4r.2 - r.3r.4r.2r.3r.4
 r.4r.2r.3r.4r.3 - r.2r.4r.2r.3r.4
 r.5r.4r.2r.3r.5 - r.4r.5r.4r.2r.3
 r.5r.4r.3r.1r.5 - r.4r.5r.4r.3r.1
 r.6r.5r.4r.2r.6 - r.5r.6r.5r.4r.2
 r.6r.5r.4r.3r.6 - r.5r.6r.5r.4r.3
 r.4r.2r.3r.1r.4r.2 - r.3r.4r.2r.3r.1r.4
 r.5r.4r.2r.3r.1r.5 - r.4r.5r.4r.2r.3r.1
 r.6r.5r.4r.2r.3r.6 - r.5r.6r.5r.4r.2r.3
 r.6r.5r.4r.3r.1r.6 - r.5r.6r.5r.4r.3r.1
 r.4r.2r.3r.1r.4r.3r.1 - r.2r.4r.2r.3r.1r.4r.3
 r.5r.4r.2r.3r.4r.5r.4 - r.4r.5r.4r.2r.3r.4r.5
 r.6r.5r.4r.2r.3r.1r.6 - r.5r.6r.5r.4r.2r.3r.1
 r.6r.5r.4r.2r.3r.4r.6 - r.5r.6r.5r.4r.2r.3r.4
 r.5r.4r.2r.3r.1r.4r.5r.4 - r.4r.5r.4r.2r.3r.1r.4r.5
 r.6r.5r.4r.2r.3r.1r.4r.6 - r.5r.6r.5r.4r.2r.3r.1r.4
 r.6r.5r.4r.2r.3r.1r.4r.3r.6 - r.5r.6r.5r.4r.2r.3r.1r.4r.3
 r.6r.5r.4r.2r.3r.4r.5r.6r.5 - r.5r.6r.5r.4r.2r.3r.4r.5r.6
 r.5r.4r.2r.3r.1r.4r.3r.5r.4r.3 - r.4r.5r.4r.2r.3r.1r.4r.3r.5r.4
 r.6r.5r.4r.2r.3r.1r.4r.5r.6r.5 - r.5r.6r.5r.4r.2r.3r.1r.4r.5r.6
 r.5r.4r.2r.3r.1r.4r.3r.5r.4r.2r.3 - r.4r.5r.4r.2r.3r.1r.4r.3r.5r.4r.2
 r.6r.5r.4r.2r.3r.1r.4r.3r.5r.6r.5 - r.5r.6r.5r.4r.2r.3r.1r.4r.3r.5r.6
 r.6r.5r.4r.2r.3r.1r.4r.3r.5r.4r.6r.5r.4 - r.5r.6r.5r.4r.2r.3r.1r.4r.3r.5r.4r.\
6r.5
 r.6r.5r.4r.2r.3r.1r.4r.3r.5r.4r.2r.6r.5r.4r.2 - r.5r.6r.5r.4r.2r.3r.1r.4r.3r.\
5r.4r.2r.6r.5r.4
gap> # </L>
gap> 
gap> # The base of the quotient algebra can be calculated with <Ref Func="BaseQA"
gap> # Style="Text"/>, which has as arguments a Gröbner basis <C>GB</C>, a number
gap> # of symbols <C>6</C> and a maximum terms to be found (here 0 is entered, for
gap> # a full base) . Since it is very long we will not print it here.
gap> 
gap> # <L>
gap> B:=BaseQA(GB,6,0);;
gap> # </L>
gap> 
gap> # The dimension of the quotient algebra can be calculated with
gap> # <Ref Func="DimQA" Style="Text"/>, the arguments are the Gröbner basis
gap> # <C>GB</C> and the number of symbols <C>6</C>. Since <Ref
gap> # InfoClass="InfoGBNPTime" Style="Text"/> is set to 2, we get
gap> # timing information from <Ref Func="DimQA" Style="Text"/>:
gap> 
gap> # <L>
gap> DimQA(GB,6);
51840
gap> # </L>
gap> 
gap> # Note that the calculation of the dimension takes almost as long as
gap> # calculating the base. Since we have already calculated a base <C>B</C> it is
gap> # much more efficient to calculate the dimension with <C>Length</C>:
gap> 
gap> # <L>
gap> Length(B);
51840
gap> # </L>
gap> 
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> STOP_TEST("test03.g",10000);
