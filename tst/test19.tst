gap> START_TEST("GBNP test19");
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
gap> ### filename = "example19.g"
gap> ### author Knopper
gap> ### amc edited 22 March 2007
gap> 
gap> ### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES
gap> ### Last change: September 25 2003
gap> ### jwk
gap> 
gap> # <#GAPDoc Label="Example19">
gap> # <Section Label="Example19"><Heading>The dihedral group of order 8 on another module</Heading>
gap> # In this example (Example 2 from Linton <Cite Key="MR94k:20022"/>) the two-sided relations give the group algebra
gap> # of the group with presentation
gap> # <M>\langle a,b\mid a^4=b^2=(ab)^2=1\rangle</M>, the dihedral group of order 8.
gap> # This module relation fixes the all-one vector of Example <Ref Sect="Example18"/>:
gap> # <M>1 + a(1+a+b)</M>.
gap> # <P/>
gap> # First load the package and set the standard infolevel <Ref
gap> # InfoClass="InfoGBNP" Style="Text"/> to 0 and the time infolevel <Ref
gap> # Func="InfoGBNPTime" Style="Text"/> to 0 (for more information about the info
gap> # level, see Chapter <Ref Chap="Info"/>).
gap> 
gap> # <L>
gap> LoadPackage("gbnp", false);
true
gap> SetInfoLevel(InfoGBNP,0);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> # </L>
gap> 
gap> # We will enter the relations as GAP polynomials. It is possible to enter these
gap> # with and without a module.
gap> # How to do this is shown in <Ref Sect="Example18"/>.
gap> # The relations here are entered without a module, since the module is
gap> # only one-dimensional.
gap> # It is possible to enter them using a free associative algebra with one over
gap> # the field (the rational numbers) (see also <Ref BookName="Reference"
gap> # Label="FreeAssociativeAlgebraWithOne"/>). For convenience we use the
gap> # variables <C>a</C> and <C>b</C> for the generators of the algebra and
gap> # <C>e</C> for the one of the algebra.
gap> 
gap> # <L>
gap> A:=FreeAssociativeAlgebraWithOne(Rationals, "a", "b");
<algebra-with-one over Rationals, with 2 generators>
gap> g:=GeneratorsOfAlgebra(A);;
gap> a:=g[2];;b:=g[3];;e:=g[1];;
gap> # </L>
gap> 
gap> # Now the relations are entered:
gap> 
gap> # <L>
gap> twosidrels:=[a^4-e,b^2-e,(a*b)^2-e];;
gap> prefrels:=[ b-e, e + a * (e + a + b) ];;
gap> # </L>
gap> 
gap> # First the relations are converted into NP format (see <Ref Sect="NP"/>) after
gap> # which the function <Ref Func="SGrobnerModule" Style="Text"/> is called to
gap> # calculate a Gröbner basis record.
gap> 
gap> # <L>
gap> GBR:=SGrobnerModule(GP2NPList(prefrels),GP2NPList(twosidrels));;
gap> # </L>
gap> 
gap> # The record GBR has two members: the two-sided relations <C>GBR.ts</C> and the
gap> # prefix relations <C>GBR.p</C>. It is possible to print these using the
gap> # function <Ref Func="PrintNPList" Style="Text"/>:
gap> 
gap> # <L>
gap> PrintNPList(GBR.ts);
 b^2 - 1
 aba - b
 ba^2 - a^2b
 bab - a^3
 a^4 - 1
 a^3b - ba
gap> PrintNPList(GBR.p);
[ b - 1 ]
[ ab + a^2 + a + 1 ]
[ a^3 + a^2 + a + 1 ]
[ a^2b - a^2 ]
gap> # </L>
gap> 
gap> # It is now possible to calculate the standard basis of the quotient module
gap> # with the function <Ref Func="BaseQM" Style="Text"/>. This function has as
gap> # arguments the Gröbner basis record <C>GBR</C>, the number of generators of
gap> # the algebra (here it is 2), the number of generators of the mdoule
gap> # (here it is 1), and a variable <C>maxno</C> for returning partial
gap> # bases (0 means full basis).
gap> 
gap> # <L>
gap> B:=BaseQM(GBR,2,1,0);;
gap> PrintNPList(B);
[ 1 ]
[ a ]
[ a^2 ]
gap> # </L>
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> STOP_TEST("test19.g",10000);
