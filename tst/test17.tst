gap> START_TEST("GBNP test17");
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
gap> ### filename = "example17.g"
gap> ### authors Knopper
gap> 
gap> ### THIS IS A GAP PACKAGE GBNP
gap> ### FOR COMPUTING WITH NON-COMMUTATIVE POLYNOMIALS
gap> 
gap> # <#GAPDoc Label="Example17">
gap> # <Section Label="Example17"><Heading>An algebra over a finite field</Heading>
gap> # A small example over a field other than the rationals, using the conversion
gap> # functions from <Ref Sect="TransitionFunctions"/>.
gap> # The input relations define the symmetric group of degree 3,
gap> # denoted <M>S_3</M>.
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
gap> # Let <C>F</C> be the field GF(2). The relations can be
gap> # entered as elements of a free associative algebra with one <C>A</C> (see
gap> # <Ref BookName="Reference" Label="FreeAssociativeAlgebraWithOne"/>).
gap> 
gap> # <L>
gap> F:=GF(2);;
gap> A:=FreeAssociativeAlgebraWithOne(F,"a","b");
<algebra-with-one over GF(2), with 2 generators>
gap> g:=GeneratorsOfAlgebraWithOne(A);
[ (Z(2)^0)*a, (Z(2)^0)*b ]
gap> # </L>
gap> 
gap> # Enter the relations <M>\{a^2-1,b^2-1,(ab)^3-1\}</M>, convert them to NP-form,
gap> # see Section <Ref Sect="NP"/>, with <Ref Func="GP2NPList" Style="Text"/> and
gap> # print them with <Ref Func="PrintNPList" Style="Text"/>:
gap> 
gap> # <L>
gap> KI_GP := [ g[1]^2-g[1]^0, g[2]^2-g[1]^0, (g[1]*g[2])^3-g[1]^0];
[ (Z(2)^0)*<identity ...>+(Z(2)^0)*a^2, (Z(2)^0)*<identity ...>+(Z(2)^0)*b^2,
  (Z(2)^0)*<identity ...>+(Z(2)^0)*(a*b)^3 ]
gap> KI:=GP2NPList(KI_GP);;
gap> PrintNPList(KI);
 a^2 + Z(2)^0
 b^2 + Z(2)^0
 ababab + Z(2)^0
gap> # </L>
gap> 
gap> # Now calculate the Gröbner basis with <Ref Func="SGrobner" Style="Text"/> and
gap> # print it with <Ref Func="PrintNPList" Style="Text"/>:
gap> 
gap> # <L>
gap> GB:=SGrobner(KI);;
#I  number of entered polynomials is 3
#I  number of polynomials after reduction is 3
#I  End of phase I
#I  End of phase II
#I  length of G =3
#I  length of todo is 2
#I  length of G =3
#I  length of todo is 1
#I  length of G =3
#I  length of todo is 0
#I  List of todo lengths is [ 2, 2, 1, 0 ]
#I  End of phase III
#I  G: Cleaning finished, 0 polynomials reduced
#I  End of phase IV
gap> PrintNPList(GB);
 a^2 + Z(2)^0
 b^2 + Z(2)^0
 bab + aba
gap> # </L>
gap> 
gap> # Now calculate the dimension of the quotient algebra with <Ref Func="DimQA"
gap> # Style="Text"/> (2 symbols) and a base with <Ref Func="BaseQA" Style="Text"/>
gap> # (2 symbols, 0 for whole base) and print the base.
gap> # This will give a list of elements of the group.
gap> 
gap> # <L>
gap> DimQA(GB,2);
6
gap> B:=BaseQA(GB,2,0);;
gap> PrintNPList(B);
 Z(2)^0
 a
 b
 ab
 ba
 aba
gap> # </L>
gap> 
gap> # We can print the Gröbner basis and the basis of the quotient algebra,
gap> # converted back to GAP polynomials with <Ref Func="NP2GPList" Style="Text"/>.
gap> # The functions used to convert the polynomials also require the algebra as an
gap> # argument. The result is useful for further computations in <M>A</M>.
gap> 
gap> # <L>
gap> NP2GPList(GB,A);
[ (Z(2)^0)*a^2+(Z(2)^0)*<identity ...>, (Z(2)^0)*b^2+(Z(2)^0)*<identity ...>,
  (Z(2)^0)*b*a*b+(Z(2)^0)*a*b*a ]
gap> NP2GPList(B,A);
[ (Z(2)^0)*<identity ...>, (Z(2)^0)*a, (Z(2)^0)*b, (Z(2)^0)*a*b,
  (Z(2)^0)*b*a, (Z(2)^0)*a*b*a ]
gap> # </L>
gap> 
gap> # The matrix of right multiplication with the image of the
gap> # first variable
gap> # can be computed by <Ref Func="MatrixQA" Style="Text"/>.
gap> # <L>
gap> Display(MatrixQA(1,B,GB));
 . 1 . . . .
 1 . . . . .
 . . . . 1 .
 . . . . . 1
 . . 1 . . .
 . . . 1 . .
gap> # </L>
gap> 
gap> 
gap> 
gap> 
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> STOP_TEST("test17.g",10000);
