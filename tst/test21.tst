gap> START_TEST("GBNP test21");
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
gap> ### filename = "example21.g"
gap> ### author Knoppe21
gap> 
gap> ### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES
gap> 
gap> # <#GAPDoc Label="Example21">
gap> # <Section Label="Example21"><Heading>The symmetric inverse monoid for a set of size four</Heading>
gap> # The algebra we will consider is from Example 4 from Linton <Cite Key="MR94k:20022"/>.
gap> # Its monomials form the symmetric inverse monoid, that is, the monoid of all
gap> # partial bijections on a given set, for a set of size four. The presentation
gap> # is <M>\langle s_1,s_2,s_3,e\mid s_i^2=(s_1s_2)^3=(s_2s_3)^3=(s_1s_3)^2=1, e^2=e,
gap> # s_1e=es_1,s_2e=es_2,es_3e=(es_3)^2=(s_3e)^2\rangle</M>. The dimension of the
gap> # monoid algebra is 209. The monoid has a natural representation of degree 4 by means of
gap> # partial permutation matrices, which can be obtained by taking
gap> # prefix relations <M>\{e,s_1-1, s_2-1, s_3e-s_3\}</M>.
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
gap> # Now enter the relations as GAP polynomials. The module is one dimensional so
gap> # it is possible to enter it with and without a module. In Example 18 (<Ref
gap> # Sect="Example18"/>) both ways are shown. Here the relations will be entered
gap> # without a module, with a free associative algebra with one over the field
gap> # (the rational numbers) (see also <Ref BookName="Reference"
gap> # Label="FreeAssociativeAlgebraWithOne"/>). For convenience we use the
gap> # variables <C>s1</C>, <C>s2</C>, <C>s3</C>, and <C>e</C> for the generators of
gap> # the algebra, and <C>o</C> for the identity element of the algebra.
gap> 
gap> # <L>
gap> A:=FreeAssociativeAlgebraWithOne(Rationals, "s1", "s2", "s3", "e");
<algebra-with-one over Rationals, with 4 generators>
gap> g:=GeneratorsOfAlgebra(A);;
gap> s1:=g[2];;s2:=g[3];;s3:=g[4];;e:=g[5];;o:=g[1];;
gap> # </L>
gap> 
gap> # It is possible to print symbols like they are printed in the algebra <C>A</C>
gap> # with the function <Ref Func="GBNP.ConfigPrint" Style="Text"/>:
gap> 
gap> # <L>
gap> GBNP.ConfigPrint(A);
gap> # </L>
gap> 
gap> # Now the relations are entered:
gap> 
gap> # <L>
gap> twosidrels:=[s1^2-o,s2^2-o,s3^2-o,(s1*s2)^3-o,(s2*s3)^3-o,(s1*s3)^2-o,
>   e^2-e,s1*e-e*s1,s2*e-e*s2,e*s3*e-(e*s3)^2,e*s3*e-(s3*e)^2];
[ (-1)*<identity ...>+(1)*s1^2, (-1)*<identity ...>+(1)*s2^2,
  (-1)*<identity ...>+(1)*s3^2, (-1)*<identity ...>+(1)*(s1*s2)^3,
  (-1)*<identity ...>+(1)*(s2*s3)^3, (-1)*<identity ...>+(1)*(s1*s3)^2,
  (-1)*e+(1)*e^2, (1)*s1*e+(-1)*e*s1, (1)*s2*e+(-1)*e*s2,
  (1)*e*s3*e+(-1)*(e*s3)^2, (1)*e*s3*e+(-1)*(s3*e)^2 ]
gap> prefixrels:=[e,s1-o,s2-o,s3*e-s3];
[ (1)*e, (-1)*<identity ...>+(1)*s1, (-1)*<identity ...>+(1)*s2,
  (-1)*s3+(1)*s3*e ]
