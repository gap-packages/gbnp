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
