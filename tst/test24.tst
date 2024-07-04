gap> START_TEST("GBNP test24");
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
gap> ### filename = "example24.g"
gap> ### author amc
gap> ### amc last edited 31 May 2007
gap> 
gap> # <#GAPDoc Label="Example24">
gap> # <Section Label="Example24"><Heading>Serre's exercise</Heading>
gap> 
gap> # <L>
gap> LoadPackage("gbnp", false);
true
gap> SetInfoLevel(InfoGBNP,1);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> # </L>
gap> 
gap> # In Serre's book <Cite Key="MR1954121"/> the following exercise can be found:
gap> # Prove  that the group
gap> # <M> \left\langle \{a,b,c\}\mid \{ bab^{-1}a^{-2}, cbc^{-1}b^{-2}, aca^{-1}c^{-2}\}\right\rangle</M>
gap> # is the trivial group.
gap> # Here we solve the exercise by running the trace variant of the
gap> # Gröbner basis function with input the set of equations
gap> # <M>ba - a^2 b, cb - b^2c, ac - c^2a</M>
gap> # together with relations forcing that <M>a,b,c</M> are invertible
gap> # with inverse <M>A,B,C</M>.
gap> 
gap> # <L>
gap> KI := [ [[[2,1],[1,1,2]],[1,-1]],
>         [[[3,2],[2,2,3]],[1,-1]],
>         [[[1,3],[3,3,1]],[1,-1]],
>         [[[1,4], []],[1,-1]],
>         [[[4,1], []],[1,-1]],
>         [[[2,5], []],[1,-1]],
>         [[[5,2], []],[1,-1]],
>         [[[3,6], []],[1,-1]],
>         [[[6,3], []],[1,-1]],
>       ];;
gap> # add the next command in case other tests have changed the alphabet:
gap> GBNP.ConfigPrint("a","b","c","d","e","f");
gap> PrintNPList(KI);
 ba - a^2b
 cb - b^2c
 ac - c^2a
 ad - 1
 da - 1
 be - 1
 eb - 1
 cf - 1
 fc - 1
gap> # </L>
gap> 
gap> # We use <Ref Func="SGrobnerTrace" Style="Text"/>,
gap> # the trace variant of the Gröbner basis computation,
gap> 
gap> # <L>
gap> GB := SGrobnerTrace(KI);;
#I  number of entered polynomials is 9
#I  number of polynomials after reduction is 9
#I  End of phase I
#I  End of phase II
#I  List of todo lengths is [ 9, 10, 11, 12, 14, 16, 18, 20, 21, 22, 24, 26, 28, 31, 34, 33, 35, 37, 40,
  43, 46, 49, 52, 56, 59, 62, 61, 60, 64, 64, 65, 65, 68, 71, 76, 76, 80, 88,
  93, 94, 99, 110, 115, 117, 131, 139, 146, 150, 158, 171, 186, 198, 206,
  220, 229, 246, 260, 263, 102, 40, 19, 9, 3, 0 ]
#I  End of phase III
#I  End of phase IV
gap> # </L>
gap> 
gap> # The dimension of the quotient algebra is 1, showing that the group algebra
gap> # is 1-dimensional. This implies that the group with the above presentation
gap> # is trivial.
gap> # <L>
gap> GBpols := List([1..Length(GB)], x -> GB[x].pol);;
gap> PrintNPList(GBpols);
 a - 1
 b - 1
 c - 1
 d - 1
 e - 1
 f - 1
gap> DimQA(GBpols,6);
1
gap> # </L>
gap> 
gap> # Since the output is large and might spoil the exercise,
gap> # we confine ourselves to
gap> # the printing first polynomial <C>GB[1]</C> and the length of its trace.
gap> # As the trace polynomial expresses
gap> # <C>GB[1]</C>, which is equal to <M>a-1</M>, as a combination of the binomials
gap> # in <C>KI</C>, it gives a proof that <M>a</M> can be rewritten within the
gap> # group to the trivial element. It is easy to derive from this that
gap> # <M>b</M> and <M>c</M> are also trivial in the group.
gap> # This justifies the restriction to <C>GB[1]</C>.
gap> 
gap> # <L>
gap> PrintNP(GB[1].pol);
 a - 1
gap> Length(GB[1].trace);
1119
gap> # </L>
gap> 
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> 
gap> STOP_TEST("test24.g",10000);
