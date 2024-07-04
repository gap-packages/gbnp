gap> START_TEST("GBNP test04");
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
gap> ### filename = "Icosahedron.g"
gap> ### author Arjeh M. Cohen
gap> 
gap> # <#GAPDoc Label="Example04">
gap> # <Section Label="Example04">
gap> # <Heading>The icosahedral group</Heading>
gap> # In this example
gap> # the two-sided relations give the group algebra of
gap> # the group with presentation
gap> # <M>\langle a,b,c \mid a^2=b^2=c^2=(ab)^3=(bc)^5=(ac)^2=1\rangle</M>,
gap> # the icosahedral group of order 120.
gap> # This is the Coxeter group of type H<M>_3</M>.
gap> # The module under construction is a 3-dimensional reflection representation,
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
gap> # Create the field containing the golden ratio <C>tau</C>.
gap> 
gap> # <L>
gap> x := Indeterminate(Rationals,"x");
x
gap> p := x^2+ x-1;
x^2+x-1
gap> K := AlgebraicExtension(Rationals,p);
<algebraic extension over the Rationals of degree 2>
gap> tau:=RootOfDefiningPolynomial(K);
a
gap> # </L>
gap> 
gap> # Create the free algebra with three generators over this field:
gap> 
gap> # <L>
gap> A:=FreeAssociativeAlgebraWithOne(K, "a", "b", "c");
<algebra-with-one over <algebraic extension over the Rationals of degree
2>, with 3 generators>
gap> e:=One(A);; a:=A.a;; b:=A.b;; c:=A.c;;
gap> # </L>
gap> 
gap> # The ideal for a quotient of the icosahedral group algebra over this field,
gap> # in which <C>b</C><M>*</M><C>c</C> has a quadratic minimal polynomial
gap> # involving <C>tau</C>:
gap> 
gap> # <L>
gap> #(b*c)^2-tau*b*c+e
gap> Irels:=[a^2-e,b^2-e,c^2-e,a*b*a-b*a*b,((b*c)^2-tau*b*c+e)*(b*c-e),a*c-c*a];
[ (!-1)*<identity ...>+(!1)*a^2, (!-1)*<identity ...>+(!1)*b^2,
  (!-1)*<identity ...>+(!1)*c^2, (!1)*a*b*a+(!-1)*b*a*b,
  (!-1)*<identity ...>+(a+1)*b*c+(-a-1)*(b*c)^2+(!1)*(b*c)^3,
  (!1)*a*c+(!-1)*c*a ]
gap> # </L>
gap> 
gap> # We now give module relations. The first two describe group elements
gap> # of a vector stabilizer, the third forces the central element <M>(abc)^5</M>
gap> # to be nontrivial.
gap> 
gap> # <L>
gap> Mrels:=[b*c-e,b-e,(a*b*c)^5+e];;
gap> # </L>
gap> 
gap> # First the relations are converted into NP format (see <Ref Sect="NP"/>) with
gap> # the function <Ref Func="GP2NPList" Style="Text"/>.
gap> # Next the function
gap> # <Ref Func="SGrobnerModule" Style="Text"/> is called to calculate a Gröbner basis
gap> # record (see <Ref Sect="GBR"/>).
gap> 
gap> # <L>
gap> GBR:=SGrobnerModule(GP2NPList(Mrels),GP2NPList(Irels));;
#I  number of entered polynomials is 6
#I  number of polynomials after reduction is 6
#I  End of phase I
#I  End of phase II
#I  End of phase III
#I  End of phase IV
#I  number of entered polynomials is 12
#I  number of polynomials after reduction is 12
#I  End of phase I
#I  End of phase II
#I  End of phase III
#I  End of phase IV
gap> PrintNPList(GBR.ts);;
 a^2 + !-1
 b^2 + !-1
 ca + !-1ac
 c^2 + !-1
 bab + !-1aba
 cbc + !-1bcb + -a-1c + a+1b
 bcba + !-1acba + !-1abcb + abac + cb + !-1bc + -a-2ba + a+2ab
 cbac + !-1acba + !-1abcb + abac + cb + !-1bc + !-1ba + -a-1ac + a+2ab
 bacba + abacb + !-1cba + !-1bcb + !-1abc + -a-2aba + c + a+2a
gap> PrintNPList(GBR.p);;
[ b + !-1 ]
[ c + !-1 ]
[ ac + !-1a ]
[ aba + !-1ab ]
[ abc + ab + -aa + -a ]
gap> # </L>
gap> 
gap> # It is now possible to calculate the basis of the quotient algebra
gap> # with the function <Ref Func="BaseQM" Style="Text"/>. This function has as
gap> # arguments the Gröbner basis record <C>GBR</C>, the number of generators of
gap> # the algebra (in this case 3), the number of generators of the
gap> # free module in which the vectors are chosen (in this case 1),
gap> # and a variable <C>maxno</C> for returning
gap> # partial quotient algebras (0 means full basis).
gap> 
gap> # <L>
gap> B:=BaseQM(GBR,3,1,0);;
gap> PrintNPList(B);
[ !1 ]
[ a ]
[ ab ]
gap> # </L>
gap> 
gap> # Calculate the dimension of the quotient algebra
gap> # with the function <Ref Func="DimQM" Style="Text"/>. This function has as
gap> # arguments the Gröbner basis record <C>GBR</C>,
gap> # the number of generators of
gap> # the algebra (in this case 3) and
gap> # the number of generators of
gap> # the module (in this case 1).
gap> 
gap> 
gap> 
gap> # <L>
gap> DimQM(GBR,3,1);
3
gap> # </L>
gap> 
gap> # Next we write down the matrices for the right action of the generators
gap> # on the module by means of
gap> # <Ref Func="MatrixQA" Style="Text"/>.
gap> 
gap> # <L>
gap> aa := MatrixQA(1,B,GBR);;
gap> Display(aa);
[ [  !0,  !1,  !0 ],
  [  !1,  !0,  !0 ],
  [  !0,  !0,  !1 ] ]
gap> bb := MatrixQA(2,B,GBR);;
gap> Display(bb);
[ [  !1,  !0,  !0 ],
  [  !0,  !0,  !1 ],
  [  !0,  !1,  !0 ] ]
gap> cc := MatrixQA(3,B,GBR);;
gap> Display(cc);
[ [   !1,   !0,   !0 ],
  [   !0,   !1,   !0 ],
  [    a,    a,  !-1 ] ]
gap> # </L>
gap> 
gap> # Finally we check the defining relations for the icosahedral group
gap> # on the three new matrix generators. This can be done by verifying if the
gap> # result is equal to the identity matrix or with the function <Ref
gap> # BookName="Reference" Func="IsOne" Style="Text"/>.
gap> 
gap> # <L>
gap> ee := IdentityMat(3,K);;
gap> Display(ee);
[ [  !1,  !0,  !0 ],
  [  !0,  !1,  !0 ],
  [  !0,  !0,  !1 ] ]
gap> aa^2 = ee;
true
gap> IsOne(aa^2);
true
gap> IsOne(bb^2);
true
gap> IsOne(cc^2);
true
gap> IsOne((aa*bb)^3);
true
gap> IsOne((aa*cc)^2);
true
gap> IsOne((bb*cc)^5);
true
gap> # </L>
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> 
gap> STOP_TEST("test04.g",10000);
