LoadPackage("gbnp");
GBNP.ConfigPrint();

# reset Info levels
SetInfoLevel(InfoGBNP,0);
SetInfoLevel(InfoGBNPTime,0);

# reset options
GBNP.ClearOptions();
#START_TEST("GBNP test-functions.g");
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
# http://www.gnu.org/licenses/lgpl.html
########################## END COPYRIGHT MESSAGE ##########################

# First load the gap package (before the example)

LoadPackage("GBNP","0",false);

# <#GAPDoc Label="example-GP2NP">

# <E>Example:</E>
# Let <C>A</C> be the free associative algebra with one over the rationals on the
# generators <C>a</C> and <C>b</C>. Let <C>e</C> be the one of the algebra.

# <L>
A:=FreeAssociativeAlgebraWithOne(Rationals,"a","b");;
a:=A.a;;
b:=A.b;;
e:=One(A);;
z:=Zero(A);;
# </L>

# Now let <C>gp</C> be the polynomial <M>ba-ab-e</M>.

# <L>
gp:=b*a-a*b-e;
# </L>

# The polynomial in NP format, corresponding to <C>gp</C> can now be obtained
# with GP2NP:

# <L>
GP2NP(gp);
# </L>



# Let <C>D</C> be the free associative algebra over <C>A</C>
# of rank 2.

# <L>
D := A^2;;
# </L>

# Take the following list <C>R</C> of two elements of <C>D</C>.

# <L>
R := [ [b-e, z], [e+a*(e+a+b), -e-a*(e+a+b)] ];;
# </L>

# Convert the list <C>R</C> to a list of vectors in NPM format.

# <L>
List(R,GP2NP);
# </L>

# <#/GAPDoc>

# <#GAPDoc Label="example-GP2NPList">

# <E>Example:</E>
# Let <C>A</C> be the free associative algebra with one over the rationals on the
# generators <C>a</C> and <C>b</C>. Let <C>e</C> be the one of the algebra.

# <L>
A:=FreeAssociativeAlgebraWithOne(Rationals,"a","b");;
a:=A.a;;
b:=A.b;;
e:=One(A);;
# </L>

# Let <C>Lgp</C> be the list of polynomials <M>[a^2-e,b^2-e,ba-ab-e]</M>.

# <L>
Lgp:=[a^2-e,b^2-e,b*a-a*b-e];
# </L>

# The polynomial in NP format corresponding to <C>gp</C> can be obtained
# with GP2NP:

# <L>
GP2NPList(Lgp);
# </L>

# The same result is obtained by a simple application of the standard List
# function in GAP:

# <L>
List(Lgp,GP2NP) = GP2NPList(Lgp);
# </L>


# <#/GAPDoc>

# <#GAPDoc Label="example-NP2GP">

# <E>Example:</E>
# Let <C>A</C> be the free associative algebra with one over the rationals on
# the generators <C>a</C> and <C>b</C>. 

# <L>
A:=FreeAssociativeAlgebraWithOne(GF(3),"a","b");;
# </L>

# Let <C>np</C> be a polynomial in NP format.

# <L>
np:=[ [ [ 2, 1 ], [ 1, 2 ], [  ] ], [ Z(3)^0, Z(3), Z(3) ] ];;
# </L>

# The polynomial can be converted to the corresponding element of <A>A</A>
# with NP2GP:

# <L>
NP2GP(np,A);
# </L>

# Note that some information of the coefficient field of
# a polynomial
# <C>np</C> in NP format can be obtained from the second list of <C>np</C>.

# <L>
One(np[2][1]);
# </L>


# Now let <C>M</C> be the module <C>A^2</C> and let <C>npm</C> be a polynomial
# over that module in NPM form.

# <L>
M:=A^2;;
npm:=[ [ [ -1, 1 ], [ -2, 2 ] ], [ Z(3)^0, Z(3)^0 ] ];;
# </L>



# The element of <A>M</A> corresponding to <C>npm</C> is

# <L>
NP2GP(npm,M);
# </L>


# If <C>M</C> is a module of dimension 2 over <C>A</C> and <C>Lnp</C> a list
# of polynomials in NPM format, then the polynomials can be converted to the
# corresponding polynomials of <C>M</C> as follows:

# <L>
M:=A^2;;
Lnp:=[ [ [ [ -2, 1, 1 ], [ -2, 1 ] ], [ 1, -1 ] ],
  [ [ [ -1, 2, 2], [-2, 1 ] ], [ 1, -1 ]*Z(3)^0 ] ];;
List(Lnp, m -> NP2GP(m,M));
# </L>





# <#/GAPDoc>

# <#GAPDoc Label="example-NP2GPList">

# <E>Example:</E>
# Let <C>A</C> be the free associative algebra with one over the rationals on
# the generators <C>a</C> and <C>b</C>.

# <L>
A:=FreeAssociativeAlgebraWithOne(Rationals,"a","b");;
# </L>

# Let <C>Lnp</C> be a list of polynomials in NP format.
# Then <C>Lnp</C> can be converted to a list of polynomials of <C>A</C>
# with NP2GPList:

# <L>
Lnp:=[ [ [ [ 1, 1, 1 ], [ 1 ] ], [ 1, -1 ] ],
  [ [ [ 2, 2 ], [ ] ], [ 1, -1 ] ] ];;
NP2GPList(Lnp,A);
# </L>


# It has the same effect as the function <C>List</C> applied as follows.

# <L>
List(Lnp, p -> NP2GP(p,A));
# </L>

# Now let <C>M</C> be a module of dimension 2 over <C>A</C> and <C>Lnp</C> 
# a list of vectors in NPM format. Then polynomials <C>Lnp</C>
# can be converted to the
# corresponding vectors of <C>M</C> with NP2GPList:

# <L>
M:=A^2;;
Lnp:=[ [ [ [ -2, 1, 1 ], [ -2, 1 ] ], [ 1, -1 ] ],
  [ [ [ -1, 1 ], [ -2 ] ], [ 1, -1 ] ] ];;
NP2GPList(Lnp,M);
# </L>

# The same result can be obtained by application of the standard
# List function:

# <L>
List(Lnp, m -> NP2GP(m,M)) = NP2GPList(Lnp,M) ;
# </L>


# <#/GAPDoc>




# <#GAPDoc Label="example-PrintNP">
# <E>Example:</E>
# Consider the following polynomial in NP format.
# <L>
p := [[[1,1,2],[1,2,2],[]],[1,-2,3]];;
# </L>


# It can be printed in the guise of a polynomial in <C>a</C> and <C>b</C>
# by the function <C>PrintNP</C>:
# <L>
PrintNP(p);
# </L>

# <#/GAPDoc>



# <#GAPDoc Label="example-ConfigPrint">
# <E>Example:</E>
# Consider the following two polynomials in NP format.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[1,2,2],[]],[1,-1]];;
# </L>


# They can be printed by the function <C>PrintNP</C>.
# <L>
PrintNP(p1);
PrintNP(p2);
# </L>

# We can let the variables be printed as <C>x</C> and <C>y</C> 
# instead of <C>a</C> and <C>b</C> by means of
# <Ref Func="GBNP.ConfigPrint" Style="Text"/>.
# <L>
GBNP.ConfigPrint("x","y");
PrintNP(p1);
PrintNP(p2);
# </L>


# We can also let the variables be printed as <C>x.1</C> and <C>x.2</C> 
# instead of <C>a</C> and <C>b</C> by means of
# <Ref Func="GBNP.ConfigPrint" Style="Text"/>.
# <L>
GBNP.ConfigPrint(2,"x");
PrintNP(p1);
PrintNP(p2);
# </L>


# We can even assign strings to the variables to
# be printed like <C>alice</C> and <C>bob</C> 
# instead of <C>a</C> and <C>b</C> by means of
# <Ref Func="GBNP.ConfigPrint" Style="Text"/>.
# <L>
GBNP.ConfigPrint("alice","bob");
PrintNP(p1);
PrintNP(p2);
# </L>


# Alternatively, we can introduce the free algebra <A>A</A>
# with two generators,
# and print the polynomials as members of <A>A</A>:

# <L>
A:=FreeAssociativeAlgebraWithOne(Rationals,"a","b");;
GBNP.ConfigPrint(A);
PrintNP(p1);
PrintNP(p2);
# </L>


# <#/GAPDoc>




# <#GAPDoc Label="example-PrintNPList">
# <E>Example:</E>
# We put two polynomials in NP format into the list <C>Lnp</C>.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[1,2,2],[]],[1,-1]];;
Lnp := [p1,p2];;
# </L>

# We can print the list with
# <Ref Func="PrintNPList" Style="Text"/>.
# <L>
PrintNPList(Lnp);
# </L>

# Alternatively, using the function
# <Ref Func="GBNP.ConfigPrint" Style="Text"/>,
# we can introduce the free algebra <A>A</A>
# with two generators,
# and print the polynomials of the list as members of <A>A</A>:

