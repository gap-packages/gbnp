gap> START_TEST("GBNP test18");
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
gap> ### filename = "example18.g"
gap> ### author Knopper
gap> 
gap> ### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES
gap> 
gap> 
gap> # <#GAPDoc Label="Example18">
gap> # <Section Label="Example18"><Heading>The dihedral group of order 8</Heading>
gap> # In this example (Example 1 from Linton <Cite
gap> # Key="MR94k:20022"/>) the two-sided relations give the group algebra
gap> # of the group with presentation
gap> # <M>\langle a,b \mid a^4=b^2=(ab)^2=1\rangle</M>, the dihedral group of order 8.
gap> # It is possible to construct a permutation module of degree 4, over a field
gap> # <C>k</C>. In this example <C>k</C> will be the field of rational numbers.
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
gap> # Now enter the relations as GAP polynomials. It is possible to enter them with
gap> # and without module generators. First it is shown how to enter the relations
gap> # without using a module. It is possible to enter them with a free associative
gap> # algebra with one over the field (the rational numbers) (see also <Ref
gap> # BookName="Reference" Label="FreeAssociativeAlgebraWithOne"/>). For
gap> # convenience we use the variables <C>a</C> and <C>b</C> for the generators of
gap> # the algebra and <C>e</C> for the one of the algebra.
gap> 
gap> # <L>
gap> A:=FreeAssociativeAlgebraWithOne(Rationals, "a", "b");
<algebra-with-one over Rationals, with 2 generators>
gap> a:=A.a;;b:=A.b;;e:=One(A);;
gap> # </L>
gap> 
gap> # Now the relations are entered:
gap> 
gap> # <L>
gap> twosidrels:=[a^4-e,b^2-e,(a*b)^2-e];;
gap> prefixrels:=[b-e];;
gap> # </L>
gap> 
gap> # First the relations are converted into NP format, see Section <Ref
gap> # Sect="NP"/>, after which the function <Ref Func="SGrobnerModule"
gap> # Style="Text"/> is called to calculate a Gröbner basis record.
gap> 
gap> # <L>
gap> GBR:=SGrobnerModule(GP2NPList(prefixrels),GP2NPList(twosidrels));;
#I  number of entered polynomials is 3
#I  number of polynomials after reduction is 3
#I  End of phase I
#I  End of phase II
#I  End of phase III
#I  End of phase IV
#I  number of entered polynomials is 7
#I  number of polynomials after reduction is 7
#I  End of phase I
#I  End of phase II
#I  End of phase III
#I  End of phase IV
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
[ a^3 - ab ]
[ a^2b - a^2 ]
gap> # </L>
gap> 
gap> # It is now possible to calculate the standard basis of the quotient module
gap> # with the function <Ref Func="BaseQM" Style="Text"/>. This function has as
gap> # arguments the Gröbner basis record <C>GBR</C>, the number of generators of
gap> # the algebra (2), the number of generators of the module (1),
gap> # and a variable <C>maxno</C> for returning partial bases
gap> # (0 means full basis).
gap> 
gap> # <L>
gap> B:=BaseQM(GBR,2,1,0);;
gap> PrintNPList(B);
[ 1 ]
[ a ]
[ a^2 ]
[ ab ]
gap> # </L>
gap> 
gap> # It is also possible to use a module with one generator to enter these
gap> # relations:
gap> 
gap> # <L>
gap> D:=A^1;;
gap> gd:=GeneratorsOfLeftModule(D);;
gap> prefixrelsdom:=[gd[1]*(b-e)];;
gap> # </L>
gap> 
gap> # It is possible to use the two-sided Gröbner basis which was already
gap> # calculated.
gap> 
gap> # <L>
gap> GBR:=SGrobnerModule(GP2NPList(prefixrelsdom),GBR.ts);;
#I  number of entered polynomials is 6
#I  number of polynomials after reduction is 6
#I  End of phase I
#I  End of phase II
#I  End of phase III
#I  End of phase IV
#I  number of entered polynomials is 7
#I  number of polynomials after reduction is 7
#I  End of phase I
#I  End of phase II
#I  End of phase III
#I  End of phase IV
gap> PrintNPList(GBR.p);;
[ b - 1 ]
[ a^3 - ab ]
[ a^2b - a^2 ]
gap> B:=BaseQM(GBR,2,1,0);;
gap> PrintNPList(B);
[ 1 ]
[ a ]
[ a^2 ]
[ ab ]
gap> # </L>
gap> 
gap> 
gap> # To compute the image of right multiplication of the basis element
gap> # <C>B[Length(B)]</C> of the module with the quotient algebra element
gap> # corresponding to
gap> # <M>ab</M> we use the function <Ref Func="MulQM" Style="Text"/> with
gap> # arguments <C>B[Length(B)]</C>, <C>GB2NP(a*b)</C>, and <C>GBR</C>
gap> # We subsequently use  <Ref Func="PrintNP" Style="Text"/> to display the result
gap> # as a 1-dimensional vector with an entry from <M>A</M>.
gap> 
gap> # <L>
gap> v := MulQM(B[Length(B)],GP2NP(a*b),GBR);
[ [ [ -1 ] ], [ 1 ] ]
gap> PrintNP(v);
[ 1 ]
gap> # </L>
gap> 
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> STOP_TEST("test18.g",10000);
