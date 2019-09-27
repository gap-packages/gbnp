gap> START_TEST("GBNP test06");
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
gap> # http://www.gnu.org/licenses/lgpl.html
gap> ########################## END COPYRIGHT MESSAGE ##########################
gap> 
gap> ### filename = "example06.g" 
gap> ### authors Cohen & Gijsbers
gap> ### $Id: example06.g,v 1.6 2004/04/16 14:37:37 jwk Exp $
gap> 
gap> ### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES 
gap>  
gap> ### Last change: August 22 2001. 
gap> ### amc
gap> 
gap> # <#GAPDoc Label="Example06">
gap> # <Section Label="Example06"><Heading>From the Tapas book</Heading>
gap> # This example is a standard commutative Gröbner basis computation from the book 
gap> # Some Tapas of Computer Algebra
gap> # <Cite Key="CohenCuypersSterk1999"/>, page 339.
gap> # There are six variables, named <M>a</M>, ... , <M>f</M> by default.
gap> # We work over the rationals and study the ideal generated by the twelve polynomials
gap> # occurring on the middle of page 339 of the Tapas book
gap> # in a project by De Boer and Pellikaan on the ternary cyclic code of length 11.
gap> # Below these are named <C>p1</C>, ..., <C>p12</C>.
gap> # The result should be the union of <M>\{a,b\}</M> and
gap> # the set of 6 homogeneous binomials 
gap> # (that is, polynomials with two terms) of degree 2 forcing
gap> # commuting between <M>c</M>, <M>d</M>, <M>e</M>, and <M>f</M>. 
gap> # <P/>
gap> 
gap> # <!--
gap> # a = 1
gap> # b = 2
gap> # sigma_i = i+2 (i=1,2,3,4) = c,d,e,f -->
gap> 
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
gap> # Now define some functions which will help in the construction of relations.
gap> # The function <C>powermon(g, exp)</C> will return the monomial <M>g^{exp}</M>.
gap> # The function <C>comm(a, b)</C> will return a relation forcing commutativity
gap> # between its two arguments <C>a</C> and <C>b</C>.
gap> 
gap> # <L>
gap> powermon := function(base, exp)
>  local ans,i;
>  ans := [];
>  for i in [1..exp] do ans :=  Concatenation(ans,[base]); od;
>  return ans;
> end;;
gap> 
gap> comm := function(a,b)
>   return [[[a,b],[b,a]],[1,-1]];
> end;;
gap> # </L>
gap> 
gap> # Now the relations are entered.
gap> 
gap> # <L>
gap> p1 := [[[5,1]],[1]];;
gap> p2 := [[powermon(1,3),[6,1]],[1,1]];;
gap> p3 := [[powermon(1,9),Concatenation([3],powermon(1,3))],[1,1]];;
gap> p4 := [[powermon(1,81),Concatenation([3],powermon(1,9)),
> 	Concatenation([4],powermon(1,3))],[1,1,1]];;
gap> p5 := [[Concatenation([3],powermon(1,81)),Concatenation([4],powermon(1,9)),
> 	Concatenation([5],powermon(1,3))],[1,1,1]];;
gap> p6 := [[powermon(1,27),Concatenation([4],powermon(1,81)),Concatenation([5],
> 	powermon(1,9)),Concatenation([6],powermon(1,3))],[1,1,1,1]];;
gap> p7 := [[powermon(2,1),Concatenation([3],powermon(1,27)),Concatenation([5],
> 	powermon(1,81)),Concatenation([6],powermon(1,9))],[1,1,1,1]];;
gap> p8 := [[Concatenation([3],powermon(2,1)),Concatenation([4],powermon(1,27)),
> 	Concatenation([6],powermon(1,81))],[1,1,1]];;
gap> p9 := [[Concatenation([],powermon(1,1)),Concatenation([4],powermon(2,1)),
> 	Concatenation([5],powermon(1,27))],[1,1,1]];;
gap> p10 := [[Concatenation([3],powermon(1,1)),Concatenation([5],powermon(2,1)),
> 	Concatenation([6],powermon(1,27))],[1,1,1]];;
gap> p11 := [[Concatenation([4],powermon(1,1)),Concatenation([6],powermon(2,1))],
> 	[1,1]];;
gap> p12 := [[Concatenation([],powermon(2,3)),Concatenation([],powermon(2,1))],
> 	[1,-1]];;
gap> KI := [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12];;
gap> for i in [1..5] do
>     for j in [i+1..6] do
>         Add(KI,comm(i,j));
>     od;
> od;
gap> # </L>
gap> 
gap> # The relations can be shown with <Ref Func="PrintNPList" Style="Text"/>:
gap> 
gap> # <L>
gap> PrintNPList(KI);
 ea 
 a^3 + fa 
 a^9 + ca^3 
 a^81 + ca^9 + da^3 
 ca^81 + da^9 + ea^3 
 a^27 + da^81 + ea^9 + fa^3 
 b + ca^27 + ea^81 + fa^9 
 cb + da^27 + fa^81 
 a + db + ea^27 
 ca + eb + fa^27 
 da + fb 
 b^3 - b 
 ab - ba 
 ac - ca 
 ad - da 
 ae - ea 
 af - fa 
 bc - cb 
 bd - db 
 be - eb 
 bf - fb 
 cd - dc 
 ce - ec 
 cf - fc 
 de - ed 
 df - fd 
 ef - fe 