# <L>
A:=FreeAssociativeAlgebraWithOne(Rationals,"a","b");;
GBNP.ConfigPrint(A);
PrintNPList(Lnp);
# </L>


# <#/GAPDoc>




# <#GAPDoc Label="example-AddNP">
# <E>Example:</E>
# Consider the following two polynomials in NP format.
# <L>
p1 := [[[1,1,2],[]],[1,-3]];;
p2 := [[[1,2,2],[]],[1,-4]];;
# </L>


# The second can be subtracted from the first by the function <C>AddNP</C>.
# <L>
PrintNP(AddNP(p1,p2,1,-1));
# </L>

# <#/GAPDoc>



# <#GAPDoc Label="example-BimulNP">
# <E>Example:</E>
# Consider the following two polynomials in NP format.
# <L>
p1 := [[[1,1,2],[]],[1,-3]];;
p2 := [[[1,2,2],[]],[1,-4]];;
# </L>

# Multiplying <C>p1</C> from the right by <C>b</C> and
# multiplying <C>p2</C> from the left by <C>a</C>
# is possible with the function <C>BimulNP</C>:
# <L>
PrintNP(BimulNP([],p1,[2]));
PrintNP(BimulNP([1],p2,[]));
# </L>

# <#/GAPDoc>




# <#GAPDoc Label="example-CleanNP">
# <E>Example:</E>
# Consider the following polynomial in NP format.
# <L>
p := [[[1,1,2],[],[1,1,2],[]],[1,-3,-2,3]];;
PrintNP(p);
# </L>

# The monomials <C>[1,1,2]</C> and <C>[]</C>  occur twice each.
# For many functions this representation of a polynomial in NP format
# is not allowed. It needs to be cleaned, as by <Ref Func="CleanNP" Style="Text"/>:
# <L>
PrintNP(CleanNP(p));
# </L>


# In order to define a polynomial over <M>GF(2)</M>,
# the coefficients need to be defined over this field.
# Such a list of coefficients can be obtained in  GAP
# from a list of integers by multiplying with the identity element
# of the field.
# The resulting polynomial need not be clean, and so should be made clean again
# with <C>CleanNP</C>.
# <L>
p := [[[1,1,2],[]],One(GF(2))*[1,-2]];;
CleanNP(p);
# </L>

# <#/GAPDoc>


# <#GAPDoc Label="example-GtNP">
# <E>Example:</E>
# Consider the following two monomials.
# <L>
u := [1,1,2];
v := [2,2,1];
# </L>

# We test whether <C>u</C> is greater than <C>v</C>.

# <L>
GtNP(u,v);
# </L>

# <#/GAPDoc>




# <#GAPDoc Label="example-LtNP">
# <E>Example:</E>
# Consider the following two monomials.
# <L>
u := [1,1,2];
v := [2,2,1];
# </L>

# We test whether <C>u</C> is less than <C>v</C>.

# <L>
LtNP(u,v);
# </L>

# <#/GAPDoc>



# <#GAPDoc Label="example-LMonsNP">
# <E>Example:</E>
# We put two polynomials in NP format into the list <C>Lnp</C>.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[1,2,2],[]],[1,-1]];;
Lnp := [p1,p2];;
# </L>

# The list of leading monomials is computed by <C>LMonsNP</C>:

# <L>
LMonsNP(Lnp);
# </L>


# For a nicer printing, the monomials can be converted into polynomials in NP format,
# and then submitted to PrintNPList:

# <L>
PrintNPList(List(LMonsNP(Lnp), q -> [[q],[1]]));
# </L>

# <#/GAPDoc>

# <#GAPDoc Label="example-MkMonicNP">
# <E>Example:</E>
# Consider the following polynomial in NP format.
# <L>
p := [[[1,1,2],[]],[2,-1]];;
PrintNP(p);
# </L>

# The coefficient of the leading term is <M>2</M>. The function <C>MkMonicNP</C> finds
# this coefficient and divides all terms by it:

# <L>
PrintNP(MkMonicNP(p));
# </L>

# <#/GAPDoc>


# <#GAPDoc Label="example-MulNP">
# <E>Example:</E>

# Consider the following two polynomials in NP format.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[1,2,2],[]],[1,-1]];;
# </L>

# The function <C>MulNP</C> multiplies the two polynomials.
# <L>
PrintNP(MulNP(p1,p2));
# </L>


# The fact that this multiplication is not commutative is illustrated by
# the following comparison, using <C>MulNP</C> twice and <C>AddNP</C> once.
# <L>
PrintNP(AddNP(MulNP(p1,p2),MulNP(p2,p1),1,-1));
# </L>

# <#/GAPDoc>



# <#GAPDoc Label="example-StrongNormalFormNP">
# <E>Example:</E>

# Consider the following two polynomials in NP format.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[1,2,2],[]],[1,-1]];;
# </L>
# The strong normal form of the polynomial
# <L>
p := [[[1,1,1,2],[2,1],[]],[1,-1,3]];;
# </L>
# with respect to the list <C>[p1,p2]</C> 
# is computed by use of the function <C>StrongNormalFormNP</C>:
# <L>
PrintNP(StrongNormalFormNP(p,[p1,p2]));
# </L>
# <#/GAPDoc>


# <#GAPDoc Label="example-Grobner">
# <E>Example:</E>
# Consider the following two polynomials in NP format.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[1,2,2],[]],[1,-1]];;
PrintNPList([p1,p2]);
# </L>


# Their Gröbner basis can be computed by the function <C>Grobner</C>.
# <L>
G := Grobner([p1,p2]);;
PrintNPList(G);
# </L>

# One iteration of the Gröbner computations is invoked by use of the parameter
# <C>max</C>:
# <L>
R := Grobner([p1,p2],1);;
PrintNPList(R.G);
PrintNPList(R.todo);
R.iterations;
R.completed;
# </L>

# The above list <C>R.todo</C> can be used to resume the computation
# of the Gröbner basis computation with the  Gröbner pair
# <C>R.G</C>, <C>R.todo</C>:
# <L>
PrintNPList(Grobner(R.G,R.todo));
# </L>

# In order to perform 
# the Gröbner basis computation with polynomials in
# a free algebra over the field <M>GF(2)</M>, the coefficients
# of the polynomials need to be defined over that field.

# <L>
PrintNPList(Grobner([[p1[1],One(GF(2))*p1[2]],[p2[1],One(GF(2))*p1[2]]]));
# </L>


# <#/GAPDoc>


# <#GAPDoc Label="example-SGrobner">
# <E>Example:</E>
# Consider the following two polynomials in NP format.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[1,2,2],[]],[1,-1]];;
PrintNPList([p1,p2]);
# </L>


# Their Gröbner basis can be computed by the function <C>Grobner</C>.
# <L>
G := SGrobner([p1,p2]);;
PrintNPList(G);
# </L>

# One iteration of the Gröbner computations is invoked by use of the parameter
# <C>max</C>:
# <L>
R := SGrobner([p1,p2],1);;
PrintNPList(R.G);
PrintNPList(R.todo);
R.iterations;
R.completed;
# </L>

# The above list <C>R.todo</C> can be used to resume the computation
# of the Gröbner basis computation with the  Gröbner pair
# <C>R.G</C>, <C>R.todo</C>:
# <L>
PrintNPList(SGrobner(R.G,R.todo));
# </L>
# <#/GAPDoc>


# <#GAPDoc Label="example-BaseQA">
# <E>Example:</E>
# Consider the following Gröbner basis.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[1,2,2],[]],[1,-1]];;
G := Grobner([p1,p2]);;
PrintNPList(G);
# </L>
# The function <C>BaseQA</C> computes a basis for the
# quotient algebra of the free algebra over the rationals
# with generators <M>a</M> and <M>b</M> 
# by the two-sided ideal generated by <C>G</C>.
# <L>
PrintNPList(G);
BaseQA(G,2,0);
PrintNPList(BaseQA(G,2,0));
# </L>

# It is necessary for a correct result that the first argument
# be a Gröbner basis, as will be clear from the following invocation
# of <C>BaseQA</C>.
# <L>
PrintNPList(BaseQA([p1,p2],2,10));
# </L>

# <#/GAPDoc>


# <#GAPDoc Label="example-DimQA">
# <E>Example:</E>
# Consider the following Gröbner basis.
# <L>
p1 := [[[1,1,2],[]],[1,-2]];;
p2 := [[[1,2,2],[]],[1,-2]];;
G := Grobner([p1,p2]);;
PrintNPList(G);
# </L>
# The function <C>DimQA</C> computes the dimension of the
# quotient algebra of the free algebra over the rationals
# with generators <M>a</M> and <M>b</M> 
# by the two-sided ideal generated by <C>G</C>.
# <L>
DimQA(G,2);
# </L>
# <#/GAPDoc>


# <#GAPDoc Label="example-MulQA">
# <E>Example:</E>
# Consider the following Gröbner basis.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[1,2,2],[]],[1,-1]];;
G := Grobner([p1,p2]);;
PrintNPList(G);
# </L>

