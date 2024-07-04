gap> START_TEST("GBNP test13");
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
gap> ### filename = "example13.g"
gap> ### authors Cohen & Gijsbers & Krook
gap> ### This example was added by Chris Krook.
gap> 
gap> ### THIS IS A GAP PACKAGE GBNP
gap> ### FOR COMPUTING WITH NON-COMMUTATIVE POLYNOMIALS
gap> ### ADD-ON: STUDY GROWTH OF FACTOR ALGEBRA
gap> 
gap> # <#GAPDoc Label="Example13">
gap> # <Section Label="Example13"><Heading> Finiteness of the Weyl group of type E<M>_6</M></Heading>
gap> # <P/>
gap> # This example extends <Ref Sect="Example03"/>, which
gap> # computes the order of the Weyl group of type E<M>_6</M>.
gap> # <P/>
gap> # Here, before the dimension is calculated, it is checked whether the quotient
gap> # algebra is finite dimensional or infinite dimensional. The function <Ref
gap> # Func="FinCheckQA" Style="Text"/> is used for this computation. For the use
gap> # of <Ref Func="PreprocessAnalysisQA" Style="Text"/> to speed up the check,
gap> # see Example <Ref Sect="Example14"/>.
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
gap> # Then input the relations in NP format (see Section <Ref Sect="NP"/>). They
gap> # will be assigned to <C>KI</C>. These relations are the same as those in
gap> # Example 3.
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
gap> # </L>
gap> 
gap> # We will check whether the quotient algebra is finite dimensional or infinite
gap> # dimensional.
gap> # The function <Ref Func="FinCheckQA" Style="Text"/> exists for this purpose.
gap> # Its first argument is the list
gap> # of leading monomials of a
gap> # Gröbner basis and its second argument the number of symbols. The leading
gap> # monomials can be calculated with <Ref Func="LMonsNP" Style="Text"/>.
gap> 
gap> # <L>
gap> L:=LMonsNP(GB);;
gap> FinCheckQA(L,6);
true
gap> # </L>
gap> 
gap> # If a quotient algebra is finite dimensional, the dimension can be calculated
gap> # with <Ref Func="DimQA" Style="Text"/>, the arguments are the Gröbner basis
gap> # <C>GB</C> and the number of symbols <C>6</C>. Since <Ref
gap> # InfoClass="InfoGBNPTime" Style="Text"/> is set to 2, we get
gap> # timing information from <Ref Func="DimQA" Style="Text"/>:
gap> 
gap> # <L>
gap> dim := DimQA(GB,6);
51840
gap> # </L>
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> STOP_TEST("test13.g",10000);
