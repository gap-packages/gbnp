gap> START_TEST("GBNP test20");
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
gap> ### filename = "example20.g"
gap> ### author Knopper
gap> ### amc last edited 25 May 2007 problem with GBNP(y[1]+y[2])
gap> 
gap> # <#GAPDoc Label="Example20">
gap> # <Section Label="Example20"><Heading>The dihedral group on a non-cyclic module</Heading>
gap> # In this example (Example 3 from Linton <Cite Key="MR94k:20022"/>),
gap> # the two-sided relations give the group algebra of
gap> # the group with presentation
gap> # <M>\langle a,b\mid a^4=b^2=(ab)^2=1\rangle</M>, the dihedral group of order 8.
gap> # The module under construction is a non-cyclic module,
gap> # obtained by taking two copies of the
gap> # representation of Example <Ref Sect="Example18"/> and fusing
gap> # their one-dimensional submodules.
gap> # <P/>
gap> # Load the package and set the standard infolevel <Ref
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
gap> # Create the free associative algebra to enter the relations in:
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
gap> D:=A^2;;
gap> y:=GeneratorsOfLeftModule(D);;
gap> #
gap> # (Sept. 2023) The following GBNP.SetOption command has been added
gap> # because the PrintNPList(modrelsNP); command below was throwing
gap> # an error, printing [ b - 1 ] instead of [ b - 1, 0].
gap> # This was due to GAP not knowing that the dimension is 2.
gap> # The fix is labelled 'temporary' because SetOption commands
gap> # ought not to be used in a test situation.
gap> #
gap> GBNP.SetOption("pg", Length(y));
gap> modrels:=[y[1]*b-y[1], y[2]*b-y[2], y[1]+y[1]*a*(e+a+b) -y[2]-y[2]*a*(e+a+b)];;
gap> # </L>
gap> 
gap> # First the relations are converted into NP format (see <Ref Sect="NP"/>) with
gap> # the function <Ref Func="GP2NPList" Style="Text"/>.
gap> # They are printed in raw form and subsequently
gap> # in a more legible format.
gap> 
gap> # <L>
gap> modrelsNP:=GP2NPList(modrels);
[ [ [ [ -1, 2 ], [ -1 ] ], [ 1, -1 ] ], [ [ [ -2, 2 ], [ -2 ] ], [ 1, -1 ] ],
  [ [ [ -1, 1, 2 ], [ -1, 1, 1 ], [ -2, 1, 2 ], [ -2, 1, 1 ], [ -1, 1 ],
          [ -2, 1 ], [ -1 ], [ -2 ] ], [ 1, 1, -1, -1, 1, -1, 1, -1 ] ] ]
