######################### BEGIN COPYRIGHT MESSAGE #########################
# GBNP - computing Gröbner bases of noncommutative polynomials
# Copyright 2001-2010 by Arjeh M. Cohen, Dié A.H. Gijsbers, Jan Willem
# Knopper, Chris Krook. Address: Discrete Algebra and Geometry (DAM) group
# at the Department of Mathematics and Computer Science of Eindhoven
# University of Technology.
#
# For acknowledgements see the manual. The manual can be found in several
# formats in the doc subdirectory of the GBNP distribution. The
# acknowledgements formatted as text can be found in the file chap0.txt.
#
# GBNP is free software; you can redistribute it and/or modify it under
# the terms of the Lesser GNU General Public License as published by the
# Free Software Foundation (FSF); either version 2.1 of the License, or
# (at your option) any later version. For details, see the file 'LGPL' in
# the doc subdirectory of the GBNP distribution or see the FSF's own site:
# https://www.gnu.org/licenses/lgpl.html
########################## END COPYRIGHT MESSAGE ##########################

### filename = "example02.g"
### authors Cohen & Gijsbers

### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES

### Last change: August 29 2001.
### amc

# <#GAPDoc Label="Example02">
# <Section Label="Example02"><Heading>A truncated Gröbner basis for Leonard pairs</Heading>
# To provide Terwilliger with experimental dimension information in low degrees for his theory of Leonard pairs
# a truncated  Gröbner basis computation was carried out as follows.
# <P/>
# First load the package and set the standard infolevel <Ref
# InfoClass="InfoGBNP" Style="Text"/> to 1 and the time infolevel <Ref
# Func="InfoGBNPTime" Style="Text"/> to 2 (for more information about the info
# level, see Chapter <Ref Chap="Info"/>).

# <L>
LoadPackage("gbnp", false);
SetInfoLevel(InfoGBNP,1);
SetInfoLevel(InfoGBNPTime,0);
# </L>

# We truncate the example by putting all monomials of degree <M>n</M> in the
# ideal by means of the function <C>MkTrLst</C> to be introduced below;
# a better way to compute the
# result is by means of the truncated GB algorithms (See <Ref
# Sect="Example12"/>).
# <P/>
# We want to truncate at degree 7 so we have fixed <M>n = 8</M>.

# <L>
n := 8;;
# </L>

# Now enter the relations in NP form (see <Ref Sect="NP"/>). The function
# <Code>MkTrLst</Code> will be introduced, which will return all monomials of
# degree <C>n</C>. The list of ideal generators of interest is called <C>I</C>.

# <L>
sqbr := function(n,q) ; return (q^3-q^-3)/(q-q^(-1)); end;;

c := sqbr(3,5);

s1 :=[[[1,1,1,2],[1,1,2,1],[1,2,1,1],[2,1,1,1]],[1,-c,c,-1]];;
s2 :=[[[2,2,2,1],[2,2,1,2],[2,1,2,2],[1,2,2,2]],[1,-c,c,-1]];;

MkTrLst := function(l) local ans, h1, h2, a, i;
   ans := [[1],[2]];
   for i in [2..l] do
      h1 := [];
      h2 := [];
      for a in ans do
        Add(h1,Concatenation([1],a));
        Add(h2,Concatenation([2],a));
      od;
      ans := Concatenation(h1,h2);
   od;
   return List(ans, a -> [[a],[1]]);
end;;

I := Concatenation([s1,s2],MkTrLst(n));;
# </L>

# To give an impression, we print the first 20 entries of this list:
# <L>
PrintNPList(I{[1..20]});
# </L>

# We calculate the Gröbner basis with <Ref Func="SGrobner" Style="Text"/>:

# <L>
GB := SGrobner(I);;
# </L>

# Now print the first part of the Gröbner basis with <Ref Func="PrintNPList"
# Style="Text"/> (only the first 20 polynomials are printed here, the full
# Gröbner basis can be printed with <C>PrintNPList(GB)</C>):

# <L>
PrintNPList(GB{[1..20]});
# </L>

# The truncated quotient algebra is obtained by
# factoring out the ideal generated by
# the Gröbner basis <C>GB</C> and so
# its dimension can be calculated with <Ref
# Func="DimQA" Style="Text"/>:

# <L>
DimQA(GB,2);
# </L>

# Here is what Paul Terwilliger wrote in reaction to the computation carried
# out by this example:
# <!-- ###########begin quote################################### -->
# <P/>
#   I just wanted to thank you again for the dimension
#   data that you gave me after the Durham
#   meeting. It ended up having a large impact.
#   See the attached paper; joint with Tatsuro
#   Ito.<P/>
#   I spent several weeks in Japan this past January,
#   working with Tatsuro and trying to find a good basis
#   for the algebra on two symbols subject to the
#   <M>q</M>-Serre relations. After much frustration,
#   we thought of feeding your data into Sloane's
#   online handbook of integer sequences. We did it
#   out of curiosity more than anything; we did not
#   expect the handbook data to be particularly useful.
#   But it was.<P/>
#   The handbook told us that the graded dimension
#   generating function, using your
#   data for the coefficients, matched the <M>q</M>-series
#   for the inverse of the Jacobi theta
#   function <M>\vartheta_4</M>; armed with this overwhelming
#   hint we were able to prove that the graded
#   dimension generating function was indeed given by
#   the inverse of <M>\vartheta_4</M>.  With that
#   info we were able to get a nice result about
#   td pairs.<P/>
#   Paul<P/>
# <!-- ######################################################### -->


# </Section>
# <#/GAPDoc>