gap> Length(KI);
27
gap> # </L>
gap> 
gap> # It is sometimes easier to enter the relations as elements of a free algebra
gap> # and then use the function <Ref Func="GP2NP" Style="Text"/> or the function
gap> # <Ref Func="GP2NPList" Style="Text"/> to convert them. 
gap> # This will be demonstrated below. More about converting can be read
gap> # in Section <Ref Sect="TransitionFunctions"/>.
gap> 
gap> # <L>
gap> F:=Rationals;;
gap> A:=FreeAssociativeAlgebraWithOne(F,"a","b","c","d","e","f");;
gap> a:=A.a;; b:=A.b;; c:=A.c;; d:=A.d;; e:=A.e;; f:=A.f;;
gap> KI_gp:=[e*a,                         #p1
>         a^3 + f*a,                      #p2
>         a^9 + c*a^3,                    #p3
>         a^81 + c*a^9 + d*a^3,           #p4
>         c*a^81 + d*a^9 + e*a^3,         #p5
>         a^27 + d*a^81 + e*a^9 + f*a^3,  #p6
>         b + c*a^27 + e*a^81 + f*a^9,    #p7
>         c*b + d*a^27 + f*a^81,          #p8
>         a + d*b + e*a^27,               #p9
>         c*a + e*b + f*a^27,             #p10
>         d*a + f*b,                      #p11
>         b^3 - b];;                      #p12
gap> # </L>
gap> 
gap> # These relations can be converted to NP form (see <Ref Sect="NP"/>) with <Ref
gap> # Func="GP2NPList" Style="Text"/>. For use in a Gröbner basis computation we have to
gap> # order the NP polynomials in <C>KI</C>.
gap> # This can be done with <Ref Func="CleanNP" Style="Text"/>.
gap> 
gap> # <L>
gap> KI_np:=GP2NPList(KI_gp);;
gap> Apply(KI,x->CleanNP(x));;
gap> KI_np=KI{[1..12]};
true
gap> # </L>
gap> 
gap> # The Gröbner basis can now be calculated with <Ref Func="SGrobner"
gap> # Style="Text"/> and printed with <Ref Func="PrintNPList" Style="Text"/>.
gap> 
gap> # <L>
gap> GB := SGrobner(KI);;
#I  number of entered polynomials is 27
#I  number of polynomials after reduction is 8
#I  End of phase I
#I  End of phase II
#I  List of todo lengths is [ 0 ]
#I  End of phase III
#I  G: Cleaning finished, 0 polynomials reduced
#I  End of phase IV
gap> PrintNPList(GB);
 a 
 b 
 dc - cd 
 ec - ce 
 ed - de 
 fc - cf 
 fd - df 
 fe - ef 
gap> # </L>
gap> 
gap> 
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> STOP_TEST("test06.g",10000);