# Print the product in the quotient algebra of the polynomials
# <M>a-2</M> and <M>b-3</M> by use of <C>MulQA</C>:
# <L>
s1 := [[[1],[]],[1,-2]];;
s2 := [[[2],[]],[1,-3]];;
PrintNP(MulQA(s1,s2,G));
# </L>

# The result should be equal to the strong normal form of
# the product of <M>a-2</M> and <M>b-3</M> with respect to
# <C>G</C>:
# <L>
MulQA(s1,s2,G) = StrongNormalFormNP(MulNP(s1,s2),G);
# </L>


# <#/GAPDoc>

# <#GAPDoc Label="example-IsStrongGrobnerBasis">
# <E>Example:</E>
# Consider the following list of two polynomials in NP format.
# <L>
Lnp := [[[[1,1,2],[]],[1,-1]], [[[1,2,2],[]],[1,-1]]];;
PrintNPList(Lnp);
# </L>
# The function <C>IsStrongGrobner</C> checks whether the list is a
# strong Gröbner basis.
# <L>
IsStrongGrobnerBasis(Lnp);
# </L>

# But the answer should be <C>true</C> for the result of a
# strong Gröbner computation:
# <L>
IsStrongGrobnerBasis(SGrobner(Lnp));
# </L>

# A Gröbner basis that is not a strong Gröbner basis:
# <L>
B := SGrobner(Lnp);;
Add(B,AddNP(Lnp[1],B[1],1,-1));;
PrintNPList(B);
IsGrobnerBasis(B);
IsStrongGrobnerBasis(B);
# </L>
# <#/GAPDoc>


# <#GAPDoc Label="example-IsGrobnerBasis">
# <E>Example:</E>
# Consider the following list of two polynomials in NP format.
# <L>
Lnp := [[[[1,1,2],[]],[1,-1]], [[[1,2,2],[]],[1,-1]]];;
PrintNPList(Lnp);
# </L>
# The function <C>IsGrobner</C> checks whether the list is a
#  Gröbner basis.
# <L>
IsGrobnerBasis(Lnp);
# </L>

# So the answer should be <C>true</C> for the result of a
# Gröbner computation:
# <L>
IsGrobnerBasis(Grobner(Lnp));
# </L>

# <#/GAPDoc>

# <#GAPDoc Label="example-IsGrobnerPair">
# <E>Example:</E>
# Consider the following four polynomials in NP format.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[1,2,2],[]],[1,-1]];;
q1 := [[[2],[1]],[1,-1]];;
q2 := [[[1,1,1],[]],[1,-1]];;
# </L>
# The function <C>IsGrobnerPair</C> is used to check whether
# some combinations of these polynomials in two lists provide
#  Gröbner pairs.
# <L>
IsGrobnerPair([p1,p2,q1],[q2]);
IsGrobnerPair([q1,q2],[p1,p2]);
# </L>

# The function <C>IsGrobnerPair</C> applied with an empty list
# as second argument is a check whether the first argument is a 
#  Gröbner basis.
# <L>
IsGrobnerPair([p1,p2],[]) = IsGrobnerBasis([p1,p2]);
# </L>

# <#/GAPDoc>

# <#GAPDoc Label="example-MakeGrobnerPair">
# <E>Example:</E>
# Consider the following two polynomials in NP format.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[1,2,2],[]],[1,-1]];;
# </L>

# The function <C>MakeGrobnerPair</C> turns the list with these
# two polynomials into a Gröbner pair, once the empty list is added as a
# second argument.
# The result is a record whose fields <C>G</C> and <C>todo</C>
# <L>
GP := MakeGrobnerPair([p1,p2],[]);;
PrintNPList(GP.G);
PrintNPList(GP.todo);
# </L>

# These fields are ready for use in <C>Grobner</C>
# <L>
GB := Grobner(GP.G,GP.todo);;
PrintNPList(GB);
# </L>



# <#/GAPDoc>


# <#GAPDoc Label="example-StrongNormalFormNPM">
# <E>Example:</E>
# Consider the following two polynomials in NP format.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[1,2,2],[]],[1,-1]];;
PrintNPList([p1,p2]);
# </L>

# Consider also the following two vectors in NPM format.
# <L>
v1 := [[[-1,1,2],[-1]],[1,-1]];;
v2 := [[[-2,2,2],[-2]],[1,-2]];;
PrintNPList([v1,v2]);
# </L>

# The Gröbner basis record for this data is found by
# <Ref Func="SGrobnerModule" Style="Text"/>:
# <L>
GBR := SGrobnerModule([v1,v2],[p1,p2]);;
PrintNPList(GBR.ts);
PrintNPList(GBR.p);
# </L>

# The vector <C>w</C> is brought into strong normal form
# with respect to <C>GBR</C>:
# <L>
w := [[[-1,2],[-2,1]],[1,-4]];;
PrintNP(w);
v := StrongNormalFormNPM(w,GBR);;
PrintNP(v);
# </L>

# <#/GAPDoc>


# <#GAPDoc Label="example-SGrobnerModule">
# <E>Example:</E>
# Consider the following two polynomials in NP format.
# <L>
p1 := [[[1,1,2],[]],[1,-2]];;
p2 := [[[1,2,2],[]],[1,-3]];;
# </L>

# Consider also the following two vectors in NPM format.
# <L>
v1 := [[[-1,1,2],[-1]],[1,-1]];;
v2 := [[[-2,2,2],[-2]],[1,-2]];;
# </L>

# The Gröbner basis record for this data is found by
# <Ref Func="SGrobnerModule" Style="Text"/>:
# <L>
GBR := SGrobnerModule([v1,v2],[p1,p2]);;
# </L>

# The record <C>GBR</C> has two fields, <C>p</C> for prefix relations (vectors
# in the module)
# and <C>ts</C> for two-sided relations (polynomials in the algebra):
# <L>
PrintNPList(GBR.p);
PrintNPList(GBR.ts);
# </L>

# <#/GAPDoc>


# <#GAPDoc Label="example-MulQM">
# <E>Example:</E>
# Consider the following two polynomials in NP format.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[1,2,2],[]],[1,-1]];;
PrintNPList([p1,p2]);
# </L>

# Consider also the following two vectors in NPM format.
# <L>
v1 := [[[-1,1,2],[-1]],[1,-1]];;
v2 := [[[-2,2,2],[-2]],[1,-2]];;
PrintNPList([v1,v2]);
# </L>

# The Gröbner basis record for this data is found by
# <Ref Func="SGrobnerModule" Style="Text"/>:
# <L>
GBR := SGrobnerModule([v1,v2],[p1,p2]);;
PrintNPList(GBR.ts);
PrintNPList(GBR.p);
# </L>


# The function <C>MulQM</C> computes the product of the
# vector <C>w</C> with the polynomial <C>q</C>.
# <L>
w := [[[-1,2],[-2,1]],[1,-4]];;
PrintNP(w);
q := [[[2,2,1],[1]],[2,3]];;
PrintNP(q);
wq := MulQM(w,q,GBR);;
PrintNP(wq);
# </L>

# <#/GAPDoc>


# <#GAPDoc Label="example-BaseQM">
# <E>Example:</E>
# Consider the following two polynomials in NP format.
# <L>
p1 := [[[1,1,1,2],[]],[1,-1]];;
p2 := [[[2,2,2,1],[]],[1,-1]];;
# </L>



# Consider also the following two vectors in NPM format.
# <L>
v1 := [[[-1,1,2],[-1]],[1,-1]];;
v2 := [[[-2,2,2],[-2]],[1,-2]];;
# </L>

# The Gröbner basis record for this data is found by
# <Ref Func="SGrobnerModule" Style="Text"/>:
# <L>
GBR := SGrobnerModule([v1,v2],[p1,p2]);;
PrintNPList(GBR.ts);
PrintNPList(GBR.p);
# </L>



# The function <C>BaseQM</C> computes a basis.
# <L>
B := BaseQM(GBR,2,2,0);;
PrintNPList(B);
# </L>

# The function <C>BaseQM</C> with arguments so as to let the
# number of dimensions of the module and the number of variables be chosen minimal.
# <L>
B := BaseQM(GBR,0,0,0);;
PrintNPList(B);
# </L>

# The function <C>BaseQM</C> can also be used to ompute the first three elements of a basis.
# <L>
B := BaseQM(GBR,2,2,3);;
PrintNPList(B);
# </L>


# <#/GAPDoc>

# <#GAPDoc Label="example-DimQM">
# <E>Example:</E>


# Consider the following two polynomials in NP format.
# <L>
p1 := [[[1,1,1,2],[]],[1,-1]];;
p2 := [[[2,2,2,1],[]],[1,-1]];;
# </L>



# Consider also the following two vectors in NPM format.
# <L>
v1 := [[[-1,1,2],[-2]],[1,-1]];;
v2 := [[[-2,2,2],[-1]],[1,-2]];;
# </L>

# The Gröbner basis record for this data is found by
# <Ref Func="SGrobnerModule" Style="Text"/>:
# <L>
GBR := SGrobnerModule([v1,v2],[p1,p2]);;
# </L>