gap> PrintNPList(modrelsNP);
[ b - 1 , 0]
[ 0, b - 1 ]
[ ab + a^2 + a + 1 , - ab - a^2 - a - 1 ]
gap> # </L>
gap> 
gap> # Next the function
gap> # <Ref Func="SGrobnerModule" Style="Text"/> is called to calculate a Gröbner basis
gap> # record (see <Ref Sect="GBR"/>).
gap> 
gap> # <L>
gap> GBR:=SGrobnerModule(modrelsNP,GP2NPList(twosidrels));;
#I  number of entered polynomials is 3
#I  number of polynomials after reduction is 3
#I  End of phase I
#I  End of phase II
#I  End of phase III
#I  End of phase IV
#I  number of entered polynomials is 9
#I  number of polynomials after reduction is 9
#I  End of phase I
#I  End of phase II
#I  End of phase III
#I  End of phase IV
gap> # </L>
gap> 
gap> # The record <C>GBR</C> has two members: the two-sided relations <C>GBR.ts</C>
gap> # and the prefix relations <C>GBR.p</C>. It is possible to print these using
gap> # the function <Ref Func="PrintNPList" Style="Text"/>:
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
[ 0, b - 1 ]
[ b - 1 , 0]
[ ab + a^2 + a + 1 , - ab - a^2 - a - 1 ]
[ 0, a^3 - ab ]
[ 0, a^2b - a^2 ]
[ a^3 + a^2 + a + 1 , - ab - a^2 - a - 1 ]
[ a^2b - a^2 , 0]
gap> # </L>
gap> 
gap> # It is now possible to calculate the standard basis of the quotient module
gap> # with the function <Ref Func="BaseQM" Style="Text"/>. This function has as
gap> # arguments the Gröbner basis record <C>GBR</C>, the number of generators of
gap> # the algebra (in this case 2),
gap> # the number of generators of
gap> # the module (in this case 2), and a variable <C>maxno</C> for returning
gap> # partial bases (0 means full basis).
gap> 
gap> # <L>
gap> B:=BaseQM(GBR,2,2,0);;
gap> PrintNPList(B);
[ 0, 1 ]
[ 1 , 0]
[ 0, a ]
[ a , 0]
[ 0, a^2 ]
[ 0, ab ]
[ a^2 , 0]
gap> # </L>
gap> 
gap> # It is also possible to convert each member of the list <C>B</C> of
gap> # polynomials in NP form to GAP polynomials to do further calculations within
gap> # the algebra or module. This can be done with the function <Ref
gap> # Func="NP2GPList" Style="Text"/>.
gap> 
gap> # <L>
gap> NP2GPList(B,D);
[ [ <zero> of ..., (1)*<identity ...> ], [ (1)*<identity ...>, <zero> of ... ]
    , [ <zero> of ..., (1)*a ], [ (1)*a, <zero> of ... ],
  [ <zero> of ..., (1)*a^2 ], [ <zero> of ..., (1)*a*b ],
  [ (1)*a^2, <zero> of ... ] ]
gap> # </L>
gap> 
gap> # Individual GAP polynomials can be
gap> # obtained from polynomials in NP form
gap> # with the function <Ref Func="NP2GP" Style="Text"/>.
gap> # This also holds for elements of the free module <C>D</C>
gap> # in NP form.
gap> 
gap> # <L>
gap> Display(NP2GP(B[Length(B)],D));
[ (1)*a^2, <zero> of ... ]
gap> # </L>
gap> 
gap> # Next we write down the matrices for the right action of the generators
gap> # on the module by means of
gap> # <Ref Func="MatrixQA" Style="Text"/>.
gap> 
gap> # <L>
gap> Display(MatrixQA(1,B,GBR));
[ [   0,   0,   1,   0,   0,   0,   0 ],
  [   0,   0,   0,   1,   0,   0,   0 ],
  [   0,   0,   0,   0,   1,   0,   0 ],
  [   0,   0,   0,   0,   0,   0,   1 ],
  [   0,   0,   0,   0,   0,   1,   0 ],
  [   1,   0,   0,   0,   0,   0,   0 ],
  [   1,  -1,   1,  -1,   1,   1,  -1 ] ]
gap> Display(MatrixQA(2,B,GBR));
[ [   1,   0,   0,   0,   0,   0,   0 ],
  [   0,   1,   0,   0,   0,   0,   0 ],
  [   0,   0,   0,   0,   0,   1,   0 ],
  [   1,  -1,   1,  -1,   1,   1,  -1 ],
  [   0,   0,   0,   0,   1,   0,   0 ],
  [   0,   0,   1,   0,   0,   0,   0 ],
  [   0,   0,   0,   0,   0,   0,   1 ] ]
gap> # </L>
gap> 
gap> # In order to compute the image of the vector  <M>2y[1]+3y[2]</M> of the two standard generators of the module
gap> # under the action of the element <M>aab</M>, we use
gap> # <Ref Func="StrongNormalFormNPM" Style="Text"/>. Its first argument will be the vector
gap> # and its second the Gröbner basis.
gap> # The transformation <Ref Func="GP2NP" Style="Text"/> to the NP format
gap> # needs to be applied to the vector
gap> # before it can be used as an argument.
gap> # <L>
gap> v:=StrongNormalFormNPM(GP2NP((y[1]*2+y[2]*3)*a*a*b), GBR);;
gap> PrintNP(v);
[ 2a^2 , 3a^2 ]
gap> # </L>
gap> 
gap> 
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> 
gap> 
gap> 
gap> STOP_TEST("test20.g",10000);
