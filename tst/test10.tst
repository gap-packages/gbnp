gap> START_TEST("GBNP test10");
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
gap> 
gap> # <#GAPDoc Label="Example10">
gap> # <Section Label="Example10"><Heading>A commutative example by Mora</Heading>
gap> # Here we present a commutative example from page 339 of
gap> # <Q>An introduction to commutative and non-commutative Gröbner Bases</Q>, by
gap> # Teo Mora <Cite Key="TCS::Mora1994:131"/>.
gap> # It involves the seven variables <M>a,b,c,d,e,f,g</M>.
gap> # In order to force commuting between each pair from <M>\{a,b,c,d,e,f,g\}</M>,
gap> # we let part of the input equations
gap> # be the homogeneous binomials of the form
gap> # <M>xy - yx</M>.
gap> # GBNP is built for non-commutative polynomial arithmetic, and should handle
gap> # the commutative case by means of this forced commutation. But it should not
gap> # be considered as a serious alternative to the well-known Gröbner bases
gap> # packages when it comes to efficiency.
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
gap> # The relations will be entered as GAP polynomials and converted to NP form
gap> # (see <Ref Sect="NP"/>) with <Ref Func="GP2NPList" Style="Text"/>.
gap> 
gap> # <L>
gap> F:=GF(7);; ef:=One(F);;
gap> A:=FreeAssociativeAlgebraWithOne(F, "a", "b", "c", "d", "e", "f", "g");
<algebra-with-one over GF(7), with 7 generators>
gap> gens:=GeneratorsOfAlgebra(A);
[ (Z(7)^0)*<identity ...>, (Z(7)^0)*a, (Z(7)^0)*b, (Z(7)^0)*c, (Z(7)^0)*d,
  (Z(7)^0)*e, (Z(7)^0)*f, (Z(7)^0)*g ]
gap> a:=gens[2];; b:=gens[3];; c:=gens[4];; d:=gens[5];; e:=gens[6];; f:=gens[7];;
gap> g:=gens[8];; ea:=gens[1];;
gap> 
gap> rels := [ a^3 + f*a,
>              a^9 + c*a^3 + g*a,
>              a^81 + c*a^9 + d*a^3,
>              c*a^81 + d*a^9 + e*a^3,
>              a^27 + d*a^81 + e*a^9 + f*a^3,
>              b + c*a^27 + e*a^81 + f*a^9 + g*a^3,
>              c*b + d*a^27 + f*a^81 + g*a^9,
>              a + d*b + e*a^27 + g*a^81,
>              c*a + e*b + f*a^27,
>              d*a + f*b + g*a^27,
>              e*a + g*b,
>              b^3 - b ];;
gap> # </L>
gap> 
gap> # Some relations added to enforce commutativity.
gap> 
gap> # <L>
gap> for i in [1..6] do
>     for j in [i+1..7] do
>         Add(rels,gens[i+1]*gens[j+1]-gens[j+1]*gens[i+1]);
>     od;
> od;
gap> # </L>
gap> 
gap> # Now the relations are converted to NP form (see <Ref Sect="NP"/>) with the
gap> # function <Ref Func="GP2NPList" Style="Text"/>.
gap> 
gap> # <L>
gap> KI:=GP2NPList(rels);;
gap> # </L>
gap> 
gap> # The Gröbner basis can be calculated with <Ref Func="SGrobner" Style="Text"/>
gap> # and printed with <Ref Func="PrintNPList" Style="Text"/>.
gap> 
gap> # <L>
gap> GB := SGrobner(KI);;
#I  number of entered polynomials is 33
#I  number of polynomials after reduction is 33
#I  End of phase I
#I  End of phase II
#I  End of phase III
#I  End of phase IV
gap> # add the next command in case other tests have changed the alphabet:
gap> GBNP.ConfigPrint("a","b","c","d","e","f","g");
gap> PrintNPList(GB);
 a
 b
 dc + Z(7)^3cd
 ec + Z(7)^3ce
 ed + Z(7)^3de
 fc + Z(7)^3cf
 fd + Z(7)^3df
 fe + Z(7)^3ef
 gc + Z(7)^3cg
 gd + Z(7)^3dg
 ge + Z(7)^3eg
 gf + Z(7)^3fg
gap> # </L>
gap> 
gap> 
gap> # To determine whether the quotient algebra is finite dimensional
gap> # we invoke <Ref Func="FinCheckQA" Style="Text"/>, using as arguments
gap> # the leading monomials of <C>GB</C> and 7, the number of variables involved.
gap> # The leading monomials of <C>GB</C> are obtained by
gap> # <Ref Func="LMonsNP" Style="Text"/>.
gap> 
gap> # <L>
gap> F := LMonsNP(GB);;
gap> FinCheckQA(F,7);
false
gap> # </L>
gap> 
gap> 
gap> # Thus, the quotient algebra turns out to be infinite dimensional.
gap> # This is no surprise as the Gröbner basis shows it is actually
gap> # the free commutative algebra generated by <M>c,d,e,f,g</M>.
gap> # In particular, it has polynomial growth of degree 5. This is confirmed
gap> # by application of
gap> # <Ref Func="DetermineGrowthQA" Style="Text"/>, with the first two arguments
gap> # as for <C>FinCheckQA</C> above and third argument <C>false</C>, indicating
gap> # that an interval for the degree of the polynomial degree will suffice.
gap> # <L>
gap> DetermineGrowthQA(F,7,false);
5
gap> # </L>
gap> # It turns out that this quick version already gives an exact answer.
gap> # More time consuming would be the algorithm run with third argument
gap> # equal to <C>true</C>.
gap> # <L>
gap> DetermineGrowthQA(F,7,true);
5
gap> # </L>
gap> 
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> STOP_TEST("test10.g",10000);