# The function <C>DimQM</C> computes the dimension over the rationals
# of the quotient of the free module over the free algebra on two generators
# by the submodule generated by the vectors <C>v1</C>, <C>v2</C>,
# <M>[p,q]</M>, where <M>p</M> and <M>q</M> run over all elements of
# the two-sided ideal in the free algebra generated by <C>p1</C> and <C>p2</C>.
# <L>
SetInfoLevel(InfoGBNP,2);
DimQM(GBR,2,2);
# </L>

# The answer should be equal to the size of <C>BaseQM(GBR,t,mt,0)</C>.

# <L>
DimQM(GBR,2,2) = Length(BaseQM(GBR,2,2,0));
SetInfoLevel(InfoGBNP,0);
# </L>
# <#/GAPDoc>



# <#GAPDoc Label="example-MatrixQA">
# <E>Example:</E>

# Consider the following two polynomials in NP format.
# <L>
p1 := [[[1,1,1,2],[]],[1,-1]];;
p2 := [[[2,2,2,1],[]],[1,-1]];;
# </L>

# The matrix of right multiplication by the first indeterminate <M>a</M>
# on the quotient algebra with respect to the ideal generated by
# <C>p1</C> and <C>p2</C> is obtained by applying <C>MatrixQA</C>
# to the Gröbner basis of these generators and a basis of the quotient
# algebra as found in
# <Ref Func="BaseQA" Style="Text"/>:
# <L>
GB := Grobner([p1,p2]);;
B := BaseQA(GB,2,0);;
PrintNPList(B);
Display(MatrixQA(1, B,GB));
# </L>

# The function is also applicable to Gröbner basis records for
# modules. Consider the following two vectors.
# <L>
v1 := [[[-1,1,2],[-1]],[1,-1]];;
v2 := [[[-2,2,2],[-2]],[1,-2]];;
# </L>

# The Gröbner basis record for this data is found by
# <Ref Func="SGrobnerModule" Style="Text"/> and a quotient module basis
# by <Ref Func="BaseQM" Style="Text"/>:
# <L>
GBR := SGrobnerModule([v1,v2],[p1,p2]);;
B := BaseQM(GBR,2,2,0);;
# </L>

# The matrix of right multiplication by <M>a</M>, the first generator
# of the free algebra, is
# <L>
Display(MatrixQA(1,B,GBR));
# </L>

# <#/GAPDoc>


# <#GAPDoc Label="example-MatricesQA">
# <E>Example:</E>

# Consider the following two polynomials in NP format.
# <L>
p1 := [[[1,1,1,2],[]],[1,-1]];;
p2 := [[[2,2,2,1],[]],[1,-1]];;
# </L>

# The function <C>MatricesQA</C> gives the list of matrices
# found by <Ref Func="MatrixQA" Style="Text"/>
# when the first argument takes the integer values
# between 1 and the number of all algebra generators.

# <L>
GB := Grobner([p1,p2]);;
B := BaseQA(GB,2,0);;
mats := MatricesQA(2,B,GB);;
for mat in mats do Display(mat); Print("\n"); od;
# </L>

# The result is also obtainable by use of the List function:
# <L>
MatricesQA(2,B,GB) = List([1,2], q -> MatrixQA(q,B,GB));
# </L>

# <#/GAPDoc>



# <#GAPDoc Label="example-MatrixQAC">
# <E>Example:</E>

# Consider the following two polynomials in NP format.
# <L>
F := GF(256);
z := GeneratorsOfField(F)[1];
p1 := [[[1,1,1,2],[]],[z,1]];;
p2 := [[[2,2,2,1],[]],[1,z]];;
# </L>

# The polynomials <C>p1</C> and  <C>p2</C> have coefficients in
# the field <C>F</C> of order 256.
# The matrix of right multiplication by the first indeterminate <M>a</M>
# on the quotient algebra is obtained by applying <C>MatrixQAC</C>
# just like <Ref Func="MatrixQA" Style="Text"/>. The difference is
# that the result is in another format.
# <L>
GB := Grobner([p1,p2]);
B := BaseQA(GB,2,0);
MatrixQAC(1, B,GB);
# </L>

# <#/GAPDoc>


# <#GAPDoc Label="example-MatricesQAC">
# <E>Example:</E>

# Consider the following two polynomials in NP format.
# <L>
F := GF(256);
z := GeneratorsOfField(F)[1];
p1 := [[[1,1,1,2],[]],[z,1]];;
p2 := [[[2,2,2,1],[]],[1,z]];;
# </L>

# The polynomials <C>p1</C> and  <C>p2</C> have coefficients in
# the field <C>F</C> of order 256.
# The matrices of right multiplication by the indeterminates
# on the quotient algebra  are just like for
# <Ref Func="MatricesQA" Style="Text"/> except for the format of the result.
# <L>
GB := Grobner([p1,p2]);
B := BaseQA(GB,2,0);
MatricesQAC(2,B,GB);
# </L>

# <#/GAPDoc>



# <#GAPDoc Label="example-PreprocessAnalysisQA">
# <E>Example:</E>

# Consider the following two polynomials in NP format of which a Gröbner
# basis is computed.
# <L>
# F := GF(256);
# z := GeneratorsOfField(F)[1];
p1 := [[[1,1,1,1,2],[]],[1,-1]];;
p2 := [[[2,2,2,1,1,1],[]],[1,-1]];;
GB := Grobner([p1,p2]);;
PrintNPList(GB);
# </L>

# Application of <C>PreprocessAnalysisQA</C> is carried out on the leading terms of
# <C>GB</C>, with 2, 4, 8, recursions, respectively.
# <L>
L := LMonsNP(GB);
L1 := PreprocessAnalysisQA(L,2,2);
L2 := PreprocessAnalysisQA(L1,2,4);
# </L>

# <#/GAPDoc>




# <#GAPDoc Label="example-EvalTrace">
# <E>Example:</E>


# First we compute the
# traced Gröbner basis
# of the list of the
# following two polynomials in NP format.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[2,2,1],[]],[1,-1]];;
Lnp := [p1,p2];;
GBT := SGrobnerTrace(Lnp);;
# </L>

# In order to check that the polynomials in <C>GBT</C> belong to the ideal
# generated by <C>p1</C> and <C>p2</C>, we evaluate the trace.
# For each traced polynomial <C>p</C> in <C>GBT</C>, 
# the polynomial <C>p.pol</C> is equated to the evaluated expression
# <C>p.trace</C>,
# in which each occurrence of <C>G(i)</C> is replaced by <C>Lnp[i]</C>
# by  use of <Ref Func="EvalTrace" Style="Text"/>.

# <L>
ForAll(GBT,q -> EvalTrace(q,Lnp) = q.pol);
# </L>

# <#/GAPDoc>



# <#GAPDoc Label="example-SGrobnerTrace">
# <E>Example:</E>

# For the list of the
# following two polynomials in NP format, a traced Gröbner
# basis is computed.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[2,2,1],[]],[1,-1]];;
GBT := SGrobnerTrace([p1,p2]);
# </L>

# <#/GAPDoc>



# <#GAPDoc Label="example-StrongNormalFormTraceDiff">
# <E>Example:</E>

# First we compute the
# traced Gröbner basis
# of the list of the
# following two polynomials in NP format.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[2,2,1],[]],[1,-1]];;
GBT := SGrobnerTrace([p1,p2]);;
# </L>


# Of the polynomial <M>a^6</M> we compute its
# difference with the normal form.
# The result is printed by used of <Ref Func="PrintNP" Style="Text"/>
# and  <Ref Func="PrintTraceList" Style="Text"/>.
# <L>
f := [[[1,1,1,1,1,1]],[1]];;
sf := StrongNormalFormTraceDiff(f,GBT);;
PrintNP(sf.pol);
PrintTraceList([sf]);
# </L>

# <#/GAPDoc>


# <#GAPDoc Label="example-SGrobnerTrunc">
# <E>Example:</E>

# Consider the
# following two polynomials in NP format.
# <L>
p1 := [[[1,2,2,1],[2,1,1,2]],[1,-1]];;
p2 := [[[2,2,2],[1,1]],[1,-1]];;
PrintNPList([p1,p2]);
# </L>


# These are homogeneous with respect to weights <M>[3,2]</M>.
# The degrees are <M>10</M> and <M>6</M>, respectively.
# The Gröbner basis truncated above degree 12 of the list <C>[p1,p2]</C>
# is computed and subsequently printed as follows.

# <L>
PrintNPList(SGrobnerTrunc([p1,p2],12,[3,2]));
# </L>

# <#/GAPDoc>


# <#GAPDoc Label="example-CheckHomogeneousNPs">
# <E>Example:</E>

# Consider the
# following two polynomials in NP format.
# <L>
p1 := [[[1,2,2,1],[2,1,1,2]],[1,-1]];;
p2 := [[[2,2,2],[1,1]],[1,-1]];;
PrintNPList([p1,p2]);
# </L>