gap> # </L>
gap> 
gap> # First the relations are converted into NP format (see <Ref Sect="NP"/>) and
gap> # next the function <Ref Func="SGrobnerModule" Style="Text"/> is called to
gap> # calculate a Gröbner basis record.
gap> 
gap> # <L>
gap> GBR:=SGrobnerModule(GP2NPList(prefixrels),GP2NPList(twosidrels));;
#I  number of entered polynomials is 11
#I  number of polynomials after reduction is 11
#I  End of phase I
#I  End of phase II
#I  End of phase III
#I  End of phase IV
#I  number of entered polynomials is 42
#I  number of polynomials after reduction is 42
#I  End of phase I
#I  End of phase II
#I  End of phase III
#I  End of phase IV
gap> # </L>
gap> 
gap> # The record GBR has two members: the two-sided relations <C>GBR.ts</C> and the
gap> # prefix relations <C>GBR.p</C>. We print these using the
gap> # function <Ref Func="PrintNPList" Style="Text"/>:
gap> 
gap> # <L>
gap> PrintNPList(GBR.ts);
 s1^2 - 1
 s2^2 - 1
 s3s1 - s1s3
 s3^2 - 1
 es1 - s1e
 es2 - s2e
 e^2 - e
 s2s1s2 - s1s2s1
 s3s2s3 - s2s3s2
 s3s2s1s3 - s2s3s2s1
 s3es3e - es3e
 es3es3 - es3e
 s3es3s2e - es3s2e
 s2s3s2es3e - s3s2es3e
 s3es3s2s1e - es3s2s1e
 es3s2es3s2 - es3s2es3
 s2s3s2s1es3e - s3s2s1es3e
 s2s3s2es3s2e - s3s2es3s2e
 s2es3s2es3e - es3s2es3e
 s1s2s1s3s2es3e - s2s1s3s2es3e
 s2s3s2s1es3s2e - s3s2s1es3s2e
 s2s3s2es3s2s1e - s3s2es3s2s1e
 s2es3s2s1es3e - es3s2s1es3e
 es3s2s1es3s2s1 - es3s2s1es3s2
 s1s2s1s3s2s1es3e - s2s1s3s2s1es3e
 s1s2s1s3s2es3s2e - s2s1s3s2es3s2e
 s1s2s1es3s2es3e - s2s1es3s2es3e
 s2s3s2s1es3s2s1e - s3s2s1es3s2s1e
 s2es3s2s1es3s2e - es3s2s1es3s2e
 s1s2s1s3s2s1es3s2e - s2s1s3s2s1es3s2e
 s1s2s1s3s2es3s2s1e - s2s1s3s2es3s2s1e
 s1s2s1es3s2s1es3e - s2s1es3s2s1es3e
 s1s3s2s1es3s2es3e - s3s2s1es3s2es3e
 s1s2s1s3s2s1es3s2s1e - s2s1s3s2s1es3s2s1e
 s1s2s1es3s2s1es3s2e - s2s1es3s2s1es3s2e
 s1s3s2s1es3s2s1es3e - s3s2s1es3s2s1es3e
 s1es3s2s1es3s2es3e - es3s2s1es3s2es3e
 s1s3s2s1es3s2s1es3s2e - s3s2s1es3s2s1es3s2e
gap> PrintNPList(GBR.p);
[ s1 - 1 ]
[ s2 - 1 ]
[ e ]
[ s3e - s3 ]
[ s3s2e - s3s2 ]
[ s3s2s1e - s3s2s1 ]
gap> # </L>
gap> 
gap> # It is now possible to calculate the standard basis of the quotient module
gap> # with the function <Ref Func="BaseQM" Style="Text"/>. This function has as
gap> # arguments the Gröbner basis record <C>GBR</C>, the number of generators of
gap> # the algebra (here this is 4), the number of generators of
gap> # the module (here this is 1),  and
gap> # a variable <C>maxno</C> for returning partial bases (0 means full
gap> # basis).
gap> 
gap> # <L>
gap> B:=BaseQM(GBR,4,1,0);;
gap> PrintNPList(B);
[ 1 ]
[ s3 ]
[ s3s2 ]
[ s3s2s1 ]
gap> # </L>
gap> 
gap> 
gap> # Next we write down the matrices for the right action of the generators
gap> # on the module. First by means of the list command
gap> # <Ref Func="MatricesQA" Style="Text"/>, next one by one by means of
gap> # <Ref Func="MatrixQA" Style="Text"/> within a loop.
gap> 
gap> # <L>
gap> MatricesQA(4,B,GBR);
[ [ [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 0, 1 ], [ 0, 0, 1, 0 ] ],
  [ [ 1, 0, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 0, 1 ] ],
  [ [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ],
  [ [ 0, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ] ]
gap> for i in [1..4] do
>   Display(MatrixQA(i,B,GBR)); Print("\n");
> od;
[ [  1,  0,  0,  0 ],
  [  0,  1,  0,  0 ],
  [  0,  0,  0,  1 ],
  [  0,  0,  1,  0 ] ]

[ [  1,  0,  0,  0 ],
  [  0,  0,  1,  0 ],
  [  0,  1,  0,  0 ],
  [  0,  0,  0,  1 ] ]

[ [  0,  1,  0,  0 ],
  [  1,  0,  0,  0 ],
  [  0,  0,  1,  0 ],
  [  0,  0,  0,  1 ] ]

[ [  0,  0,  0,  0 ],
  [  0,  1,  0,  0 ],
  [  0,  0,  1,  0 ],
  [  0,  0,  0,  1 ] ]

gap> # </L>
gap> 
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> 
gap> STOP_TEST("test21.g",10000);
