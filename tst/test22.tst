gap> START_TEST("GBNP test22");
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
gap> ### filename = "example22.g"
gap> ### author Knopper
gap> 
gap> ### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES
gap> 
gap> # <#GAPDoc Label="Example22">
gap> # <Section Label="Example22"><Heading>A module of the Hecke algebra of type
gap> # A<M>_3</M> over GF(3)</Heading>
gap> # This example is an extension of Example 5 from
gap> # Linton, <Cite Key="MR94k:20022"/>. It concerns
gap> # the Hecke Algebra of type A<M>_3</M>. By reducing mod 3 but without
gap> # evaluating at <M>q=1</M> it is possible to obtain the following
gap> # representation of the Hecke algebra of type A<M>_3</M> over GF(3): <M>\langle
gap> # x, y, z\mid x^2+(1-q)*x-q,y^2+(1-q)*y-q,z^2+(1-q)*z-q,y*x*y-x*y*x, z*y*z-y*z*y,
gap> # z*x-x*z\rangle</M>. It has a natural representation of the same dimension as
gap> # the Lie algebra of type A<M>_3</M>, namely 4. This representation can be
gap> # obtained with the module relations <M>\{x+1,y+1\}</M>.
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
gap> # it is possible to enter it with and without a module. Both are used in
gap> # Example <Ref Sect="Example18"/>. Here the relations will be entered
gap> # without using a module. First a free associative algebra with one is created
gap> # over the field (GF(3))
gap> # (see also <Ref BookName="Reference" Label="FreeAssociativeAlgebraWithOne"/>).
gap> # For convenience we use the
gap> # variables <C>a</C> and <C>b</C> for the generators of the algebra and
gap> # <C>e</C> for the one of the algebra.
gap> 
gap> # <L>
gap> q:=Indeterminate(GF(3),"q");
q
gap> A:=FreeAssociativeAlgebraWithOne(Field(q), "x", "y", "z");;
gap> g:=GeneratorsOfAlgebra(A);;
gap> x:=g[2];;y:=g[3];;z:=g[4];;e:=g[1];;q:=q*e;;
gap> # </L>
gap> 
gap> 
gap> # In order to print the variables like they are printed in the algebra <C>A</C>
gap> # with the function <Ref Func="GBNP.ConfigPrint" Style="Text"/>:
gap> 
gap> # <L>
gap> GBNP.ConfigPrint(A);
gap> # </L>
gap> 
gap> # Now the relations are entered:
gap> 
gap> # <L>
gap> twosidrels:=[x^2+(e-q)*x-q,y^2+(e-q)*y-q,z^2+(e-q)*z-q,
>   y*x*y-x*y*x,z*y*z-y*z*y,z*x-x*z];
[ (-q)*<identity ...>+(-q+Z(3)^0)*x+(Z(3)^0)*x^2,
  (-q)*<identity ...>+(-q+Z(3)^0)*y+(Z(3)^0)*y^2,
  (-q)*<identity ...>+(-q+Z(3)^0)*z+(Z(3)^0)*z^2,
  (-Z(3)^0)*x*y*x+(Z(3)^0)*y*x*y, (-Z(3)^0)*y*z*y+(Z(3)^0)*z*y*z,
  (-Z(3)^0)*x*z+(Z(3)^0)*z*x ]
gap> prefixrels:=[x+e,y+e];
[ (Z(3)^0)*<identity ...>+(Z(3)^0)*x, (Z(3)^0)*<identity ...>+(Z(3)^0)*y ]
gap> # </L>
gap> 
gap> # First the relations are converted into NP format (see <Ref Sect="NP"/>) after
gap> # which the function <Ref Func="SGrobnerModule" Style="Text"/> is called to
gap> # calculate a Gröbner basis record.
gap> 
gap> # <L>
gap> GBR:=SGrobnerModule(GP2NPList(prefixrels),GP2NPList(twosidrels));;
#I  number of entered polynomials is 6
#I  number of polynomials after reduction is 6
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
gap> # The record GBR has three members:
gap> # the two-sided relations <C>GBR.ts</C>, the
gap> # prefix relations <C>GBR.p</C>, and the number <C>GBR.pg</C> of generators
gap> # of the free
gap> # module. It is possible to print the first two using the
gap> # function <Ref Func="PrintNPList" Style="Text"/>:
gap> 
gap> # <L>
gap> PrintNPList(GBR.ts);
 x^2 + -q+Z(3)^0x + -q
 y^2 + -q+Z(3)^0y + -q
 zx + -Z(3)^0xz
 z^2 + -q+Z(3)^0z + -q
 yxy + -Z(3)^0xyx
 zyz + -Z(3)^0yzy
 zyxz + -Z(3)^0yzyx
gap> PrintNPList(GBR.p);
[ x + Z(3)^0 ]
[ y + Z(3)^0 ]
gap> # </L>
gap> 
gap> # It is now possible to calculate the standard basis of the quotient module
gap> # with the function <Ref Func="BaseQM" Style="Text"/>. This function has as
gap> # arguments the Gröbner basis record <C>GBR</C>, the number of generators of
gap> # the algebra (here this is 3), the number of generators of
gap> # the module (here this is 1), and a variable <C>maxno</C> for returning
gap> # partial bases (0 means full basis).
gap> 
gap> # <L>
gap> B:=BaseQM(GBR,3,1,0);;
gap> PrintNPList(B);
[ Z(3)^0 ]
[ z ]
[ zy ]
[ zyx ]
gap> # </L>
gap> 
gap> # Next we write down the matrices for the right action of the generators
gap> # on the module, by means of the command
gap> # <Ref Func="MatricesQA" Style="Text"/>.
gap> 
gap> # <L>
gap> MM := MatricesQA(3,B,GBR);;
gap> for i in [1..Length(MM)] do
> Display(MM[i]); Print("\n");
> od;
[ [   -Z(3)^0,    0*Z(3),    0*Z(3),    0*Z(3) ],
  [    0*Z(3),   -Z(3)^0,    0*Z(3),    0*Z(3) ],
  [    0*Z(3),    0*Z(3),    0*Z(3),    Z(3)^0 ],
  [    0*Z(3),    0*Z(3),         q,  q-Z(3)^0 ] ]

[ [   -Z(3)^0,    0*Z(3),    0*Z(3),    0*Z(3) ],
  [    0*Z(3),    0*Z(3),    Z(3)^0,    0*Z(3) ],
  [    0*Z(3),         q,  q-Z(3)^0,    0*Z(3) ],
  [    0*Z(3),    0*Z(3),    0*Z(3),   -Z(3)^0 ] ]

[ [    0*Z(3),    Z(3)^0,    0*Z(3),    0*Z(3) ],
  [         q,  q-Z(3)^0,    0*Z(3),    0*Z(3) ],
  [    0*Z(3),    0*Z(3),   -Z(3)^0,    0*Z(3) ],
  [    0*Z(3),    0*Z(3),    0*Z(3),   -Z(3)^0 ] ]

gap> # </L>
gap> 
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> STOP_TEST("test22.g",10000);