# These are homogeneous with respect to weights <M>[3,2]</M>.
# The degrees are <M>10</M> and <M>6</M>, respectively.
# This is checked as follows.

# <L>
CheckHomogeneousNPs([p1,p2],[3,2]);
# </L>

# <#/GAPDoc>



# <#GAPDoc Label="example-BaseQATrunc">
# <E>Example:</E>

# Consider the truncated Gröbner basis
# of the following two polynomials in NP format.
# <L>
p1 := [[[1,2,2,1],[2,1,1,2]],[1,-1]];;
p2 := [[[2,2,2],[1,1]],[1,-1]];;
wtv := [3,2];;
GB := SGrobnerTrunc([p1,p2],12,wtv);;
GBNP.ConfigPrint("a","b");
PrintNPList(GB);
# </L>


# A basis of standard monomials is found and printed as follows.

# <L>
BT := BaseQATrunc(GB,12,wtv);;
for degpart in BT do 
  for mon in degpart do PrintNP([[mon],[1]]); od;
od;
# </L>

# <#/GAPDoc>


# <#GAPDoc Label="example-DimsQATrunc">
# <E>Example:</E>

# Consider the truncated Gröbner basis
# of the following two polynomials in NP format.
# <L>
p1 := [[[1,2,2,1],[2,1,1,2]],[1,-1]];;
p2 := [[[2,2,2],[1,1]],[1,-1]];;
wtv := [3,2];;
GB := SGrobnerTrunc([p1,p2],12,wtv);;
# </L>


# Information on the dimensions of the homogeneous parts
# of the quotient algebra is found as follows,

# <L>
DimsQATrunc(GB,12,wtv);
# </L>

# <#/GAPDoc>


# <#GAPDoc Label="example-FreqsQATrunc">
# <E>Example:</E>

# Consider the truncated Gröbner basis
# of the following two polynomials in NP format.
# <L>
p1 := [[[1,2,2,1],[2,1,1,2]],[1,-1]];;
p2 := [[[2,2,2],[1,1]],[1,-1]];;
wtv := [3,2];;
GB := SGrobnerTrunc([p1,p2],12,wtv);;
PrintNPList(GB);
# </L>


# The multiplicities of the frequencies of
# of monomials in a standard basis
# of the quotient algebra with respect to the ideal generated by
# <C>GB</C> is found as follows, for weights up to and including 8.

# <L>
F := FreqsQATrunc(GB,8,wtv);
# </L>

# The interpretation of this data is given by the following lines of code.

# <L>
for f in F do
  if f[1][1] <> [] then
    Print("At level ", wtv * (f[1][1]), " the multiplicities are\n");
    for x in f do
      Print("  for ",x[1],": ",x[2],"\n");
    od;
  else
    Print("At level ", 0 , " the multiplicity of [] is ",f[1][2],"\n");
  fi;
  Print("\n");
od;
# </L>


# <#/GAPDoc>




# <#GAPDoc Label="example-PrintTraceList">
# <E>Example:</E>

# First we compute the
# traced Gröbner basis
# of the list of two polynomials in NP format and next we print it
# by use of <C>PrintTraceList</C>.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[2,2,1],[]],[1,-1]];;
GBT := SGrobnerTrace([p1,p2]);;
PrintTraceList(GBT);
# </L>
# <#/GAPDoc>





# <#GAPDoc Label="example-PrintTracePol">
# <E>Example:</E>

# First we compute the
# traced Gröbner basis
# of the list of two polynomials in NP format. Next we print 
# the trace polynomial of the members of the list
# by use of <C>PrintTracePol</C>.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[2,2,1],[]],[1,-1]];;
GBT := SGrobnerTrace([p1,p2]);;
for np in GBT do PrintTracePol(np); Print("\n"); od;
# </L>
# <#/GAPDoc>


# <#GAPDoc Label="example-PrintNPListTrace">
# <E>Example:</E>

# First we compute the
# traced Gröbner basis
# of the list of two polynomials in NP format.
# Next we print the polynomials found
# by use of <C>PrintNPListTrace</C>.
# <L>
p1 := [[[1,1,2],[]],[1,-1]];;
p2 := [[[2,2,1],[]],[1,-1]];;
GBT := SGrobnerTrace([p1,p2]);;
PrintNPListTrace(GBT);
# </L>
# <#/GAPDoc>





# <#GAPDoc Label="example-DetermineGrowthQA">
# <E>Example:</E>

# For the list of monomials consisting of a single variable in a free algebra
# generated by two variables the growth is clearly polynomial of degree 1.
# This is verified by invoking <C>DetermineGrowthQA</C> with arguments
# <C>[[1]]</C>
# (the list of the single monomial consisting of the first variable),
# the number of generators of the free algebra to which the monomials belong
# (which is 2 here),
# and the boolean <C>true</C> indicating that we wish a precise degree
# in case of polynomial growth.


# <L>
DetermineGrowthQA([[1]],2,true);
# </L>

# Here is an example of polynomial growth of degree 2:


# <L>
L := [[1,2,1],[2,2,1]];
DetermineGrowthQA(L,2,true);
# </L>


# In order to show how to apply the function
# to arbitrary polynomials, consider
# the following two polynomials in NP format.

# <L>
F := GF(256);
z := GeneratorsOfField(F)[1];
p1 := [[[1,1,1,2],[]],[z,1]];;
p2 := [[[2,2,2,1],[]],[1,z]];;
# </L>

# The polynomials <C>p1</C> and  <C>p2</C> have coefficients in
# the field <C>F</C> of order 256.

# In order to study the growth of the quotient algebra
# we first compute the list of leading monomials of 
# the Gröbner basis elements and next apply 
# <C>DetermineGrowthQA</C>.

# <L>
GB := Grobner([p1,p2]);;
L := LMonsNP(GB);;
for lm  in L  do PrintNP( [ [ lm ], [ 1 ] ] ); od;
DetermineGrowthQA(L,2,true);
# </L>


# <#/GAPDoc>



# <#GAPDoc Label="example-FinCheckQA">
# <E>Example:</E>

# Consider the following list <C>L</C> of two monomials.
# <L>
L := [[1,2,1],[2,2,1]];;
# </L>

# Finiteness of the dimension of the quotient algebra of the free algebra
# by the ideal generated by these two monomials can be 
# decided by means of <C>FinCheckQA</C>.
# Its arguments are <C>L</C> and the number of generators of the free algebra
# in which the monomials reside.

# <L>
FinCheckQA(L,2);
# </L>

# This example turns out to be infinite dimensional.
# Here is a finite-dimensional example.

# <L>
FinCheckQA([[1],[2,2]],2);
# </L>



# <#/GAPDoc>


# <#GAPDoc Label="example-HilbertSeriesQA">
# <E>Example:</E>

# Consider the following list <C>L</C> of two monomials.
# <L>
L := [[1,2,1],[2,2,1]];;
# </L>

# Finiteness of the dimension of the quotient algebra of the free algebra
# by the ideal generated by these two monomials can be 
# decided by means of <C>FinCheckQA</C>.
# Its arguments are <C>L</C> and the number of generators of the free algebra
# in which the monomials reside.

# <L>
HilbertSeriesQA(L,2,10);
# </L>


# This indicates that the growth may be polynomial.
# <Ref Func="DetermineGrowthQA" Style="Text"/> can be used to check this.

# <#/GAPDoc>

# reset printing; note not inside a GAPDoc part here
# <L>
GBNP.ConfigPrint();
# </L>

# <#GAPDoc Label="example-NumAlgGensNP">
# <E>Example:</E>

# Consider the following polynomial in NP format.
# <L>
np := [[[2,2,2,1,1,1],[4],[3,2,3]],[1,-3,2]];;
PrintNP(np);
NumAlgGensNP(np);
# </L>
# <#/GAPDoc>

# <#GAPDoc Label="example-NumAlgGensNPList">
# <E>Example:</E>

# Consider the following two polynomials in NP format.
# <L>
p1 := [[[1,1,2,3,1],[2],[1]],[1,-2,1]];;
p2 := [[[2,2,1,4,3],[]],[1,-1]];;
PrintNPList([p1,p2]);
NumAlgGensNPList([p1,p2]);
# </L>
# <#/GAPDoc>


# <#GAPDoc Label="example-NumModGensNP">
# <E>Example:</E>

# Consider the following polynomial in NPM format.
# <L>
np := [[[-1,1,2,3,1],[-2],[-1]],[1,-2,1]];;
PrintNP(np);
NumModGensNP(np);
# </L>
# <#/GAPDoc>


# <#GAPDoc Label="example-NumModGensNPList">
# <E>Example:</E>

# Consider the following two polynomials in NPM format.
# <L>
v1 := [[[-1,1,2,3,1],[-2],[-1]],[1,-2,1]];;
v2 := [[[-2,2,1,4,3],[-3]],[1,-1]];;
PrintNPList([v1,v2]);
NumModGensNPList([v1,v2]);
# </L>
# <#/GAPDoc>
#STOP_TEST("test-functions.g.g",10000);
LoadPackage("gbnp");
GBNP.ConfigPrint();

