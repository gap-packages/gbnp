gap> START_TEST("GBNP test16");
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
gap> ### filename = "example16.g"
gap> ### authors Cohen & Gijsbers & Krook
gap> 
gap> ### THIS IS A GAP PACKAGE GBNP
gap> ### FOR COMPUTING WITH NON-COMMUTATIVE POLYNOMIALS
gap> ### ADD-ON: STUDY GROWTH OF FACTOR ALGEBRA
gap> 
gap> 
gap> # <#GAPDoc Label="Example16">
gap> # <Section Label="Example16"><Heading>A commutative quotient algebra of polynomial growth</Heading>
gap> # This example extends <Ref Sect="Example06"/>,
gap> # a commutative example from Some Tapas of Computer Algebra <Cite
gap> # Key="CohenCuypersSterk1999"/>, page 339.
gap> # <P/>
gap> # The result of the Gröbner basis computation
gap> # should be the union of <M>\{a,b\}</M> and
gap> # the set of 6 homogeneous binomials
gap> # (that is, polynomials with two terms) of degree 2 forcing
gap> # commuting between <M>c</M>, <M>d</M>, <M>e</M>, and <M>f</M>, as before.
gap> # After computation of the Gröbner basis, the quotient algebra is studied and
gap> # found to be infinite dimensional of polynomial growth of degree 4. The
gap> # function <Ref Func="DetermineGrowthQA" Style="Text"/> is used for this
gap> # computation. Then part of its Hilbert series is computed. The function <Ref
gap> # Func="HilbertSeriesQA" Style="Text"/> is used for the computations.
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
gap> # The function <C>powermon(i, exp)</C> will return the monomial <M>i^{exp}</M>.
gap> # The function <C>comm(aa, bb)</C> will return a relation forcing commutativity
gap> # between its two arguments <C>aa</C> and <C>bb</C>.
gap> 
gap> # <L>
gap> powermon := function(base, exp)
>  local ans,i;
>  ans := [];
>  for i in [1..exp] do ans :=  Concatenation(ans,[base]); od;
>  return ans;
> end;;
gap> 
gap> comm := function(aa,bb)
>   return [[[aa,bb],[bb,aa]],[1,-1]];
> end;;
gap> # </L>
gap> 
gap> # Now the relations are entered:
gap> 
gap> # <L>
gap> p1 := [[[5,1]],[1]];;
gap> p2 := [[powermon(1,3),[6,1]],[1,1]];;
gap> p3 := [[powermon(1,9),Concatenation([3],powermon(1,3))],[1,1]];;
gap> p4 := [[powermon(1,81),Concatenation([3],powermon(1,9)),Concatenation([4],
>           powermon(1,3))],[1,1,1]];;
gap> p5 := [[Concatenation([3],powermon(1,81)),Concatenation([4],powermon(1,9)),
>           Concatenation([5],powermon(1,3))],[1,1,1]];;
gap> p6 := [[powermon(1,27),Concatenation([4],powermon(1,81)),Concatenation([5],
>           powermon(1,9)),Concatenation([6],powermon(1,3))],[1,1,1,1]];;
gap> p7 := [[powermon(2,1),Concatenation([3],powermon(1,27)),Concatenation([5],
>           powermon(1,81)),Concatenation([6],powermon(1,9))],[1,1,1,1]];;
gap> p8 := [[Concatenation([3],powermon(2,1)),Concatenation([4],powermon(1,27)),
>           Concatenation([6],powermon(1,81))],[1,1,1]];;
gap> p9 := [[Concatenation([],powermon(1,1)),Concatenation([4],powermon(2,1)),
>           Concatenation([5],powermon(1,27))],[1,1,1]];;
gap> p10 := [[Concatenation([3],powermon(1,1)),Concatenation([5],powermon(2,1)),
>           Concatenation([6],powermon(1,27))],[1,1,1]];;
gap> p11 := [[Concatenation([4],powermon(1,1)),Concatenation([6],powermon(2,1))],
>           [1,1]];;
gap> p12 := [[Concatenation([],powermon(2,3)),Concatenation([],powermon(2,1))],
>           [1,-1]];;
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
gap> # add the next command in case other tests have changed the alphabet:
gap> GBNP.ConfigPrint("a","b","c","d","e","f");
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
gap> # </L>
gap> 
gap> # It is usually easier to use the function <Ref Func="GP2NP" Style="Text"/> or
gap> # the function <Ref Func="GP2NPList" Style="Text"/> to enter relations.
gap> # Entering the first twelve relations and then converting them with <Ref
gap> # Func="GP2NPList" Style="Text"/> is demonstrated in example 6 (<Ref
gap> # Sect="Example06"/>). More about converting can be read in Section <Ref
gap> # Sect="TransitionFunctions"/>.
gap> # <P/>
gap> # The Gröbner basis can now be calculated with <Ref Func="SGrobner"
gap> # Style="Text"/> and printed with <Ref Func="PrintNPList" Style="Text"/>.
gap> 
gap> # <L>
gap> GB := SGrobner(KI);
#I  number of entered polynomials is 27
#I  number of polynomials after reduction is 8
#I  End of phase I
#I  End of phase II
#I  List of todo lengths is [ 0 ]
#I  End of phase III
#I  G: Cleaning finished, 0 polynomials reduced
#I  End of phase IV
[ [ [ [ 1 ] ], [ 1 ] ], [ [ [ 2 ] ], [ 1 ] ],
  [ [ [ 4, 3 ], [ 3, 4 ] ], [ 1, -1 ] ], [ [ [ 5, 3 ], [ 3, 5 ] ], [ 1, -1 ] ]
    , [ [ [ 5, 4 ], [ 4, 5 ] ], [ 1, -1 ] ],
  [ [ [ 6, 3 ], [ 3, 6 ] ], [ 1, -1 ] ], [ [ [ 6, 4 ], [ 4, 6 ] ], [ 1, -1 ] ]
    , [ [ [ 6, 5 ], [ 5, 6 ] ], [ 1, -1 ] ] ]
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
gap> # The growth of the quotient algebra can be studied with <Ref
gap> # Func="DetermineGrowthQA" Style="Text"/>. The first argument is the list
gap> # of leading
gap> # monomials, which can be calculated with <Ref Func="LMonsNP" Style="Text"/>.
gap> # The second argument is the size of the alphabet.
gap> 
gap> # <L>
gap> L:=LMonsNP(GB);;
gap> DetermineGrowthQA(L,6,false);
4
gap> # </L>
gap> 
gap> # Now compute the first 10 terms of the Hilbert Series with <Ref
gap> # Func="HilbertSeriesQA" Style="Text"/>
gap> # (note that trailing zeroes are removed):
gap> 
gap> # <L>
gap> HilbertSeriesQA(L,6,10);
[ 1, 4, 10, 20, 35, 56, 84, 120, 165, 220, 286 ]
gap> # </L>
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> STOP_TEST("test16.g",10000);
