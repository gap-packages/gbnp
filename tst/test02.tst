gap> START_TEST("GBNP test02");
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
gap> ### filename = "example02.g"
gap> ### authors Cohen & Gijsbers
gap> 
gap> ### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES
gap> 
gap> ### Last change: August 29 2001.
gap> ### amc
gap> 
gap> # <#GAPDoc Label="Example02">
gap> # <Section Label="Example02"><Heading>A truncated Gröbner basis for Leonard pairs</Heading>
gap> # To provide Terwilliger with experimental dimension information in low degrees for his theory of Leonard pairs
gap> # a truncated  Gröbner basis computation was carried out as follows.
gap> # <P/>
gap> # First load the package and set the standard infolevel <Ref
gap> # InfoClass="InfoGBNP" Style="Text"/> to 1 and the time infolevel <Ref
gap> # Func="InfoGBNPTime" Style="Text"/> to 2 (for more information about the info
gap> # level, see Chapter <Ref Chap="Info"/>).
gap> 
gap> # <L>
gap> LoadPackage("gbnp", false);
true
gap> SetInfoLevel(InfoGBNP,1);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> # </L>
gap> 
gap> # We truncate the example by putting all monomials of degree <M>n</M> in the
gap> # ideal by means of the function <C>MkTrLst</C> to be introduced below;
gap> # a better way to compute the
gap> # result is by means of the truncated GB algorithms (See <Ref
gap> # Sect="Example12"/>).
gap> # <P/>
gap> # We want to truncate at degree 7 so we have fixed <M>n = 8</M>.
gap> 
gap> # <L>
gap> n := 8;;
gap> # </L>
gap> 
gap> # Now enter the relations in NP form (see <Ref Sect="NP"/>). The function
gap> # <Code>MkTrLst</Code> will be introduced, which will return all monomials of
gap> # degree <C>n</C>. The list of ideal generators of interest is called <C>I</C>.
gap> 
gap> # <L>
gap> sqbr := function(n,q) ; return (q^3-q^-3)/(q-q^(-1)); end;;
gap> 
gap> c := sqbr(3,5);
651/25
gap> 
gap> s1 :=[[[1,1,1,2],[1,1,2,1],[1,2,1,1],[2,1,1,1]],[1,-c,c,-1]];;
gap> s2 :=[[[2,2,2,1],[2,2,1,2],[2,1,2,2],[1,2,2,2]],[1,-c,c,-1]];;
gap> 
gap> MkTrLst := function(l) local ans, h1, h2, a, i;
>    ans := [[1],[2]];
>    for i in [2..l] do
>       h1 := [];
>       h2 := [];
>       for a in ans do
>         Add(h1,Concatenation([1],a));
>         Add(h2,Concatenation([2],a));
>       od;
>       ans := Concatenation(h1,h2);
>    od;
>    return List(ans, a -> [[a],[1]]);
> end;;
gap> 
gap> I := Concatenation([s1,s2],MkTrLst(n));;
gap> # </L>
gap> 
gap> # add the next command in case other tests have changed the alphabet:
gap> GBNP.ConfigPrint("a","b","c");
gap> # To give an impression, we print the first 20 entries of this list:
gap> # <L>
gap> PrintNPList(I{[1..20]});
 a^3b - 651/25a^2ba + 651/25aba^2 - ba^3
 b^3a - 651/25b^2ab + 651/25bab^2 - ab^3
 a^8
 a^7b
 a^6ba
 a^6b^2
 a^5ba^2
 a^5bab
 a^5b^2a
 a^5b^3
 a^4ba^3
 a^4ba^2b
 a^4baba
 a^4bab^2
 a^4b^2a^2
 a^4b^2ab
 a^4b^3a
 a^4b^4
 a^3ba^4
 a^3ba^3b
gap> # </L>
gap> 
gap> # We calculate the Gröbner basis with <Ref Func="SGrobner" Style="Text"/>:
gap> 
gap> # <L>
gap> GB := SGrobner(I);;
#I  number of entered polynomials is 258
#I  number of polynomials after reduction is 114
#I  End of phase I
#I  End of phase II
#I  End of phase III
#I  End of phase IV
gap> # </L>
gap> 
gap> # Now print the first part of the Gröbner basis with <Ref Func="PrintNPList"
gap> # Style="Text"/> (only the first 20 polynomials are printed here, the full
gap> # Gröbner basis can be printed with <C>PrintNPList(GB)</C>):
gap> 
gap> # <L>
gap> PrintNPList(GB{[1..20]});
 ba^3 - 651/25aba^2 + 651/25a^2ba - a^3b
 b^3a - 651/25b^2ab + 651/25bab^2 - ab^3
 b^2a^2ba - bab^2a^2 - baba^2b + ba^2bab + ab^2aba - abab^2a - aba^2b^2 + a^2b\
^2ab
 b^2ab^2a^2 - 651/25b^2ababa + b^2aba^2b + 626/25bab^2aba - bab^2a^2b + babab^\
2a - ba^2b^2ab + ba^2bab^2 - 651/25ab^2ab^2a + ab^2abab + 423176/625abab^2ab -\
 423801/625ababab^2 + 626/25aba^2b^3 - 406901/625a^2b^2ab^2 + 423176/625a^2bab\
^3 - 651/25a^3b^4
 a^8
 a^7b
 a^6ba
 a^6b^2
 a^5ba^2
 a^5bab
 a^5b^2a
 a^5b^3
 a^4ba^2b
 a^4baba
 a^4bab^2
 a^4b^2a^2
 a^4b^2ab
 a^4b^4
 a^3ba^2ba
 a^3ba^2b^2
gap> # </L>
gap> 
gap> # The truncated quotient algebra is obtained by
gap> # factoring out the ideal generated by
gap> # the Gröbner basis <C>GB</C> and so
gap> # its dimension can be calculated with <Ref
gap> # Func="DimQA" Style="Text"/>:
gap> 
gap> # <L>
gap> DimQA(GB,2);
157
gap> # </L>
gap> 
gap> # Here is what Paul Terwilliger wrote in reaction to the computation carried
gap> # out by this example:
gap> # <!-- ###########begin quote################################### -->
gap> # <P/>
gap> #   I just wanted to thank you again for the dimension
gap> #   data that you gave me after the Durham
gap> #   meeting. It ended up having a large impact.
gap> #   See the attached paper; joint with Tatsuro
gap> #   Ito.<P/>
gap> #   I spent several weeks in Japan this past January,
gap> #   working with Tatsuro and trying to find a good basis
gap> #   for the algebra on two symbols subject to the
gap> #   <M>q</M>-Serre relations. After much frustration,
gap> #   we thought of feeding your data into Sloane's
gap> #   online handbook of integer sequences. We did it
gap> #   out of curiosity more than anything; we did not
gap> #   expect the handbook data to be particularly useful.
gap> #   But it was.<P/>
gap> #   The handbook told us that the graded dimension
gap> #   generating function, using your
gap> #   data for the coefficients, matched the <M>q</M>-series
gap> #   for the inverse of the Jacobi theta
gap> #   function <M>\vartheta_4</M>; armed with this overwhelming
gap> #   hint we were able to prove that the graded
gap> #   dimension generating function was indeed given by
gap> #   the inverse of <M>\vartheta_4</M>.  With that
gap> #   info we were able to get a nice result about
gap> #   td pairs.<P/>
gap> #   Paul<P/>
gap> # <!-- ######################################################### -->
gap> 
gap> 
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> STOP_TEST("test02.g",10000);