# reset Info levels
SetInfoLevel(InfoGBNP,0);
SetInfoLevel(InfoGBNPTime,0);

# reset options
GBNP.ClearOptions();
#START_TEST("GBNP test-bound-01.g");
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
# http://www.gnu.org/licenses/lgpl.html
########################## END COPYRIGHT MESSAGE ##########################

LoadPackage("gbnp");

# GP2NP

A1:=FreeAssociativeAlgebraWithOne(Rationals,"a","b");;
GP2NP(One(A1)) = [[[]],[1]];
GP2NP(Zero(A1)) = [[],[]];

A2:=FreeAssociativeAlgebraWithOne(GF(2),"a");;
GP2NP(One(A2)) = [[[]],[Z(2)^0]];

GP2NPList([])=[];

# NP2GP
NP2GP([[[]],[Z(2)^0]],A2)=One(A2);
NP2GP([[],[]],A2)=Zero(A2);
NP2GP([[],[]],A1)=Zero(A1);

NP2GPList([],A1)=[];
#STOP_TEST("test-bound-01.g.g",10000);
LoadPackage("gbnp");
GBNP.ConfigPrint();

# reset Info levels
SetInfoLevel(InfoGBNP,0);
SetInfoLevel(InfoGBNPTime,0);

# reset options
GBNP.ClearOptions();
#START_TEST("GBNP test-bound-02.g");
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
# http://www.gnu.org/licenses/lgpl.html
########################## END COPYRIGHT MESSAGE ##########################

LoadPackage("gbnp");

# printing examples (more can be added)

A2:=FreeAssociativeAlgebraWithOne(GF(2),"a");;

GBNP.ConfigPrint(A2);
# should show 0*Z(2) XXX doesn't
PrintNP([[],[]]);
#STOP_TEST("test-bound-02.g.g",10000);
LoadPackage("gbnp");
GBNP.ConfigPrint();

# reset Info levels
SetInfoLevel(InfoGBNP,0);
SetInfoLevel(InfoGBNPTime,0);

# reset options
GBNP.ClearOptions();
#START_TEST("GBNP test-bound-03.g");
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
# http://www.gnu.org/licenses/lgpl.html
########################## END COPYRIGHT MESSAGE ##########################

LoadPackage("gbnp");

# calculation examples 

# NumAlgGensNP
NumAlgGensNP([[],[]])=0;
NumAlgGensNP([[[]],[1]])=0;
NumAlgGensNP([[[1,2],[3]],[1,-1]])=3;

# NumAlgGensNPList
NumAlgGensNPList([])=0;
NumAlgGensNPList([[[],[]]])=0;
NumAlgGensNPList([[[],[]],[[[]],[1]]])=0;
NumAlgGensNPList([[[],[]],[[[]],[1]],[[[1,2],[3]],[1,-1]]])=3;

# NumModGensNP
NumModGensNP([[],[]])=0;
NumModGensNP([[[]],[1]])=0;
NumModGensNP([[[1,2],[3]],[1,-1]])=0;

# AddNP
F:=Rationals;;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;
AddNP(NPzero,NPzero,One(F),One(F))=NPzero;
AddNP(NPone,NPone,One(F),-One(F))=NPzero;
AddNP(NPzero,NPone,One(F),One(F))=NPone;
AddNP(NPone,NPone,One(F),One(F))=AddNP(NPone,NPzero,One(F)+One(F),One(F));
F:=GF(2);;
NPone:=[[[]],[One(F)]];;
AddNP(NPzero,NPzero,One(F),One(F))=NPzero;
AddNP(NPone,NPone,One(F),-One(F))=NPzero;
AddNP(NPzero,NPone,One(F),One(F))=NPone;
AddNP(NPone,NPone,One(F),One(F))=AddNP(NPone,NPzero,One(F)+One(F),One(F));
AddNP(NPone,NPone,One(F),One(F))=NPzero; #field

# BimulNP
# NOTE only testing zero/one case
F:=Rationals;;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;
BimulNP([],NPzero,[])=NPzero;
BimulNP([1],NPzero,[2])=NPzero;
BimulNP([],NPzero,[2])=NPzero;
BimulNP([1],NPzero,[])=NPzero;
BimulNP([1],NPone,[])=[[[1]],[One(F)]];
BimulNP([],NPone,[2])=[[[2]],[One(F)]];
BimulNP([1],NPone,[2])=[[[1,2]],[One(F)]];

# CleanNP
F:=Rationals;;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;
CleanNP(NPzero)=NPzero;
CleanNP(NPone)=NPone;
F:=GF(2);;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;
CleanNP(NPzero)=NPzero;
CleanNP(NPone)=NPone;
CleanNP(2*NPone)=NPzero;
CleanNP([[[1],[1]],[One(F),One(F)]])=NPzero; # field

# GtNP
M0:=[];;
M1:=[1];;
GtNP(M0,M0)=false;
GtNP(M0,M1)=false;
GtNP(M1,M0)=true;
GtNP(M1,M1)=false;

# LtNP
M0:=[];;
M1:=[1];;
LtNP(M0,M0)=false;
LtNP(M0,M1)=true;
LtNP(M1,M0)=false;
LtNP(M1,M1)=false;

# LMonsNP
F:=Rationals;;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;
M0:=[];;

# fails if zero occurs in the list -> what is the leading monomial of zero ??
# not sure what the desired action should be (fail perhaps ?)
# might be better to document this
LMonsNP([])=[];
#LMonsNP([NPzero])=[]; 
LMonsNP([NPone])=[M0];
#LMonsNP([NPone,NPzero])=[M0];
LMonsNP([NPone,NPone])=[M0,M0];

# MkMonicNP
F:=Rationals;;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;
MkMonicNP(NPzero)=NPzero;
MkMonicNP(NPone)=NPone;
MkMonicNP(2*NPone)=NPone;

# MulNP
F:=Rationals;;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;
MulNP(NPzero,NPzero)=NPzero;
MulNP(NPone,NPzero)=NPzero;
MulNP(NPone,NPzero)=NPzero;
MulNP(NPone,NPone)=NPone;

#STOP_TEST("test-bound-03.g.g",10000);
LoadPackage("gbnp");
GBNP.ConfigPrint();

# reset Info levels
SetInfoLevel(InfoGBNP,0);
SetInfoLevel(InfoGBNPTime,0);

# reset options
GBNP.ClearOptions();
#START_TEST("GBNP test-bound-04.g");
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
# http://www.gnu.org/licenses/lgpl.html
########################## END COPYRIGHT MESSAGE ##########################

LoadPackage("gbnp");

# grobner basis examples

# Grobner
F:=Rationals;;
NPone:=[[[]],[One(F)]];;
NPzero:=[[],[]];;
Grobner([])=[];
Grobner([NPzero])=[]; 
Grobner([NPzero,NPone])=[NPone];
F:=GF(2);;
NPone:=[[[]],[One(F)]];;
SGrobner([NPzero,NPone])=[NPone];

# SGrobner
F:=Rationals;;
NPone:=[[[]],[One(F)]];;
NPzero:=[[],[]];;
SGrobner([])=[];
SGrobner([NPzero])=[];
SGrobner([NPzero,NPone])=[NPone];
F:=GF(2);;
NPone:=[[[]],[One(F)]];;
SGrobner([NPzero,NPone])=[NPone];

# IsGrobnerBasis
F:=Rationals;;
NPone:=[[[]],[One(F)]];;
NPzero:=[[],[]];;
IsGrobnerBasis([]);
IsGrobnerBasis([NPzero]);
IsGrobnerBasis([NPone]);
IsGrobnerBasis([NPzero, NPone]);
IsGrobnerBasis([NPone, NPone]);
F:=GF(2);;
NPone:=[[[]],[One(F)]];;
IsGrobnerBasis([NPone]);
IsGrobnerBasis([NPzero, NPone]);
IsGrobnerBasis([NPone, NPone]);

# IsStrongGrobnerBasis
F:=Rationals;;
NPone:=[[[]],[One(F)]];;
NPzero:=[[],[]];;
IsStrongGrobnerBasis([]);
IsStrongGrobnerBasis([NPzero]);
IsStrongGrobnerBasis([NPone]);
IsStrongGrobnerBasis([NPzero, NPone]);
IsStrongGrobnerBasis([NPone, NPone]);
F:=GF(2);;
NPone:=[[[]],[One(F)]];;
IsStrongGrobnerBasis([NPone]);
IsStrongGrobnerBasis([NPzero, NPone]);
IsStrongGrobnerBasis([NPone, NPone]);

# IsGrobnerPair
F:=Rationals;;
NPone:=[[[]],[One(F)]];;
NPzero:=[[],[]];;
# some grobner basis checks (zero in G -> then no Grobner Pair)
IsGrobnerPair([],[]);
IsGrobnerPair([NPzero],[])=false;
IsGrobnerPair([NPone],[]);
IsGrobnerPair([NPzero, NPone],[])=false;
IsGrobnerPair([NPone, NPone],[]);

IsGrobnerPair([],[NPzero])=false;
IsGrobnerPair([NPone],[NPzero])=false;
IsGrobnerPair([NPone, NPone],[NPzero])=false;

IsGrobnerPair([],[NPone]);
IsGrobnerPair([NPone],[NPone]);
IsGrobnerPair([NPone, NPone],[NPone]);
F:=GF(2);;
NPone:=[[[]],[One(F)]];;
# some grobner basis checks (zero in G -> then no Grobner Pair)
IsGrobnerPair([NPone],[]);
IsGrobnerPair([NPzero, NPone],[])=false;
IsGrobnerPair([NPone, NPone],[]);

IsGrobnerPair([],[NPzero])=false;
IsGrobnerPair([NPone],[NPzero])=false;
IsGrobnerPair([NPone, NPone],[NPzero])=false;

IsGrobnerPair([],[NPone]);
IsGrobnerPair([NPone],[NPone]);
IsGrobnerPair([NPone, NPone],[NPone]);

# MakeGrobnerPair
F:=Rationals;;
NPone:=[[[]],[One(F)]];;
NPzero:=[[],[]];;
# some grobner basis checks (zero in G -> then no Grobner Pair)
check:=function(r,G,todo) return r.G=G and r.todo=todo; end;;

check(MakeGrobnerPair([],[]), [], []);
check(MakeGrobnerPair([NPzero],[]), [],[]);
check(MakeGrobnerPair([NPone],[]),[NPone],[]);
check(MakeGrobnerPair([NPzero, NPone],[]),[NPone],[]);
check(MakeGrobnerPair([NPone, NPone],[]),[NPone,NPone],[]);

check(MakeGrobnerPair([],[NPzero]),[],[]);
check(MakeGrobnerPair([NPone],[NPzero]),[NPone],[]);
check(MakeGrobnerPair([NPone, NPone],[NPzero]),[NPone,NPone],[]);

check(MakeGrobnerPair([],[NPone]),[],[NPone]);
check(MakeGrobnerPair([NPone],[NPone]),[NPone],[NPone]);
check(MakeGrobnerPair([NPone, NPone],[NPone]),[NPone,NPone],[NPone]);
F:=GF(2);;
NPone:=[[[]],[One(F)]];;
# some grobner basis checks (zero in G -> then no Grobner Pair)
check(MakeGrobnerPair([NPone],[]),[NPone],[]);
check(MakeGrobnerPair([NPzero, NPone],[]),[NPone],[]);
check(MakeGrobnerPair([NPone, NPone],[]),[NPone,NPone],[]);

check(MakeGrobnerPair([],[NPzero]),[],[]);
check(MakeGrobnerPair([NPone],[NPzero]),[NPone],[]);
check(MakeGrobnerPair([NPone, NPone],[NPzero]),[NPone,NPone],[]);

check(MakeGrobnerPair([],[NPone]),[],[NPone]);
check(MakeGrobnerPair([NPone],[NPone]),[NPone],[NPone]);
check(MakeGrobnerPair([NPone, NPone],[NPone]),[NPone,NPone],[NPone]);
#STOP_TEST("test-bound-04.g.g",10000);
LoadPackage("gbnp");
GBNP.ConfigPrint();

# reset Info levels
SetInfoLevel(InfoGBNP,0);
SetInfoLevel(InfoGBNPTime,0);

# reset options
GBNP.ClearOptions();
#START_TEST("GBNP test-bound-05.g");
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
# http://www.gnu.org/licenses/lgpl.html
########################## END COPYRIGHT MESSAGE ##########################

LoadPackage("gbnp");

# BaseQA
F:=Rationals;;
NPone:=[[[]],[One(F)]];;
BaseQA([NPone],0,0)=[];
BaseQA([NPone],2,0)=[];
BaseQA([],2,5);; # warning length is 7 !

# DimQA
DimQA([NPone],0)=0;
DimQA([NPone],2)=0;

# MatrixQA

# MatricesQA

MatricesQA(1,[],[[[[]],[1]]])=[[]];

MatricesQA(1,[[[[]],[1]]],[[[[1]],[1]]])=[[[0]]];
MatricesQA(1,[[[[]],[1]],[[[1]],[1]]],[[[[1,1]],[1]]])=[[[0,1],[0,0]]];
MatricesQA(1,[[[[]],[1]],[[[1]],[1]]],[[[[1,1],[]],[1,-1]]])=[[[0,1],[1,0]]];

# MulQA
F:=Rationals;;
NPone:=[[[]],[One(F)]];;
NPzero:=[[],[]];;

MulQA(NPone,NPone,[])=NPone;
MulQA(NPzero,NPone,[])=NPzero;
MulQA(NPone,NPzero,[])=NPzero;
MulQA(NPzero,NPzero,[])=NPzero;
MulQA(NPone,NPone,[NPzero])=NPone;
MulQA(NPone,NPone,[NPone])=NPzero;

F:=GF(2);;
NPone:=[[[]],[One(F)]];;
NPzero:=[[],[]];;

MulQA(NPone,NPone,[])=NPone;
MulQA(NPzero,NPone,[])=NPzero;
MulQA(NPone,NPzero,[])=NPzero;
MulQA(NPzero,NPzero,[])=NPzero;
MulQA(NPone,NPone,[NPzero])=NPone;
MulQA(NPone,NPone,[NPone])=NPzero;

# StrongNormalFormNP
StrongNormalFormNP(NPone,[])=NPone;
StrongNormalFormNP(NPzero,[])=NPzero;
StrongNormalFormNP(NPone,[NPzero])=NPone;
StrongNormalFormNP(NPone,[NPone])=NPzero;
StrongNormalFormNP(NPzero,[NPzero])=NPzero;
#STOP_TEST("test-bound-05.g.g",10000);
LoadPackage("gbnp");
GBNP.ConfigPrint();

# reset Info levels
SetInfoLevel(InfoGBNP,0);
SetInfoLevel(InfoGBNPTime,0);

# reset options
GBNP.ClearOptions();
#START_TEST("GBNP test-bound-06.g");
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
# http://www.gnu.org/licenses/lgpl.html
########################## END COPYRIGHT MESSAGE ##########################

LoadPackage("gbnp");

check:=function (l, i) 
	# exact answer matches
	if IsInt(l) and l=i then
		return true;
	fi;
	# no exact answer, but correct answer is in interval
	if IsList(l) and l[1]<=i and i<=l[2] then
		return true;
	fi;
	# not a correct answer
	return false;
end;

# DetermineGrowthQA
DetermineGrowthQA([],2,true)="exponential growth";
DetermineGrowthQA([[1]],2,true)=1; 
DetermineGrowthQA([[1,2]],2,true)=2; 
DetermineGrowthQA([[2,1]],2,true)=2;
DetermineGrowthQA([[1,2,1],[2,2,1]],2,true)=2; # correct
DetermineGrowthQA([[1],[2]],2,true)=0; # correct

DetermineGrowthQA([],2,false)="exponential growth";
DetermineGrowthQA([[1]],2,false)=1; 
check(DetermineGrowthQA([[1,2]],2,false),2); 
DetermineGrowthQA([[2,1]],2,false)=2;
DetermineGrowthQA([[1,2,1],[2,2,1]],2,false)=2; # correct
DetermineGrowthQA([[1],[2]],2,false)=0; # correct

# FinCheckQA
FinCheckQA([],2)=false;
FinCheckQA([[]],2);
FinCheckQA([[1],[2]],2);
FinCheckQA([[1],[2]],2);
FinCheckQA([[2]],2)=false;

# HilbertSeriesQA
HilbertSeriesQA([],2,10)=[1,2,4,8,16,32,64,128,256,512,1024];
HilbertSeriesQA([[]],2,10)=[];
HilbertSeriesQA([[1,2]],2,10)=[1,2,3,4,5,6,7,8,9,10,11];
HilbertSeriesQA([[2,1]],2,10)=[1,2,3,4,5,6,7,8,9,10,11];
HilbertSeriesQA([[1]],2,10)=[1,1,1,1,1,1,1,1,1,1,1];
HilbertSeriesQA([[1,2,1],[2,2,1]],2,10)=[ 1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20 ];

# PreprocessAnalysisQA

PreprocessAnalysisQA([],2,10)=[];
PreprocessAnalysisQA([[]],2,10)=[[]];

# now for some not completely trivial ones, that tested true when I wrote them
PreprocessAnalysisQA([[1,2],[1,1],[2,2]],2,1)=[[1,1],[2]];
PreprocessAnalysisQA([[1,2],[1,1],[2,2]],2,2)=[[1],[2]];
#STOP_TEST("test-bound-06.g.g",10000);
LoadPackage("gbnp");
GBNP.ConfigPrint();

# reset Info levels
SetInfoLevel(InfoGBNP,0);
SetInfoLevel(InfoGBNPTime,0);

# reset options
GBNP.ClearOptions();
#START_TEST("GBNP test-bound-07.g");
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
# http://www.gnu.org/licenses/lgpl.html
########################## END COPYRIGHT MESSAGE ##########################

LoadPackage("gbnp");

# EvalTrace
NPTzero:=rec(pol:=[[],[]],trace:=[]);;
EvalTrace(NPTzero,[[]])=[[],[]];

# PrintTraceList

PrintTraceList([]);

# PrintTracePol
NPTzero:=rec(pol:=[[],[]],trace:=[]);;
PrintTracePol(NPTzero); # note does not print anything (!)

# PrintNPListTrace
PrintNPListTrace([]);

# SGrobnerTrace
SGrobnerTrace([])=[];
SGrobnerTrace([[[],[]]])=[];

GBT:=SGrobnerTrace([[[[]],[1]]]);;
Length(GBT)=1;
GBT[1].pol=[[[]],[1]];
GBT[1].trace=[[[],1,[],1]];

# StrongNormalFormTraceDiff

GBT:=SGrobnerTrace([[[[1]],[1]]]);;

tr:=StrongNormalFormTraceDiff([[[1]],[1]],GBT);;
tr.pol=[[[1]],[1]];
tr.trace=[[[],1,[],1]];
# cannot be reduced
tr:=StrongNormalFormTraceDiff([[[]],[1]],GBT);;
tr.pol=[[],[]];
tr.trace=[];
# cannot be reduced
tr:=StrongNormalFormTraceDiff([[],[]],GBT);;
tr.pol=[[],[]];
tr.trace=[];

GBT:=SGrobnerTrace([[[[]],[1]]]);;

tr:=StrongNormalFormTraceDiff([[[1]],[1]],GBT);;
tr.pol=[[[1]],[1]];
tr.trace=[[[],1,[1],1]];
tr:=StrongNormalFormTraceDiff([[[2]],[1]],GBT);;
tr.pol=[[[2]],[1]];
tr.trace=[[[],1,[2],1]];
# cannot be reduced
tr:=StrongNormalFormTraceDiff([[],[]],GBT);;
tr.pol=[[],[]];
tr.trace=[];
#STOP_TEST("test-bound-07.g.g",10000);
LoadPackage("gbnp");
GBNP.ConfigPrint();

# reset Info levels
SetInfoLevel(InfoGBNP,0);
SetInfoLevel(InfoGBNPTime,0);

# reset options
GBNP.ClearOptions();
#START_TEST("GBNP test-bound-08.g");
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
# http://www.gnu.org/licenses/lgpl.html
########################## END COPYRIGHT MESSAGE ##########################

LoadPackage("gbnp");

# SGrobnerTrunc
F:=Rationals;;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;

SGrobnerTrunc([NPzero],5,[1,1])=[];
SGrobnerTrunc([],5,[1,1])=[];
SGrobnerTrunc([NPone],5,[1])=[NPone];

F:=GF(2);;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;

# CheckHomogeneousNPs
CheckHomogeneousNPs([],[1,1])=[];

F:=Rationals;;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;

CheckHomogeneousNPs([NPone],[1,1])=[0];

# XXX NPzero is Homogeneous but the degree can not be determined -> so false is
# returned fail might be better here though
CheckHomogeneousNPs([NPzero],[1,1])=false;

F:=GF(2);;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;

CheckHomogeneousNPs([NPone],[1,1])=[0];

# XXX NPzero is Homogeneous but the degree can not be determined -> so false is
# returned fail might be better here though
CheckHomogeneousNPs([NPzero],[1,1])=false;

# BaseQATrunc
BaseQATrunc([],1,[2,3])=[ [ [] ], [] ];
BaseQATrunc([],2,[2,3])=[ [ [] ], [], [ [1] ]];
# why GB instead of lterms (to check homogeneous-ness ?)
BaseQATrunc([ [[[1]],[1]] ],2,[2,3])=[ [ [] ], [], [] ];
BaseQATrunc([ [[[1]],[1]] ],3,[2,3])=[ [ [] ], [], [], [ [2] ] ];
BaseQATrunc([ [[[]],[1]] ],3,[2,3])=[ [], [], [], [] ];
BaseQATrunc([ [[[]],[One(GF(3))]] ],3,[2,3])=[ [], [], [], [] ];

# DimsQATrunc
DimsQATrunc([],1,[2,3])=[1,0];
DimsQATrunc([],2,[2,3])=[1,0,1];
DimsQATrunc([ [[[1]],[1]] ],2,[2,3])=[1,0,0];
DimsQATrunc([ [[[1]],[1]] ],3,[2,3])=[1,0,0,1];
DimsQATrunc([ [[[]],[1]] ],3,[2,3])=[0,0,0,0];
DimsQATrunc([ [[[]],[One(GF(3))]] ],3,[2,3])=[0,0,0,0];

# FreqsQATrunc
FreqsQATrunc([],1,[2,3])=[ [ [ [  ], 1 ] ] ];
FreqsQATrunc([],2,[2,3])=[ [ [ [  ], 1 ] ], [ [ [ 1, 0 ], 1 ] ] ];
FreqsQATrunc([ [[[1]],[1]] ],2,[2,3])=[ [ [ [  ], 1 ] ] ];
FreqsQATrunc([ [[[1]],[1]] ],3,[2,3])=[ [ [ [  ], 1 ] ], [ [ [ 0, 1 ], 1 ] ] ];
FreqsQATrunc([ [[[]],[1]] ],3,[2,3])=[];
FreqsQATrunc([ [[[]],[One(GF(3))]] ],3,[2,3])=[];
#STOP_TEST("test-bound-08.g.g",10000);
LoadPackage("gbnp");
GBNP.ConfigPrint();

# reset Info levels
SetInfoLevel(InfoGBNP,0);
SetInfoLevel(InfoGBNPTime,0);

# reset options
GBNP.ClearOptions();
#START_TEST("GBNP test-bound-09.g");
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
# http://www.gnu.org/licenses/lgpl.html
########################## END COPYRIGHT MESSAGE ##########################

LoadPackage("gbnp");

NPzero:=[[],[]];;
NPone:=[[[]],[1]];;
NPone_2:=[[[]],[One(GF(2))]];;
NPMone1:=[[[-1,]],[1]];;
NPMone2:=[[[-2,]],[1]];;
NPMone1_2:=[[[-1,]],[One(GF(2))]];;
NPMone2_2:=[[[-2,]],[One(GF(2))]];;

GBRempty:=SGrobnerModule([],[]);;
GBRone:=SGrobnerModule([],[NPone]);;
GBRone_12:=SGrobnerModule([NPMone1,NPMone2],[]);;
GBRone_1:=SGrobnerModule([NPMone1],[]);;
# BaseQM
BaseQM(GBRempty,1,1,2);
BaseQM(GBRone,0,0,0)=[];
BaseQM(GBRone_12,0,0,0)=[];
BaseQM(GBRone_12,0,2,0)=[];

# DimQM
DimQM(GBRone,0,0)=0;
DimQM(GBRone_12,0,0)=0;
DimQM(GBRone_12,0,2)=0;

# MulQM
MulQM(NPone,NPone,GBRempty)=NPone;
MulQM(NPone,NPzero,GBRempty)=NPzero;
MulQM(NPzero,NPone,GBRempty)=NPzero;
MulQM(NPzero,NPzero,GBRempty)=NPzero;
MulQM(NPone,NPone,GBRone)=NPzero;
MulQM(NPMone1,NPone,GBRone_1)=NPzero;
MulQM(NPMone2,NPone,GBRone_1)=NPMone2;

# SGrobnerModule
# check function 
check:=function(r, p, ts)
	return (r.p = p) and (r.ts = ts);
end;;

# first some standard checks
check(SGrobnerModule([],[]), [], []);
check(SGrobnerModule([],[NPzero]), [], []);
check(SGrobnerModule([],[NPone]), [], [NPone]);
check(SGrobnerModule([],[NPone_2]), [], [NPone_2]);
# now some prefix checks
check(SGrobnerModule([NPMone1],[]),[NPMone1],[]);
check(SGrobnerModule([NPMone1],[NPone]),[],[NPone]);
check(SGrobnerModule([NPMone1_2],[NPone_2]),[],[NPone_2]);
check(SGrobnerModule([NPMone1_2,NPMone2_2],[NPone_2]),[],[NPone_2]);
check(SGrobnerModule([NPMone1_2,NPMone2_2],[]),[NPMone2_2,NPMone1_2],[]);

# StrongNormalFormNPM
StrongNormalFormNPM(NPzero,GBRempty)=NPzero;
StrongNormalFormNPM(NPone,GBRempty)=NPone;
StrongNormalFormNPM(NPMone1,GBRempty)=NPMone1;
StrongNormalFormNPM(NPMone1,GBRone)=NPzero;
StrongNormalFormNPM(NPone,GBRone)=NPzero;
StrongNormalFormNPM(NPone,GBRone_12)=NPone;
StrongNormalFormNPM(NPMone1,GBRone_12)=NPzero;
#STOP_TEST("test-bound-09.g.g",10000);
