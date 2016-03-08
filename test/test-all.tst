gap> LoadPackage("gbnp");
─────────────────────────────────────────────────────────────────────────────
Loading  GBNP 1.0.3 (Non-commutative Gröbner bases)
by A.M. Cohen (http://www.win.tue.nl/~amc) and
   J.W. Knopper (J.W.Knopper@tue.nl).
Homepage: http://mathdox.org/products/gbnp/
─────────────────────────────────────────────────────────────────────────────
true
gap> GBNP.ConfigPrint();
gap> 
gap> # reset Info levels
gap> SetInfoLevel(InfoGBNP,0);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> 
gap> # reset options
gap> GBNP.ClearOptions();
gap> START_TEST("GBNP test-functions.g");
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
gap> # First load the gap package (before the example)
gap> 
gap> LoadPackage("GBNP","0",false);
true
gap> 
gap> # <#GAPDoc Label="example-GP2NP">
gap> 
gap> # <E>Example:</E>
gap> # Let <C>A</C> be the free associative algebra with one over the rationals on the
gap> # generators <C>a</C> and <C>b</C>. Let <C>e</C> be the one of the algebra.
gap> 
gap> # <L>
gap> A:=FreeAssociativeAlgebraWithOne(Rationals,"a","b");;
gap> a:=A.a;;
gap> b:=A.b;;
gap> e:=One(A);;
gap> z:=Zero(A);;
gap> # </L>
gap> 
gap> # Now let <C>gp</C> be the polynomial <M>ba-ab-e</M>.
gap> 
gap> # <L>
gap> gp:=b*a-a*b-e;
(-1)*<identity ...>+(-1)*a*b+(1)*b*a
gap> # </L>
gap> 
gap> # The polynomial in NP format, corresponding to <C>gp</C> can now be obtained
gap> # with GP2NP:
gap> 
gap> # <L>
gap> GP2NP(gp);
[ [ [ 2, 1 ], [ 1, 2 ], [  ] ], [ 1, -1, -1 ] ]
gap> # </L>
gap> 
gap> 
gap> 
gap> # Let <C>D</C> be the free associative algebra over <C>A</C>
gap> # of rank 2.
gap> 
gap> # <L>
gap> D := A^2;;
gap> # </L>
gap> 
gap> # Take the following list <C>R</C> of two elements of <C>D</C>.
gap> 
gap> # <L>
gap> R := [ [b-e, z], [e+a*(e+a+b), -e-a*(e+a+b)] ];;
gap> # </L>
gap> 
gap> # Convert the list <C>R</C> to a list of vectors in NPM format.
gap> 
gap> # <L>
gap> List(R,GP2NP);
[ [ [ [ -1, 2 ], [ -1 ] ], [ 1, -1 ] ], 
  [ [ [ -1, 1, 2 ], [ -1, 1, 1 ], [ -2, 1, 2 ], [ -2, 1, 1 ], [ -1, 1 ], 
          [ -2, 1 ], [ -1 ], [ -2 ] ], [ 1, 1, -1, -1, 1, -1, 1, -1 ] ] ]
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> # <#GAPDoc Label="example-GP2NPList">
gap> 
gap> # <E>Example:</E>
gap> # Let <C>A</C> be the free associative algebra with one over the rationals on the
gap> # generators <C>a</C> and <C>b</C>. Let <C>e</C> be the one of the algebra.
gap> 
gap> # <L>
gap> A:=FreeAssociativeAlgebraWithOne(Rationals,"a","b");;
gap> a:=A.a;;
gap> b:=A.b;;
gap> e:=One(A);;
gap> # </L>
gap> 
gap> # Let <C>Lgp</C> be the list of polynomials <M>[a^2-e,b^2-e,ba-ab-e]</M>.
gap> 
gap> # <L>
gap> Lgp:=[a^2-e,b^2-e,b*a-a*b-e];
[ (-1)*<identity ...>+(1)*a^2, (-1)*<identity ...>+(1)*b^2, 
  (-1)*<identity ...>+(-1)*a*b+(1)*b*a ]
gap> # </L>
gap> 
gap> # The polynomial in NP format corresponding to <C>gp</C> can be obtained
gap> # with GP2NP:
gap> 
gap> # <L>
gap> GP2NPList(Lgp);
[ [ [ [ 1, 1 ], [  ] ], [ 1, -1 ] ], [ [ [ 2, 2 ], [  ] ], [ 1, -1 ] ], 
  [ [ [ 2, 1 ], [ 1, 2 ], [  ] ], [ 1, -1, -1 ] ] ]
gap> # </L>
gap> 
gap> # The same result is obtained by a simple application of the standard List
gap> # function in GAP:
gap> 
gap> # <L>
gap> List(Lgp,GP2NP) = GP2NPList(Lgp);
true
gap> # </L>
gap> 
gap> 
gap> # <#/GAPDoc>
gap> 
gap> # <#GAPDoc Label="example-NP2GP">
gap> 
gap> # <E>Example:</E>
gap> # Let <C>A</C> be the free associative algebra with one over the rationals on
gap> # the generators <C>a</C> and <C>b</C>. 
gap> 
gap> # <L>
gap> A:=FreeAssociativeAlgebraWithOne(GF(3),"a","b");;
gap> # </L>
gap> 
gap> # Let <C>np</C> be a polynomial in NP format.
gap> 
gap> # <L>
gap> np:=[ [ [ 2, 1 ], [ 1, 2 ], [  ] ], [ Z(3)^0, Z(3), Z(3) ] ];;
gap> # </L>
gap> 
gap> # The polynomial can be converted to the corresponding element of <A>A</A>
gap> # with NP2GP:
gap> 
gap> # <L>
gap> NP2GP(np,A);
(Z(3)^0)*b*a+(Z(3))*a*b+(Z(3))*<identity ...>
gap> # </L>
gap> 
gap> # Note that some information of the coefficient field of
gap> # a polynomial
gap> # <C>np</C> in NP format can be obtained from the second list of <C>np</C>.
gap> 
gap> # <L>
gap> One(np[2][1]);
Z(3)^0
gap> # </L>
gap> 
gap> 
gap> # Now let <C>M</C> be the module <C>A^2</C> and let <C>npm</C> be a polynomial
gap> # over that module in NPM form.
gap> 
gap> # <L>
gap> M:=A^2;;
gap> npm:=[ [ [ -1, 1 ], [ -2, 2 ] ], [ Z(3)^0, Z(3)^0 ] ];;
gap> # </L>
gap> 
gap> 
gap> 
gap> # The element of <A>M</A> corresponding to <C>npm</C> is
gap> 
gap> # <L>
gap> NP2GP(npm,M);
[ (Z(3)^0)*a, (Z(3)^0)*b ]
gap> # </L>
gap> 
gap> 
gap> # If <C>M</C> is a module of dimension 2 over <C>A</C> and <C>Lnp</C> a list
gap> # of polynomials in NPM format, then the polynomials can be converted to the
gap> # corresponding polynomials of <C>M</C> as follows:
gap> 
gap> # <L>
gap> M:=A^2;;
gap> Lnp:=[ [ [ [ -2, 1, 1 ], [ -2, 1 ] ], [ 1, -1 ] ],
>   [ [ [ -1, 2, 2], [-2, 1 ] ], [ 1, -1 ]*Z(3)^0 ] ];;
gap> List(Lnp, m -> NP2GP(m,M));
[ [ <zero> of ..., (Z(3))*a+(Z(3)^0)*a^2 ], [ (Z(3)^0)*b^2, (Z(3))*a ] ]
gap> # </L>
gap> 
gap> 
gap> 
gap> 
gap> 
gap> # <#/GAPDoc>
gap> 
gap> # <#GAPDoc Label="example-NP2GPList">
gap> 
gap> # <E>Example:</E>
gap> # Let <C>A</C> be the free associative algebra with one over the rationals on
gap> # the generators <C>a</C> and <C>b</C>.
gap> 
gap> # <L>
gap> A:=FreeAssociativeAlgebraWithOne(Rationals,"a","b");;
gap> # </L>
gap> 
gap> # Let <C>Lnp</C> be a list of polynomials in NP format.
gap> # Then <C>Lnp</C> can be converted to a list of polynomials of <C>A</C>
gap> # with NP2GPList:
gap> 
gap> # <L>
gap> Lnp:=[ [ [ [ 1, 1, 1 ], [ 1 ] ], [ 1, -1 ] ],
>   [ [ [ 2, 2 ], [ ] ], [ 1, -1 ] ] ];;
gap> NP2GPList(Lnp,A);
[ (1)*a^3+(-1)*a, (1)*b^2+(-1)*<identity ...> ]
gap> # </L>
gap> 
gap> 
gap> # It has the same effect as the function <C>List</C> applied as follows.
gap> 
gap> # <L>
gap> List(Lnp, p -> NP2GP(p,A));
[ (1)*a^3+(-1)*a, (1)*b^2+(-1)*<identity ...> ]
gap> # </L>
gap> 
gap> # Now let <C>M</C> be a module of dimension 2 over <C>A</C> and <C>Lnp</C> 
gap> # a list of vectors in NPM format. Then polynomials <C>Lnp</C>
gap> # can be converted to the
gap> # corresponding vectors of <C>M</C> with NP2GPList:
gap> 
gap> # <L>
gap> M:=A^2;;
gap> Lnp:=[ [ [ [ -2, 1, 1 ], [ -2, 1 ] ], [ 1, -1 ] ],
>   [ [ [ -1, 1 ], [ -2 ] ], [ 1, -1 ] ] ];;
gap> NP2GPList(Lnp,M);
[ [ <zero> of ..., (-1)*a+(1)*a^2 ], [ (1)*a, (-1)*<identity ...> ] ]
gap> # </L>
gap> 
gap> # The same result can be obtained by application of the standard
gap> # List function:
gap> 
gap> # <L>
gap> List(Lnp, m -> NP2GP(m,M)) = NP2GPList(Lnp,M) ;
true
gap> # </L>
gap> 
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-PrintNP">
gap> # <E>Example:</E>
gap> # Consider the following polynomial in NP format.
gap> # <L>
gap> p := [[[1,1,2],[1,2,2],[]],[1,-2,3]];;
gap> # </L>
gap> 
gap> 
gap> # It can be printed in the guise of a polynomial in <C>a</C> and <C>b</C>
gap> # by the function <C>PrintNP</C>:
gap> # <L>
gap> PrintNP(p);
 a^2b - 2ab^2 + 3 
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-ConfigPrint">
gap> # <E>Example:</E>
gap> # Consider the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[1,2,2],[]],[1,-1]];;
gap> # </L>
gap> 
gap> 
gap> # They can be printed by the function <C>PrintNP</C>.
gap> # <L>
gap> PrintNP(p1);
 a^2b - 1 
gap> PrintNP(p2);
 ab^2 - 1 
gap> # </L>
gap> 
gap> # We can let the variables be printed as <C>x</C> and <C>y</C> 
gap> # instead of <C>a</C> and <C>b</C> by means of
gap> # <Ref Func="GBNP.ConfigPrint" Style="Text"/>.
gap> # <L>
gap> GBNP.ConfigPrint("x","y");
gap> PrintNP(p1);
 x^2y - 1 
gap> PrintNP(p2);
 xy^2 - 1 
gap> # </L>
gap> 
gap> 
gap> # We can also let the variables be printed as <C>x.1</C> and <C>x.2</C> 
gap> # instead of <C>a</C> and <C>b</C> by means of
gap> # <Ref Func="GBNP.ConfigPrint" Style="Text"/>.
gap> # <L>
gap> GBNP.ConfigPrint(2,"x");
gap> PrintNP(p1);
 x.1^2x.2 - 1 
gap> PrintNP(p2);
 x.1x.2^2 - 1 
gap> # </L>
gap> 
gap> 
gap> # We can even assign strings to the variables to
gap> # be printed like <C>alice</C> and <C>bob</C> 
gap> # instead of <C>a</C> and <C>b</C> by means of
gap> # <Ref Func="GBNP.ConfigPrint" Style="Text"/>.
gap> # <L>
gap> GBNP.ConfigPrint("alice","bob");
gap> PrintNP(p1);
 alice^2bob - 1 
gap> PrintNP(p2);
 alicebob^2 - 1 
gap> # </L>
gap> 
gap> 
gap> # Alternatively, we can introduce the free algebra <A>A</A>
gap> # with two generators,
gap> # and print the polynomials as members of <A>A</A>:
gap> 
gap> # <L>
gap> A:=FreeAssociativeAlgebraWithOne(Rationals,"a","b");;
gap> GBNP.ConfigPrint(A);
gap> PrintNP(p1);
 a^2b - 1 
gap> PrintNP(p2);
 ab^2 - 1 
gap> # </L>
gap> 
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-PrintNPList">
gap> # <E>Example:</E>
gap> # We put two polynomials in NP format into the list <C>Lnp</C>.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[1,2,2],[]],[1,-1]];;
gap> Lnp := [p1,p2];;
gap> # </L>
gap> 
gap> # We can print the list with
gap> # <Ref Func="PrintNPList" Style="Text"/>.
gap> # <L>
gap> PrintNPList(Lnp);
 a^2b - 1 
 ab^2 - 1 
gap> # </L>
gap> 
gap> # Alternatively, using the function
gap> # <Ref Func="GBNP.ConfigPrint" Style="Text"/>,
gap> # we can introduce the free algebra <A>A</A>
gap> # with two generators,
gap> # and print the polynomials of the list as members of <A>A</A>:
gap> 
gap> # <L>
gap> A:=FreeAssociativeAlgebraWithOne(Rationals,"a","b");;
gap> GBNP.ConfigPrint(A);
gap> PrintNPList(Lnp);
 a^2b - 1 
 ab^2 - 1 
gap> # </L>
gap> 
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-AddNP">
gap> # <E>Example:</E>
gap> # Consider the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-3]];;
gap> p2 := [[[1,2,2],[]],[1,-4]];;
gap> # </L>
gap> 
gap> 
gap> # The second can be subtracted from the first by the function <C>AddNP</C>.
gap> # <L>
gap> PrintNP(AddNP(p1,p2,1,-1));
 - ab^2 + a^2b + 1 
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-BimulNP">
gap> # <E>Example:</E>
gap> # Consider the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-3]];;
gap> p2 := [[[1,2,2],[]],[1,-4]];;
gap> # </L>
gap> 
gap> # Multiplying <C>p1</C> from the right by <C>b</C> and
gap> # multiplying <C>p2</C> from the left by <C>a</C>
gap> # is possible with the function <C>BimulNP</C>:
gap> # <L>
gap> PrintNP(BimulNP([],p1,[2]));
 a^2b^2 - 3b 
gap> PrintNP(BimulNP([1],p2,[]));
 a^2b^2 - 4a 
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-CleanNP">
gap> # <E>Example:</E>
gap> # Consider the following polynomial in NP format.
gap> # <L>
gap> p := [[[1,1,2],[],[1,1,2],[]],[1,-3,-2,3]];;
gap> PrintNP(p);
 a^2b - 3 - 2a^2b + 3 
gap> # </L>
gap> 
gap> # The monomials <C>[1,1,2]</C> and <C>[]</C>  occur twice each.
gap> # For many functions this representation of a polynomial in NP format
gap> # is not allowed. It needs to be cleaned, as by <Ref Func="CleanNP" Style="Text"/>:
gap> # <L>
gap> PrintNP(CleanNP(p));
 - a^2b 
gap> # </L>
gap> 
gap> 
gap> # In order to define a polynomial over <M>GF(2)</M>,
gap> # the coefficients need to be defined over this field.
gap> # Such a list of coefficients can be obtained in  GAP
gap> # from a list of integers by multiplying with the identity element
gap> # of the field.
gap> # The resulting polynomial need not be clean, and so should be made clean again
gap> # with <C>CleanNP</C>.
gap> # <L>
gap> p := [[[1,1,2],[]],One(GF(2))*[1,-2]];;
gap> CleanNP(p);
[ [ [ 1, 1, 2 ] ], [ Z(2)^0 ] ]
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-GtNP">
gap> # <E>Example:</E>
gap> # Consider the following two monomials.
gap> # <L>
gap> u := [1,1,2];
[ 1, 1, 2 ]
gap> v := [2,2,1];
[ 2, 2, 1 ]
gap> # </L>
gap> 
gap> # We test whether <C>u</C> is greater than <C>v</C>.
gap> 
gap> # <L>
gap> GtNP(u,v);
false
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-LtNP">
gap> # <E>Example:</E>
gap> # Consider the following two monomials.
gap> # <L>
gap> u := [1,1,2];
[ 1, 1, 2 ]
gap> v := [2,2,1];
[ 2, 2, 1 ]
gap> # </L>
gap> 
gap> # We test whether <C>u</C> is less than <C>v</C>.
gap> 
gap> # <L>
gap> LtNP(u,v);
true
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-LMonsNP">
gap> # <E>Example:</E>
gap> # We put two polynomials in NP format into the list <C>Lnp</C>.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[1,2,2],[]],[1,-1]];;
gap> Lnp := [p1,p2];;
gap> # </L>
gap> 
gap> # The list of leading monomials is computed by <C>LMonsNP</C>:
gap> 
gap> # <L>
gap> LMonsNP(Lnp);
[ [ 1, 1, 2 ], [ 1, 2, 2 ] ]
gap> # </L>
gap> 
gap> 
gap> # For a nicer printing, the monomials can be converted into polynomials in NP format,
gap> # and then submitted to PrintNPList:
gap> 
gap> # <L>
gap> PrintNPList(List(LMonsNP(Lnp), q -> [[q],[1]]));
 a^2b 
 ab^2 
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> # <#GAPDoc Label="example-MkMonicNP">
gap> # <E>Example:</E>
gap> # Consider the following polynomial in NP format.
gap> # <L>
gap> p := [[[1,1,2],[]],[2,-1]];;
gap> PrintNP(p);
 2a^2b - 1 
gap> # </L>
gap> 
gap> # The coefficient of the leading term is <M>2</M>. The function <C>MkMonicNP</C> finds
gap> # this coefficient and divides all terms by it:
gap> 
gap> # <L>
gap> PrintNP(MkMonicNP(p));
 a^2b - 1/2 
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-MulNP">
gap> # <E>Example:</E>
gap> 
gap> # Consider the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[1,2,2],[]],[1,-1]];;
gap> # </L>
gap> 
gap> # The function <C>MulNP</C> multiplies the two polynomials.
gap> # <L>
gap> PrintNP(MulNP(p1,p2));
 a^2bab^2 - ab^2 - a^2b + 1 
gap> # </L>
gap> 
gap> 
gap> # The fact that this multiplication is not commutative is illustrated by
gap> # the following comparison, using <C>MulNP</C> twice and <C>AddNP</C> once.
gap> # <L>
gap> PrintNP(AddNP(MulNP(p1,p2),MulNP(p2,p1),1,-1));
 - ab^2a^2b + a^2bab^2 
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-StrongNormalFormNP">
gap> # <E>Example:</E>
gap> 
gap> # Consider the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[1,2,2],[]],[1,-1]];;
gap> # </L>
gap> # The strong normal form of the polynomial
gap> # <L>
gap> p := [[[1,1,1,2],[2,1],[]],[1,-1,3]];;
gap> # </L>
gap> # with respect to the list <C>[p1,p2]</C> 
gap> # is computed by use of the function <C>StrongNormalFormNP</C>:
gap> # <L>
gap> PrintNP(StrongNormalFormNP(p,[p1,p2]));
 - ba + a + 3 
gap> # </L>
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-Grobner">
gap> # <E>Example:</E>
gap> # Consider the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[1,2,2],[]],[1,-1]];;
gap> PrintNPList([p1,p2]);
 a^2b - 1 
 ab^2 - 1 
gap> # </L>
gap> 
gap> 
gap> # Their Gröbner basis can be computed by the function <C>Grobner</C>.
gap> # <L>
gap> G := Grobner([p1,p2]);;
gap> PrintNPList(G);
 b - a 
 a^3 - 1 
gap> # </L>
gap> 
gap> # One iteration of the Gröbner computations is invoked by use of the parameter
gap> # <C>max</C>:
gap> # <L>
gap> R := Grobner([p1,p2],1);;
gap> PrintNPList(R.G);
 b - a 
gap> PrintNPList(R.todo);
 a^3 - 1 
gap> R.iterations;
1
gap> R.completed;
false
gap> # </L>
gap> 
gap> # The above list <C>R.todo</C> can be used to resume the computation
gap> # of the Gröbner basis computation with the  Gröbner pair
gap> # <C>R.G</C>, <C>R.todo</C>:
gap> # <L>
gap> PrintNPList(Grobner(R.G,R.todo));
 b - a 
 a^3 - 1 
gap> # </L>
gap> 
gap> # In order to perform 
gap> # the Gröbner basis computation with polynomials in
gap> # a free algebra over the field <M>GF(2)</M>, the coefficients
gap> # of the polynomials need to be defined over that field.
gap> 
gap> # <L>
gap> PrintNPList(Grobner([[p1[1],One(GF(2))*p1[2]],[p2[1],One(GF(2))*p1[2]]]));
 b + a 
 a^3 + Z(2)^0 
gap> # </L>
gap> 
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-SGrobner">
gap> # <E>Example:</E>
gap> # Consider the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[1,2,2],[]],[1,-1]];;
gap> PrintNPList([p1,p2]);
 a^2b - 1 
 ab^2 - 1 
gap> # </L>
gap> 
gap> 
gap> # Their Gröbner basis can be computed by the function <C>Grobner</C>.
gap> # <L>
gap> G := SGrobner([p1,p2]);;
gap> PrintNPList(G);
 b - a 
 a^3 - 1 
gap> # </L>
gap> 
gap> # One iteration of the Gröbner computations is invoked by use of the parameter
gap> # <C>max</C>:
gap> # <L>
gap> R := SGrobner([p1,p2],1);;
gap> PrintNPList(R.G);
 b - a 
gap> PrintNPList(R.todo);
 a^3 - 1 
gap> R.iterations;
1
gap> R.completed;
false
gap> # </L>
gap> 
gap> # The above list <C>R.todo</C> can be used to resume the computation
gap> # of the Gröbner basis computation with the  Gröbner pair
gap> # <C>R.G</C>, <C>R.todo</C>:
gap> # <L>
gap> PrintNPList(SGrobner(R.G,R.todo));
 b - a 
 a^3 - 1 
gap> # </L>
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-BaseQA">
gap> # <E>Example:</E>
gap> # Consider the following Gröbner basis.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[1,2,2],[]],[1,-1]];;
gap> G := Grobner([p1,p2]);;
gap> PrintNPList(G);
 b - a 
 a^3 - 1 
gap> # </L>
gap> # The function <C>BaseQA</C> computes a basis for the
gap> # quotient algebra of the free algebra over the rationals
gap> # with generators <M>a</M> and <M>b</M> 
gap> # by the two-sided ideal generated by <C>G</C>.
gap> # <L>
gap> PrintNPList(G);
 b - a 
 a^3 - 1 
gap> BaseQA(G,2,0);
[ [ [ [  ] ], [ 1 ] ], [ [ [ 1 ] ], [ 1 ] ], [ [ [ 1, 1 ] ], [ 1 ] ] ]
gap> PrintNPList(BaseQA(G,2,0));
 1 
 a 
 a^2 
gap> # </L>
gap> 
gap> # It is necessary for a correct result that the first argument
gap> # be a Gröbner basis, as will be clear from the following invocation
gap> # of <C>BaseQA</C>.
gap> # <L>
gap> PrintNPList(BaseQA([p1,p2],2,10));
 1 
 a 
 b 
 a^2 
 ab 
 ba 
 b^2 
 a^3 
 aba 
 ba^2 
 bab 
 b^2a 
 b^3 
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-DimQA">
gap> # <E>Example:</E>
gap> # Consider the following Gröbner basis.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-2]];;
gap> p2 := [[[1,2,2],[]],[1,-2]];;
gap> G := Grobner([p1,p2]);;
gap> PrintNPList(G);
 b - a 
 a^3 - 2 
gap> # </L>
gap> # The function <C>DimQA</C> computes the dimension of the
gap> # quotient algebra of the free algebra over the rationals
gap> # with generators <M>a</M> and <M>b</M> 
gap> # by the two-sided ideal generated by <C>G</C>.
gap> # <L>
gap> DimQA(G,2);
3
gap> # </L>
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-MulQA">
gap> # <E>Example:</E>
gap> # Consider the following Gröbner basis.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[1,2,2],[]],[1,-1]];;
gap> G := Grobner([p1,p2]);;
gap> PrintNPList(G);
 b - a 
 a^3 - 1 
gap> # </L>
gap> 
gap> # Print the product in the quotient algebra of the polynomials
gap> # <M>a-2</M> and <M>b-3</M> by use of <C>MulQA</C>:
gap> # <L>
gap> s1 := [[[1],[]],[1,-2]];;
gap> s2 := [[[2],[]],[1,-3]];;
gap> PrintNP(MulQA(s1,s2,G));
 a^2 - 5a + 6 
gap> # </L>
gap> 
gap> # The result should be equal to the strong normal form of
gap> # the product of <M>a-2</M> and <M>b-3</M> with respect to
gap> # <C>G</C>:
gap> # <L>
gap> MulQA(s1,s2,G) = StrongNormalFormNP(MulNP(s1,s2),G);
true
gap> # </L>
gap> 
gap> 
gap> # <#/GAPDoc>
gap> 
gap> # <#GAPDoc Label="example-IsStrongGrobnerBasis">
gap> # <E>Example:</E>
gap> # Consider the following list of two polynomials in NP format.
gap> # <L>
gap> Lnp := [[[[1,1,2],[]],[1,-1]], [[[1,2,2],[]],[1,-1]]];;
gap> PrintNPList(Lnp);
 a^2b - 1 
 ab^2 - 1 
gap> # </L>
gap> # The function <C>IsStrongGrobner</C> checks whether the list is a
gap> # strong Gröbner basis.
gap> # <L>
gap> IsStrongGrobnerBasis(Lnp);
false
gap> # </L>
gap> 
gap> # But the answer should be <C>true</C> for the result of a
gap> # strong Gröbner computation:
gap> # <L>
gap> IsStrongGrobnerBasis(SGrobner(Lnp));
true
gap> # </L>
gap> 
gap> # A Gröbner basis that is not a strong Gröbner basis:
gap> # <L>
gap> B := SGrobner(Lnp);;
gap> Add(B,AddNP(Lnp[1],B[1],1,-1));;
gap> PrintNPList(B);
 b - a 
 a^3 - 1 
 a^2b - b + a - 1 
gap> IsGrobnerBasis(B);
true
gap> IsStrongGrobnerBasis(B);
false
gap> # </L>
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-IsGrobnerBasis">
gap> # <E>Example:</E>
gap> # Consider the following list of two polynomials in NP format.
gap> # <L>
gap> Lnp := [[[[1,1,2],[]],[1,-1]], [[[1,2,2],[]],[1,-1]]];;
gap> PrintNPList(Lnp);
 a^2b - 1 
 ab^2 - 1 
gap> # </L>
gap> # The function <C>IsGrobner</C> checks whether the list is a
gap> #  Gröbner basis.
gap> # <L>
gap> IsGrobnerBasis(Lnp);
false
gap> # </L>
gap> 
gap> # So the answer should be <C>true</C> for the result of a
gap> # Gröbner computation:
gap> # <L>
gap> IsGrobnerBasis(Grobner(Lnp));
true
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> # <#GAPDoc Label="example-IsGrobnerPair">
gap> # <E>Example:</E>
gap> # Consider the following four polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[1,2,2],[]],[1,-1]];;
gap> q1 := [[[2],[1]],[1,-1]];;
gap> q2 := [[[1,1,1],[]],[1,-1]];;
gap> # </L>
gap> # The function <C>IsGrobnerPair</C> is used to check whether
gap> # some combinations of these polynomials in two lists provide
gap> #  Gröbner pairs.
gap> # <L>
gap> IsGrobnerPair([p1,p2,q1],[q2]);
true
gap> IsGrobnerPair([q1,q2],[p1,p2]);
false
gap> # </L>
gap> 
gap> # The function <C>IsGrobnerPair</C> applied with an empty list
gap> # as second argument is a check whether the first argument is a 
gap> #  Gröbner basis.
gap> # <L>
gap> IsGrobnerPair([p1,p2],[]) = IsGrobnerBasis([p1,p2]);
true
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> # <#GAPDoc Label="example-MakeGrobnerPair">
gap> # <E>Example:</E>
gap> # Consider the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[1,2,2],[]],[1,-1]];;
gap> # </L>
gap> 
gap> # The function <C>MakeGrobnerPair</C> turns the list with these
gap> # two polynomials into a Gröbner pair, once the empty list is added as a
gap> # second argument.
gap> # The result is a record whose fields <C>G</C> and <C>todo</C>
gap> # <L>
gap> GP := MakeGrobnerPair([p1,p2],[]);;
gap> PrintNPList(GP.G);
 a^2b - 1 
 ab^2 - 1 
gap> PrintNPList(GP.todo);
 b - a 
gap> # </L>
gap> 
gap> # These fields are ready for use in <C>Grobner</C>
gap> # <L>
gap> GB := Grobner(GP.G,GP.todo);;
gap> PrintNPList(GB);
 b - a 
 a^3 - 1 
gap> # </L>
gap> 
gap> 
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-StrongNormalFormNPM">
gap> # <E>Example:</E>
gap> # Consider the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[1,2,2],[]],[1,-1]];;
gap> PrintNPList([p1,p2]);
 a^2b - 1 
 ab^2 - 1 
gap> # </L>
gap> 
gap> # Consider also the following two vectors in NPM format.
gap> # <L>
gap> v1 := [[[-1,1,2],[-1]],[1,-1]];;
gap> v2 := [[[-2,2,2],[-2]],[1,-2]];;
gap> PrintNPList([v1,v2]);
[ ab - 1 , 0]
[ 0, b^2 - 2 ]
gap> # </L>
gap> 
gap> # The Gröbner basis record for this data is found by
gap> # <Ref Func="SGrobnerModule" Style="Text"/>:
gap> # <L>
gap> GBR := SGrobnerModule([v1,v2],[p1,p2]);;
gap> PrintNPList(GBR.ts);
 b - a 
 a^3 - 1 
gap> PrintNPList(GBR.p);
[ 0, 1 ]
[ a - 1 , 0]
gap> # </L>
gap> 
gap> # The vector <C>w</C> is brought into strong normal form
gap> # with respect to <C>GBR</C>:
gap> # <L>
gap> w := [[[-1,2],[-2,1]],[1,-4]];;
gap> PrintNP(w);
[ b , - 4a ]
gap> v := StrongNormalFormNPM(w,GBR);;
gap> PrintNP(v);
[ 1 , 0]
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-SGrobnerModule">
gap> # <E>Example:</E>
gap> # Consider the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-2]];;
gap> p2 := [[[1,2,2],[]],[1,-3]];;
gap> # </L>
gap> 
gap> # Consider also the following two vectors in NPM format.
gap> # <L>
gap> v1 := [[[-1,1,2],[-1]],[1,-1]];;
gap> v2 := [[[-2,2,2],[-2]],[1,-2]];;
gap> # </L>
gap> 
gap> # The Gröbner basis record for this data is found by
gap> # <Ref Func="SGrobnerModule" Style="Text"/>:
gap> # <L>
gap> GBR := SGrobnerModule([v1,v2],[p1,p2]);;
gap> # </L>
gap> 
gap> # The record <C>GBR</C> has two fields, <C>p</C> for prefix relations (vectors
gap> # in the module)
gap> # and <C>ts</C> for two-sided relations (polynomials in the algebra):
gap> # <L>
gap> PrintNPList(GBR.p);
[ 0, 1 ]
[ 1 , 0]
gap> PrintNPList(GBR.ts);
 b - 3/2a 
 a^3 - 4/3 
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-MulQM">
gap> # <E>Example:</E>
gap> # Consider the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[1,2,2],[]],[1,-1]];;
gap> PrintNPList([p1,p2]);
 a^2b - 1 
 ab^2 - 1 
gap> # </L>
gap> 
gap> # Consider also the following two vectors in NPM format.
gap> # <L>
gap> v1 := [[[-1,1,2],[-1]],[1,-1]];;
gap> v2 := [[[-2,2,2],[-2]],[1,-2]];;
gap> PrintNPList([v1,v2]);
[ ab - 1 , 0]
[ 0, b^2 - 2 ]
gap> # </L>
gap> 
gap> # The Gröbner basis record for this data is found by
gap> # <Ref Func="SGrobnerModule" Style="Text"/>:
gap> # <L>
gap> GBR := SGrobnerModule([v1,v2],[p1,p2]);;
gap> PrintNPList(GBR.ts);
 b - a 
 a^3 - 1 
gap> PrintNPList(GBR.p);
[ 0, 1 ]
[ a - 1 , 0]
gap> # </L>
gap> 
gap> 
gap> # The function <C>MulQM</C> computes the product of the
gap> # vector <C>w</C> with the polynomial <C>q</C>.
gap> # <L>
gap> w := [[[-1,2],[-2,1]],[1,-4]];;
gap> PrintNP(w);
[ b , - 4a ]
gap> q := [[[2,2,1],[1]],[2,3]];;
gap> PrintNP(q);
 2b^2a + 3a 
gap> wq := MulQM(w,q,GBR);;
gap> PrintNP(wq);
[ 5 , 0]
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-BaseQM">
gap> # <E>Example:</E>
gap> # Consider the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,1,2],[]],[1,-1]];;
gap> p2 := [[[2,2,2,1],[]],[1,-1]];;
gap> # </L>
gap> 
gap> 
gap> 
gap> # Consider also the following two vectors in NPM format.
gap> # <L>
gap> v1 := [[[-1,1,2],[-1]],[1,-1]];;
gap> v2 := [[[-2,2,2],[-2]],[1,-2]];;
gap> # </L>
gap> 
gap> # The Gröbner basis record for this data is found by
gap> # <Ref Func="SGrobnerModule" Style="Text"/>:
gap> # <L>
gap> GBR := SGrobnerModule([v1,v2],[p1,p2]);;
gap> PrintNPList(GBR.ts);
 ba - ab 
 b^2 - a^2 
 a^3b - 1 
 a^5 - b 
gap> PrintNPList(GBR.p);
[ 0, 1 ]
[ b - a , 0]
[ a^2 - 1 , 0]
[ ab - 1 , 0]
gap> # </L>
gap> 
gap> 
gap> 
gap> # The function <C>BaseQM</C> computes a basis.
gap> # <L>
gap> B := BaseQM(GBR,2,2,0);;
gap> PrintNPList(B);
[ 1 , 0]
[ a , 0]
gap> # </L>
gap> 
gap> # The function <C>BaseQM</C> with arguments so as to let the
gap> # number of dimensions of the module and the number of variables be chosen minimal.
gap> # <L>
gap> B := BaseQM(GBR,0,0,0);;
gap> PrintNPList(B);
[ 1 , 0]
[ a , 0]
gap> # </L>
gap> 
gap> # The function <C>BaseQM</C> can also be used to ompute the first three elements of a basis.
gap> # <L>
gap> B := BaseQM(GBR,2,2,3);;
gap> PrintNPList(B);
[ 1 , 0]
[ a , 0]
gap> # </L>
gap> 
gap> 
gap> # <#/GAPDoc>
gap> 
gap> # <#GAPDoc Label="example-DimQM">
gap> # <E>Example:</E>
gap> 
gap> 
gap> # Consider the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,1,2],[]],[1,-1]];;
gap> p2 := [[[2,2,2,1],[]],[1,-1]];;
gap> # </L>
gap> 
gap> 
gap> 
gap> # Consider also the following two vectors in NPM format.
gap> # <L>
gap> v1 := [[[-1,1,2],[-2]],[1,-1]];;
gap> v2 := [[[-2,2,2],[-1]],[1,-2]];;
gap> # </L>
gap> 
gap> # The Gröbner basis record for this data is found by
gap> # <Ref Func="SGrobnerModule" Style="Text"/>:
gap> # <L>
gap> GBR := SGrobnerModule([v1,v2],[p1,p2]);;
gap> # </L>
gap> 
gap> 
gap> # The function <C>DimQM</C> computes the dimension over the rationals
gap> # of the quotient of the free module over the free algebra on two generators
gap> # by the submodule generated by the vectors <C>v1</C>, <C>v2</C>,
gap> # <M>[p,q]</M>, where <M>p</M> and <M>q</M> run over all elements of
gap> # the two-sided ideal in the free algebra generated by <C>p1</C> and <C>p2</C>.
gap> # <L>
gap> SetInfoLevel(InfoGBNP,2);
gap> DimQM(GBR,2,2);
0
gap> # </L>
gap> 
gap> # The answer should be equal to the size of <C>BaseQM(GBR,t,mt,0)</C>.
gap> 
gap> # <L>
gap> DimQM(GBR,2,2) = Length(BaseQM(GBR,2,2,0));
true
gap> SetInfoLevel(InfoGBNP,0);
gap> # </L>
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-MatrixQA">
gap> # <E>Example:</E>
gap> 
gap> # Consider the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,1,2],[]],[1,-1]];;
gap> p2 := [[[2,2,2,1],[]],[1,-1]];;
gap> # </L>
gap> 
gap> # The matrix of right multiplication by the first indeterminate <M>a</M>
gap> # on the quotient algebra with respect to the ideal generated by
gap> # <C>p1</C> and <C>p2</C> is obtained by applying <C>MatrixQA</C>
gap> # to the Gröbner basis of these generators and a basis of the quotient
gap> # algebra as found in
gap> # <Ref Func="BaseQA" Style="Text"/>:
gap> # <L>
gap> GB := Grobner([p1,p2]);;
gap> B := BaseQA(GB,2,0);;
gap> PrintNPList(B);
 1 
 a 
 b 
 a^2 
 ab 
 a^3 
 a^2b 
 a^4 
gap> Display(MatrixQA(1, B,GB));
[ [  0,  1,  0,  0,  0,  0,  0,  0 ],
  [  0,  0,  0,  1,  0,  0,  0,  0 ],
  [  0,  0,  0,  0,  1,  0,  0,  0 ],
  [  0,  0,  0,  0,  0,  1,  0,  0 ],
  [  0,  0,  0,  0,  0,  0,  1,  0 ],
  [  0,  0,  0,  0,  0,  0,  0,  1 ],
  [  1,  0,  0,  0,  0,  0,  0,  0 ],
  [  0,  0,  1,  0,  0,  0,  0,  0 ] ]
gap> # </L>
gap> 
gap> # The function is also applicable to Gröbner basis records for
gap> # modules. Consider the following two vectors.
gap> # <L>
gap> v1 := [[[-1,1,2],[-1]],[1,-1]];;
gap> v2 := [[[-2,2,2],[-2]],[1,-2]];;
gap> # </L>
gap> 
gap> # The Gröbner basis record for this data is found by
gap> # <Ref Func="SGrobnerModule" Style="Text"/> and a quotient module basis
gap> # by <Ref Func="BaseQM" Style="Text"/>:
gap> # <L>
gap> GBR := SGrobnerModule([v1,v2],[p1,p2]);;
gap> B := BaseQM(GBR,2,2,0);;
gap> # </L>
gap> 
gap> # The matrix of right multiplication by <M>a</M>, the first generator
gap> # of the free algebra, is
gap> # <L>
gap> Display(MatrixQA(1,B,GBR));
[ [  0,  1 ],
  [  1,  0 ] ]
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-MatricesQA">
gap> # <E>Example:</E>
gap> 
gap> # Consider the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,1,2],[]],[1,-1]];;
gap> p2 := [[[2,2,2,1],[]],[1,-1]];;
gap> # </L>
gap> 
gap> # The function <C>MatricesQA</C> gives the list of matrices
gap> # found by <Ref Func="MatrixQA" Style="Text"/>
gap> # when the first argument takes the integer values
gap> # between 1 and the number of all algebra generators.
gap> 
gap> # <L>
gap> GB := Grobner([p1,p2]);;
gap> B := BaseQA(GB,2,0);;
gap> mats := MatricesQA(2,B,GB);;
gap> for mat in mats do Display(mat); Print("\n"); od;
[ [  0,  1,  0,  0,  0,  0,  0,  0 ],
  [  0,  0,  0,  1,  0,  0,  0,  0 ],
  [  0,  0,  0,  0,  1,  0,  0,  0 ],
  [  0,  0,  0,  0,  0,  1,  0,  0 ],
  [  0,  0,  0,  0,  0,  0,  1,  0 ],
  [  0,  0,  0,  0,  0,  0,  0,  1 ],
  [  1,  0,  0,  0,  0,  0,  0,  0 ],
  [  0,  0,  1,  0,  0,  0,  0,  0 ] ]

[ [  0,  0,  1,  0,  0,  0,  0,  0 ],
  [  0,  0,  0,  0,  1,  0,  0,  0 ],
  [  0,  0,  0,  1,  0,  0,  0,  0 ],
  [  0,  0,  0,  0,  0,  0,  1,  0 ],
  [  0,  0,  0,  0,  0,  1,  0,  0 ],
  [  1,  0,  0,  0,  0,  0,  0,  0 ],
  [  0,  0,  0,  0,  0,  0,  0,  1 ],
  [  0,  1,  0,  0,  0,  0,  0,  0 ] ]

gap> # </L>
gap> 
gap> # The result is also obtainable by use of the List function:
gap> # <L>
gap> MatricesQA(2,B,GB) = List([1,2], q -> MatrixQA(q,B,GB));
true
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-MatrixQAC">
gap> # <E>Example:</E>
gap> 
gap> # Consider the following two polynomials in NP format.
gap> # <L>
gap> F := GF(256);
GF(2^8)
gap> z := GeneratorsOfField(F)[1];
Z(2^8)
gap> p1 := [[[1,1,1,2],[]],[z,1]];;
gap> p2 := [[[2,2,2,1],[]],[1,z]];;
gap> # </L>
gap> 
gap> # The polynomials <C>p1</C> and  <C>p2</C> have coefficients in
gap> # the field <C>F</C> of order 256.
gap> # The matrix of right multiplication by the first indeterminate <M>a</M>
gap> # on the quotient algebra is obtained by applying <C>MatrixQAC</C>
gap> # just like <Ref Func="MatrixQA" Style="Text"/>. The difference is
gap> # that the result is in another format.
gap> # <L>
gap> GB := Grobner([p1,p2]);
[ [ [ [ 1, 1, 1, 2 ], [  ] ], [ Z(2)^0, Z(2^8)^254 ] ], 
  [ [ [ 2, 2 ], [ 1, 1 ] ], [ Z(2)^0, Z(2^8)^2 ] ], 
  [ [ [ 2, 1 ], [ 1, 2 ] ], [ Z(2)^0, Z(2)^0 ] ], 
  [ [ [ 1, 1, 1, 1, 1 ], [ 2 ] ], [ Z(2)^0, Z(2^8)^252 ] ] ]
gap> B := BaseQA(GB,2,0);
[ [ [ [  ] ], [ Z(2)^0 ] ], [ [ [ 1 ] ], [ Z(2)^0 ] ], 
  [ [ [ 2 ] ], [ Z(2)^0 ] ], [ [ [ 1, 1 ] ], [ Z(2)^0 ] ], 
  [ [ [ 1, 2 ] ], [ Z(2)^0 ] ], [ [ [ 1, 1, 1 ] ], [ Z(2)^0 ] ], 
  [ [ [ 1, 1, 2 ] ], [ Z(2)^0 ] ], [ [ [ 1, 1, 1, 1 ] ], [ Z(2)^0 ] ] ]
gap> MatrixQAC(1, B,GB);
< mutable compressed matrix 8x8 over GF(256) >
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-MatricesQAC">
gap> # <E>Example:</E>
gap> 
gap> # Consider the following two polynomials in NP format.
gap> # <L>
gap> F := GF(256);
GF(2^8)
gap> z := GeneratorsOfField(F)[1];
Z(2^8)
gap> p1 := [[[1,1,1,2],[]],[z,1]];;
gap> p2 := [[[2,2,2,1],[]],[1,z]];;
gap> # </L>
gap> 
gap> # The polynomials <C>p1</C> and  <C>p2</C> have coefficients in
gap> # the field <C>F</C> of order 256.
gap> # The matrices of right multiplication by the indeterminates
gap> # on the quotient algebra  are just like for
gap> # <Ref Func="MatricesQA" Style="Text"/> except for the format of the result.
gap> # <L>
gap> GB := Grobner([p1,p2]);
[ [ [ [ 1, 1, 1, 2 ], [  ] ], [ Z(2)^0, Z(2^8)^254 ] ], 
  [ [ [ 2, 2 ], [ 1, 1 ] ], [ Z(2)^0, Z(2^8)^2 ] ], 
  [ [ [ 2, 1 ], [ 1, 2 ] ], [ Z(2)^0, Z(2)^0 ] ], 
  [ [ [ 1, 1, 1, 1, 1 ], [ 2 ] ], [ Z(2)^0, Z(2^8)^252 ] ] ]
gap> B := BaseQA(GB,2,0);
[ [ [ [  ] ], [ Z(2)^0 ] ], [ [ [ 1 ] ], [ Z(2)^0 ] ], 
  [ [ [ 2 ] ], [ Z(2)^0 ] ], [ [ [ 1, 1 ] ], [ Z(2)^0 ] ], 
  [ [ [ 1, 2 ] ], [ Z(2)^0 ] ], [ [ [ 1, 1, 1 ] ], [ Z(2)^0 ] ], 
  [ [ [ 1, 1, 2 ] ], [ Z(2)^0 ] ], [ [ [ 1, 1, 1, 1 ] ], [ Z(2)^0 ] ] ]
gap> MatricesQAC(2,B,GB);
[ < mutable compressed matrix 8x8 over GF(256) >, 
  < mutable compressed matrix 8x8 over GF(256) > ]
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-PreprocessAnalysisQA">
gap> # <E>Example:</E>
gap> 
gap> # Consider the following two polynomials in NP format of which a Gröbner
gap> # basis is computed.
gap> # <L>
gap> # F := GF(256);
gap> # z := GeneratorsOfField(F)[1];
gap> p1 := [[[1,1,1,1,2],[]],[1,-1]];;
gap> p2 := [[[2,2,2,1,1,1],[]],[1,-1]];;
gap> GB := Grobner([p1,p2]);;
gap> PrintNPList(GB);
 a^4b - 1 
 ba - ab 
 b^2 - a 
 a^5 - b 
gap> # </L>
gap> 
gap> # Application of <C>PreprocessAnalysisQA</C> is carried out on the leading terms of
gap> # <C>GB</C>, with 2, 4, 8, recursions, respectively.
gap> # <L>
gap> L := LMonsNP(GB);
[ [ 1, 1, 1, 1, 2 ], [ 2, 1 ], [ 2, 2 ], [ 1, 1, 1, 1, 1 ] ]
gap> L1 := PreprocessAnalysisQA(L,2,2);
[ [ 1, 1, 1 ], [ 2, 1 ], [ 1, 1, 2 ], [ 2, 2 ] ]
gap> L2 := PreprocessAnalysisQA(L1,2,4);
[ [ 1 ], [ 2 ] ]
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-EvalTrace">
gap> # <E>Example:</E>
gap> 
gap> 
gap> # First we compute the
gap> # traced Gröbner basis
gap> # of the list of the
gap> # following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[2,2,1],[]],[1,-1]];;
gap> Lnp := [p1,p2];;
gap> GBT := SGrobnerTrace(Lnp);;
gap> # </L>
gap> 
gap> # In order to check that the polynomials in <C>GBT</C> belong to the ideal
gap> # generated by <C>p1</C> and <C>p2</C>, we evaluate the trace.
gap> # For each traced polynomial <C>p</C> in <C>GBT</C>, 
gap> # the polynomial <C>p.pol</C> is equated to the evaluated expression
gap> # <C>p.trace</C>,
gap> # in which each occurrence of <C>G(i)</C> is replaced by <C>Lnp[i]</C>
gap> # by  use of <Ref Func="EvalTrace" Style="Text"/>.
gap> 
gap> # <L>
gap> ForAll(GBT,q -> EvalTrace(q,Lnp) = q.pol);
true
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-SGrobnerTrace">
gap> # <E>Example:</E>
gap> 
gap> # For the list of the
gap> # following two polynomials in NP format, a traced Gröbner
gap> # basis is computed.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[2,2,1],[]],[1,-1]];;
gap> GBT := SGrobnerTrace([p1,p2]);
[ rec( pol := [ [ [ 2 ], [ 1 ] ], [ 1, -1 ] ], 
      trace := [ [ [  ], 1, [ 2, 1, 1, 2 ], -1 ], [ [ 2 ], 1, [  ], -1 ], 
          [ [ 1 ], 1, [  ], 1 ], [ [ 1, 1 ], 2, [ 1, 2 ], 1 ] ] ), 
  rec( pol := [ [ [ 1, 1, 1 ], [  ] ], [ 1, -1 ] ], 
      trace := [ [ [ 2 ], 1, [ 2, 1 ], 1 ], [ [  ], 1, [ 2, 1, 1 ], 1 ], 
          [ [  ], 2, [  ], 1 ], [ [ 2, 1, 1 ], 2, [  ], -1 ], 
          [ [ 1, 1 ], 2, [ 1 ], -1 ] ] ) ]
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-StrongNormalFormTraceDiff">
gap> # <E>Example:</E>
gap> 
gap> # First we compute the
gap> # traced Gröbner basis
gap> # of the list of the
gap> # following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[2,2,1],[]],[1,-1]];;
gap> GBT := SGrobnerTrace([p1,p2]);;
gap> # </L>
gap> 
gap> 
gap> # Of the polynomial <M>a^6</M> we compute its
gap> # difference with the normal form.
gap> # The result is printed by used of <Ref Func="PrintNP" Style="Text"/>
gap> # and  <Ref Func="PrintTraceList" Style="Text"/>.
gap> # <L>
gap> f := [[[1,1,1,1,1,1]],[1]];;
gap> sf := StrongNormalFormTraceDiff(f,GBT);;
gap> PrintNP(sf.pol);
 a^6 - 1 
gap> PrintTraceList([sf]);
 G(1)ba^2 + bG(1)ba + G(1)ba^5 + bG(1)ba^4 + G(2) + G(2)a^3 - a^2G(
2)a - ba^2G(2) - a^2G(2)a^4 - ba^2G(2)a^3 
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-SGrobnerTrunc">
gap> # <E>Example:</E>
gap> 
gap> # Consider the
gap> # following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,2,2,1],[2,1,1,2]],[1,-1]];;
gap> p2 := [[[2,2,2],[1,1]],[1,-1]];;
gap> PrintNPList([p1,p2]);
 ab^2a - ba^2b 
 b^3 - a^2 
gap> # </L>
gap> 
gap> 
gap> # These are homogeneous with respect to weights <M>[3,2]</M>.
gap> # The degrees are <M>10</M> and <M>6</M>, respectively.
gap> # The Gröbner basis truncated above degree 12 of the list <C>[p1,p2]</C>
gap> # is computed and subsequently printed as follows.
gap> 
gap> # <L>
gap> PrintNPList(SGrobnerTrunc([p1,p2],12,[3,2]));
 ba^2 - a^2b 
 b^3 - a^2 
 ab^2a - a^2b^2 
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-CheckHomogeneousNPs">
gap> # <E>Example:</E>
gap> 
gap> # Consider the
gap> # following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,2,2,1],[2,1,1,2]],[1,-1]];;
gap> p2 := [[[2,2,2],[1,1]],[1,-1]];;
gap> PrintNPList([p1,p2]);
 ab^2a - ba^2b 
 b^3 - a^2 
gap> # </L>
gap> 
gap> 
gap> # These are homogeneous with respect to weights <M>[3,2]</M>.
gap> # The degrees are <M>10</M> and <M>6</M>, respectively.
gap> # This is checked as follows.
gap> 
gap> # <L>
gap> CheckHomogeneousNPs([p1,p2],[3,2]);
[ 10, 6 ]
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-BaseQATrunc">
gap> # <E>Example:</E>
gap> 
gap> # Consider the truncated Gröbner basis
gap> # of the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,2,2,1],[2,1,1,2]],[1,-1]];;
gap> p2 := [[[2,2,2],[1,1]],[1,-1]];;
gap> wtv := [3,2];;
gap> GB := SGrobnerTrunc([p1,p2],12,wtv);;
gap> GBNP.ConfigPrint("a","b");
gap> PrintNPList(GB);
 ba^2 - a^2b 
 b^3 - a^2 
 ab^2a - a^2b^2 
gap> # </L>
gap> 
gap> 
gap> # A basis of standard monomials is found and printed as follows.
gap> 
gap> # <L>
gap> BT := BaseQATrunc(GB,12,wtv);;
gap> for degpart in BT do 
>   for mon in degpart do PrintNP([[mon],[1]]); od;
> od;
 1 
 b 
 a 
 b^2 
 ba 
 ab 
 a^2 
 b^3 
 b^2a 
 bab 
 ab^2 
 aba 
 a^2b 
 b^4 
 a^3 
 b^3a 
 b^2ab 
 bab^2 
 ab^3 
 baba 
 abab 
 a^2b^2 
 b^5 
 a^2ba 
 b^4a 
 a^3b 
 b^3ab 
 b^2ab^2 
 bab^3 
 ab^4 
 a^4 
 b^2aba 
 ab^3a 
 babab 
 abab^2 
 a^2b^3 
 b^6 
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-DimsQATrunc">
gap> # <E>Example:</E>
gap> 
gap> # Consider the truncated Gröbner basis
gap> # of the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,2,2,1],[2,1,1,2]],[1,-1]];;
gap> p2 := [[[2,2,2],[1,1]],[1,-1]];;
gap> wtv := [3,2];;
gap> GB := SGrobnerTrunc([p1,p2],12,wtv);;
gap> # </L>
gap> 
gap> 
gap> # Information on the dimensions of the homogeneous parts
gap> # of the quotient algebra is found as follows,
gap> 
gap> # <L>
gap> DimsQATrunc(GB,12,wtv);
[ 1, 0, 1, 1, 1, 2, 2, 3, 3, 5, 4, 7, 7 ]
gap> # </L>
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-FreqsQATrunc">
gap> # <E>Example:</E>
gap> 
gap> # Consider the truncated Gröbner basis
gap> # of the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,2,2,1],[2,1,1,2]],[1,-1]];;
gap> p2 := [[[2,2,2],[1,1]],[1,-1]];;
gap> wtv := [3,2];;
gap> GB := SGrobnerTrunc([p1,p2],12,wtv);;
gap> PrintNPList(GB);
 ba^2 - a^2b 
 b^3 - a^2 
 ab^2a - a^2b^2 
gap> # </L>
gap> 
gap> 
gap> # The multiplicities of the frequencies of
gap> # of monomials in a standard basis
gap> # of the quotient algebra with respect to the ideal generated by
gap> # <C>GB</C> is found as follows, for weights up to and including 8.
gap> 
gap> # <L>
gap> F := FreqsQATrunc(GB,8,wtv);
[ [ [ [  ], 1 ] ], [ [ [ 0, 1 ], 1 ] ], [ [ [ 1, 0 ], 1 ] ], 
  [ [ [ 0, 2 ], 1 ] ], [ [ [ 1, 1 ], 2 ] ], 
  [ [ [ 2, 0 ], 1 ], [ [ 0, 3 ], 1 ] ], [ [ [ 1, 2 ], 3 ] ], 
  [ [ [ 2, 1 ], 2 ], [ [ 0, 4 ], 1 ] ] ]
gap> # </L>
gap> 
gap> # The interpretation of this data is given by the following lines of code.
gap> 
gap> # <L>
gap> for f in F do
>   if f[1][1] <> [] then
>     Print("At level ", wtv * (f[1][1]), " the multiplicities are\n");
>     for x in f do
>       Print("  for ",x[1],": ",x[2],"\n");
>     od;
>   else
>     Print("At level ", 0 , " the multiplicity of [] is ",f[1][2],"\n");
>   fi;
>   Print("\n");
> od;
At level 0 the multiplicity of [] is 1

At level 2 the multiplicities are
  for [ 0, 1 ]: 1

At level 3 the multiplicities are
  for [ 1, 0 ]: 1

At level 4 the multiplicities are
  for [ 0, 2 ]: 1

At level 5 the multiplicities are
  for [ 1, 1 ]: 2

At level 6 the multiplicities are
  for [ 2, 0 ]: 1
  for [ 0, 3 ]: 1

At level 7 the multiplicities are
  for [ 1, 2 ]: 3

At level 8 the multiplicities are
  for [ 2, 1 ]: 2
  for [ 0, 4 ]: 1

gap> # </L>
gap> 
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-PrintTraceList">
gap> # <E>Example:</E>
gap> 
gap> # First we compute the
gap> # traced Gröbner basis
gap> # of the list of two polynomials in NP format and next we print it
gap> # by use of <C>PrintTraceList</C>.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[2,2,1],[]],[1,-1]];;
gap> GBT := SGrobnerTrace([p1,p2]);;
gap> PrintTraceList(GBT);
 aG(1) - bG(1) - G(1)ba^2b + a^2G(2)ab 

 G(1)ba^2 + bG(1)ba + G(2) - a^2G(2)a - ba^2G(2) 
gap> # </L>
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-PrintTracePol">
gap> # <E>Example:</E>
gap> 
gap> # First we compute the
gap> # traced Gröbner basis
gap> # of the list of two polynomials in NP format. Next we print 
gap> # the trace polynomial of the members of the list
gap> # by use of <C>PrintTracePol</C>.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[2,2,1],[]],[1,-1]];;
gap> GBT := SGrobnerTrace([p1,p2]);;
gap> for np in GBT do PrintTracePol(np); Print("\n"); od;
 aG(1) - bG(1) - G(1)ba^2b + a^2G(2)ab 

 G(1)ba^2 + bG(1)ba + G(2) - a^2G(2)a - ba^2G(2) 

gap> # </L>
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-PrintNPListTrace">
gap> # <E>Example:</E>
gap> 
gap> # First we compute the
gap> # traced Gröbner basis
gap> # of the list of two polynomials in NP format.
gap> # Next we print the polynomials found
gap> # by use of <C>PrintNPListTrace</C>.
gap> # <L>
gap> p1 := [[[1,1,2],[]],[1,-1]];;
gap> p2 := [[[2,2,1],[]],[1,-1]];;
gap> GBT := SGrobnerTrace([p1,p2]);;
gap> PrintNPListTrace(GBT);
 b - a 
 a^3 - 1 
gap> # </L>
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-DetermineGrowthQA">
gap> # <E>Example:</E>
gap> 
gap> # For the list of monomials consisting of a single variable in a free algebra
gap> # generated by two variables the growth is clearly polynomial of degree 1.
gap> # This is verified by invoking <C>DetermineGrowthQA</C> with arguments
gap> # <C>[[1]]</C>
gap> # (the list of the single monomial consisting of the first variable),
gap> # the number of generators of the free algebra to which the monomials belong
gap> # (which is 2 here),
gap> # and the boolean <C>true</C> indicating that we wish a precise degree
gap> # in case of polynomial growth.
gap> 
gap> 
gap> # <L>
gap> DetermineGrowthQA([[1]],2,true);
1
gap> # </L>
gap> 
gap> # Here is an example of polynomial growth of degree 2:
gap> 
gap> 
gap> # <L>
gap> L := [[1,2,1],[2,2,1]];
[ [ 1, 2, 1 ], [ 2, 2, 1 ] ]
gap> DetermineGrowthQA(L,2,true);
2
gap> # </L>
gap> 
gap> 
gap> # In order to show how to apply the function
gap> # to arbitrary polynomials, consider
gap> # the following two polynomials in NP format.
gap> 
gap> # <L>
gap> F := GF(256);
GF(2^8)
gap> z := GeneratorsOfField(F)[1];
Z(2^8)
gap> p1 := [[[1,1,1,2],[]],[z,1]];;
gap> p2 := [[[2,2,2,1],[]],[1,z]];;
gap> # </L>
gap> 
gap> # The polynomials <C>p1</C> and  <C>p2</C> have coefficients in
gap> # the field <C>F</C> of order 256.
gap> 
gap> # In order to study the growth of the quotient algebra
gap> # we first compute the list of leading monomials of 
gap> # the Gröbner basis elements and next apply 
gap> # <C>DetermineGrowthQA</C>.
gap> 
gap> # <L>
gap> GB := Grobner([p1,p2]);;
gap> L := LMonsNP(GB);;
gap> for lm  in L  do PrintNP( [ [ lm ], [ 1 ] ] ); od;
 a^3b 
 b^2 
 ba 
 a^5 
gap> DetermineGrowthQA(L,2,true);
0
gap> # </L>
gap> 
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> 
gap> # <#GAPDoc Label="example-FinCheckQA">
gap> # <E>Example:</E>
gap> 
gap> # Consider the following list <C>L</C> of two monomials.
gap> # <L>
gap> L := [[1,2,1],[2,2,1]];;
gap> # </L>
gap> 
gap> # Finiteness of the dimension of the quotient algebra of the free algebra
gap> # by the ideal generated by these two monomials can be 
gap> # decided by means of <C>FinCheckQA</C>.
gap> # Its arguments are <C>L</C> and the number of generators of the free algebra
gap> # in which the monomials reside.
gap> 
gap> # <L>
gap> FinCheckQA(L,2);
false
gap> # </L>
gap> 
gap> # This example turns out to be infinite dimensional.
gap> # Here is a finite-dimensional example.
gap> 
gap> # <L>
gap> FinCheckQA([[1],[2,2]],2);
true
gap> # </L>
gap> 
gap> 
gap> 
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-HilbertSeriesQA">
gap> # <E>Example:</E>
gap> 
gap> # Consider the following list <C>L</C> of two monomials.
gap> # <L>
gap> L := [[1,2,1],[2,2,1]];;
gap> # </L>
gap> 
gap> # Finiteness of the dimension of the quotient algebra of the free algebra
gap> # by the ideal generated by these two monomials can be 
gap> # decided by means of <C>FinCheckQA</C>.
gap> # Its arguments are <C>L</C> and the number of generators of the free algebra
gap> # in which the monomials reside.
gap> 
gap> # <L>
gap> HilbertSeriesQA(L,2,10);
[ 1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20 ]
gap> # </L>
gap> 
gap> 
gap> # This indicates that the growth may be polynomial.
gap> # <Ref Func="DetermineGrowthQA" Style="Text"/> can be used to check this.
gap> 
gap> # <#/GAPDoc>
gap> 
gap> # reset printing; note not inside a GAPDoc part here
gap> # <L>
gap> GBNP.ConfigPrint();
gap> # </L>
gap> 
gap> # <#GAPDoc Label="example-NumAlgGensNP">
gap> # <E>Example:</E>
gap> 
gap> # Consider the following polynomial in NP format.
gap> # <L>
gap> np := [[[2,2,2,1,1,1],[4],[3,2,3]],[1,-3,2]];;
gap> PrintNP(np);
 b^3a^3 - 3d + 2cbc 
gap> NumAlgGensNP(np);
4
gap> # </L>
gap> # <#/GAPDoc>
gap> 
gap> # <#GAPDoc Label="example-NumAlgGensNPList">
gap> # <E>Example:</E>
gap> 
gap> # Consider the following two polynomials in NP format.
gap> # <L>
gap> p1 := [[[1,1,2,3,1],[2],[1]],[1,-2,1]];;
gap> p2 := [[[2,2,1,4,3],[]],[1,-1]];;
gap> PrintNPList([p1,p2]);
 a^2bca - 2b + a 
 b^2adc - 1 
gap> NumAlgGensNPList([p1,p2]);
4
gap> # </L>
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-NumModGensNP">
gap> # <E>Example:</E>
gap> 
gap> # Consider the following polynomial in NPM format.
gap> # <L>
gap> np := [[[-1,1,2,3,1],[-2],[-1]],[1,-2,1]];;
gap> PrintNP(np);
[ abca + 1 , - 2 ]
gap> NumModGensNP(np);
2
gap> # </L>
gap> # <#/GAPDoc>
gap> 
gap> 
gap> # <#GAPDoc Label="example-NumModGensNPList">
gap> # <E>Example:</E>
gap> 
gap> # Consider the following two polynomials in NPM format.
gap> # <L>
gap> v1 := [[[-1,1,2,3,1],[-2],[-1]],[1,-2,1]];;
gap> v2 := [[[-2,2,1,4,3],[-3]],[1,-1]];;
gap> PrintNPList([v1,v2]);
[ abca + 1 , - 2 ]
[ 0, badc , - 1 ]
gap> NumModGensNPList([v1,v2]);
3
gap> # </L>
gap> # <#/GAPDoc>
gap> STOP_TEST("test-functions.g.g",10000);
gap> LoadPackage("gbnp");
true
gap> GBNP.ConfigPrint();
gap> 
gap> # reset Info levels
gap> SetInfoLevel(InfoGBNP,0);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> 
gap> # reset options
gap> GBNP.ClearOptions();
gap> START_TEST("GBNP test-bound-01.g");
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
gap> LoadPackage("gbnp");
true
gap> 
gap> # GP2NP
gap> 
gap> A1:=FreeAssociativeAlgebraWithOne(Rationals,"a","b");;
gap> GP2NP(One(A1)) = [[[]],[1]];
true
gap> GP2NP(Zero(A1)) = [[],[]];
true
gap> 
gap> A2:=FreeAssociativeAlgebraWithOne(GF(2),"a");;
gap> GP2NP(One(A2)) = [[[]],[Z(2)^0]];
true
gap> 
gap> GP2NPList([])=[];
true
gap> 
gap> # NP2GP
gap> NP2GP([[[]],[Z(2)^0]],A2)=One(A2);
true
gap> NP2GP([[],[]],A2)=Zero(A2);
true
gap> NP2GP([[],[]],A1)=Zero(A1);
true
gap> 
gap> NP2GPList([],A1)=[];
true
gap> STOP_TEST("test-bound-01.g.g",10000);
gap> LoadPackage("gbnp");
true
gap> GBNP.ConfigPrint();
gap> 
gap> # reset Info levels
gap> SetInfoLevel(InfoGBNP,0);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> 
gap> # reset options
gap> GBNP.ClearOptions();
gap> START_TEST("GBNP test-bound-02.g");
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
gap> LoadPackage("gbnp");
true
gap> 
gap> # printing examples (more can be added)
gap> 
gap> A2:=FreeAssociativeAlgebraWithOne(GF(2),"a");;
gap> 
gap> GBNP.ConfigPrint(A2);
gap> # should show 0*Z(2) XXX doesn't
gap> PrintNP([[],[]]);
 0
gap> STOP_TEST("test-bound-02.g.g",10000);
gap> LoadPackage("gbnp");
true
gap> GBNP.ConfigPrint();
gap> 
gap> # reset Info levels
gap> SetInfoLevel(InfoGBNP,0);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> 
gap> # reset options
gap> GBNP.ClearOptions();
gap> START_TEST("GBNP test-bound-03.g");
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
gap> LoadPackage("gbnp");
true
gap> 
gap> # calculation examples 
gap> 
gap> # NumAlgGensNP
gap> NumAlgGensNP([[],[]])=0;
true
gap> NumAlgGensNP([[[]],[1]])=0;
true
gap> NumAlgGensNP([[[1,2],[3]],[1,-1]])=3;
true
gap> 
gap> # NumAlgGensNPList
gap> NumAlgGensNPList([])=0;
true
gap> NumAlgGensNPList([[[],[]]])=0;
true
gap> NumAlgGensNPList([[[],[]],[[[]],[1]]])=0;
true
gap> NumAlgGensNPList([[[],[]],[[[]],[1]],[[[1,2],[3]],[1,-1]]])=3;
true
gap> 
gap> # NumModGensNP
gap> NumModGensNP([[],[]])=0;
true
gap> NumModGensNP([[[]],[1]])=0;
true
gap> NumModGensNP([[[1,2],[3]],[1,-1]])=0;
true
gap> 
gap> # AddNP
gap> F:=Rationals;;
gap> NPzero:=[[],[]];;
gap> NPone:=[[[]],[One(F)]];;
gap> AddNP(NPzero,NPzero,One(F),One(F))=NPzero;
true
gap> AddNP(NPone,NPone,One(F),-One(F))=NPzero;
true
gap> AddNP(NPzero,NPone,One(F),One(F))=NPone;
true
gap> AddNP(NPone,NPone,One(F),One(F))=AddNP(NPone,NPzero,One(F)+One(F),One(F));
true
gap> F:=GF(2);;
gap> NPone:=[[[]],[One(F)]];;
gap> AddNP(NPzero,NPzero,One(F),One(F))=NPzero;
true
gap> AddNP(NPone,NPone,One(F),-One(F))=NPzero;
true
gap> AddNP(NPzero,NPone,One(F),One(F))=NPone;
true
gap> AddNP(NPone,NPone,One(F),One(F))=AddNP(NPone,NPzero,One(F)+One(F),One(F));
true
gap> AddNP(NPone,NPone,One(F),One(F))=NPzero; #field
true
gap> 
gap> # BimulNP
gap> # NOTE only testing zero/one case
gap> F:=Rationals;;
gap> NPzero:=[[],[]];;
gap> NPone:=[[[]],[One(F)]];;
gap> BimulNP([],NPzero,[])=NPzero;
true
gap> BimulNP([1],NPzero,[2])=NPzero;
true
gap> BimulNP([],NPzero,[2])=NPzero;
true
gap> BimulNP([1],NPzero,[])=NPzero;
true
gap> BimulNP([1],NPone,[])=[[[1]],[One(F)]];
true
gap> BimulNP([],NPone,[2])=[[[2]],[One(F)]];
true
gap> BimulNP([1],NPone,[2])=[[[1,2]],[One(F)]];
true
gap> 
gap> # CleanNP
gap> F:=Rationals;;
gap> NPzero:=[[],[]];;
gap> NPone:=[[[]],[One(F)]];;
gap> CleanNP(NPzero)=NPzero;
true
gap> CleanNP(NPone)=NPone;
true
gap> F:=GF(2);;
gap> NPzero:=[[],[]];;
gap> NPone:=[[[]],[One(F)]];;
gap> CleanNP(NPzero)=NPzero;
true
gap> CleanNP(NPone)=NPone;
true
gap> CleanNP(2*NPone)=NPzero;
true
gap> CleanNP([[[1],[1]],[One(F),One(F)]])=NPzero; # field
true
gap> 
gap> # GtNP
gap> M0:=[];;
gap> M1:=[1];;
gap> GtNP(M0,M0)=false;
true
gap> GtNP(M0,M1)=false;
true
gap> GtNP(M1,M0)=true;
true
gap> GtNP(M1,M1)=false;
true
gap> 
gap> # LtNP
gap> M0:=[];;
gap> M1:=[1];;
gap> LtNP(M0,M0)=false;
true
gap> LtNP(M0,M1)=true;
true
gap> LtNP(M1,M0)=false;
true
gap> LtNP(M1,M1)=false;
true
gap> 
gap> # LMonsNP
gap> F:=Rationals;;
gap> NPzero:=[[],[]];;
gap> NPone:=[[[]],[One(F)]];;
gap> M0:=[];;
gap> 
gap> # fails if zero occurs in the list -> what is the leading monomial of zero ??
gap> # not sure what the desired action should be (fail perhaps ?)
gap> # might be better to document this
gap> LMonsNP([])=[];
true
gap> #LMonsNP([NPzero])=[]; 
gap> LMonsNP([NPone])=[M0];
true
gap> #LMonsNP([NPone,NPzero])=[M0];
gap> LMonsNP([NPone,NPone])=[M0,M0];
true
gap> 
gap> # MkMonicNP
gap> F:=Rationals;;
gap> NPzero:=[[],[]];;
gap> NPone:=[[[]],[One(F)]];;
gap> MkMonicNP(NPzero)=NPzero;
true
gap> MkMonicNP(NPone)=NPone;
true
gap> MkMonicNP(2*NPone)=NPone;
true
gap> 
gap> # MulNP
gap> F:=Rationals;;
gap> NPzero:=[[],[]];;
gap> NPone:=[[[]],[One(F)]];;
gap> MulNP(NPzero,NPzero)=NPzero;
true
gap> MulNP(NPone,NPzero)=NPzero;
true
gap> MulNP(NPone,NPzero)=NPzero;
true
gap> MulNP(NPone,NPone)=NPone;
true
gap> 
gap> STOP_TEST("test-bound-03.g.g",10000);
gap> LoadPackage("gbnp");
true
gap> GBNP.ConfigPrint();
gap> 
gap> # reset Info levels
gap> SetInfoLevel(InfoGBNP,0);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> 
gap> # reset options
gap> GBNP.ClearOptions();
gap> START_TEST("GBNP test-bound-04.g");
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
gap> LoadPackage("gbnp");
true
gap> 
gap> # grobner basis examples
gap> 
gap> # Grobner
gap> F:=Rationals;;
gap> NPone:=[[[]],[One(F)]];;
gap> NPzero:=[[],[]];;
gap> Grobner([])=[];
true
gap> Grobner([NPzero])=[]; 
true
gap> Grobner([NPzero,NPone])=[NPone];
true
gap> F:=GF(2);;
gap> NPone:=[[[]],[One(F)]];;
gap> SGrobner([NPzero,NPone])=[NPone];
true
gap> 
gap> # SGrobner
gap> F:=Rationals;;
gap> NPone:=[[[]],[One(F)]];;
gap> NPzero:=[[],[]];;
gap> SGrobner([])=[];
true
gap> SGrobner([NPzero])=[];
true
gap> SGrobner([NPzero,NPone])=[NPone];
true
gap> F:=GF(2);;
gap> NPone:=[[[]],[One(F)]];;
gap> SGrobner([NPzero,NPone])=[NPone];
true
gap> 
gap> # IsGrobnerBasis
gap> F:=Rationals;;
gap> NPone:=[[[]],[One(F)]];;
gap> NPzero:=[[],[]];;
gap> IsGrobnerBasis([]);
true
gap> IsGrobnerBasis([NPzero]);
true
gap> IsGrobnerBasis([NPone]);
true
gap> IsGrobnerBasis([NPzero, NPone]);
true
gap> IsGrobnerBasis([NPone, NPone]);
true
gap> F:=GF(2);;
gap> NPone:=[[[]],[One(F)]];;
gap> IsGrobnerBasis([NPone]);
true
gap> IsGrobnerBasis([NPzero, NPone]);
true
gap> IsGrobnerBasis([NPone, NPone]);
true
gap> 
gap> # IsStrongGrobnerBasis
gap> F:=Rationals;;
gap> NPone:=[[[]],[One(F)]];;
gap> NPzero:=[[],[]];;
gap> IsStrongGrobnerBasis([]);
true
gap> IsStrongGrobnerBasis([NPzero]);
true
gap> IsStrongGrobnerBasis([NPone]);
true
gap> IsStrongGrobnerBasis([NPzero, NPone]);
true
gap> IsStrongGrobnerBasis([NPone, NPone]);
true
gap> F:=GF(2);;
gap> NPone:=[[[]],[One(F)]];;
gap> IsStrongGrobnerBasis([NPone]);
true
gap> IsStrongGrobnerBasis([NPzero, NPone]);
true
gap> IsStrongGrobnerBasis([NPone, NPone]);
true
gap> 
gap> # IsGrobnerPair
gap> F:=Rationals;;
gap> NPone:=[[[]],[One(F)]];;
gap> NPzero:=[[],[]];;
gap> # some grobner basis checks (zero in G -> then no Grobner Pair)
gap> IsGrobnerPair([],[]);
true
gap> IsGrobnerPair([NPzero],[])=false;
true
gap> IsGrobnerPair([NPone],[]);
true
gap> IsGrobnerPair([NPzero, NPone],[])=false;
true
gap> IsGrobnerPair([NPone, NPone],[]);
true
gap> 
gap> IsGrobnerPair([],[NPzero])=false;
true
gap> IsGrobnerPair([NPone],[NPzero])=false;
true
gap> IsGrobnerPair([NPone, NPone],[NPzero])=false;
true
gap> 
gap> IsGrobnerPair([],[NPone]);
true
gap> IsGrobnerPair([NPone],[NPone]);
true
gap> IsGrobnerPair([NPone, NPone],[NPone]);
true
gap> F:=GF(2);;
gap> NPone:=[[[]],[One(F)]];;
gap> # some grobner basis checks (zero in G -> then no Grobner Pair)
gap> IsGrobnerPair([NPone],[]);
true
gap> IsGrobnerPair([NPzero, NPone],[])=false;
true
gap> IsGrobnerPair([NPone, NPone],[]);
true
gap> 
gap> IsGrobnerPair([],[NPzero])=false;
true
gap> IsGrobnerPair([NPone],[NPzero])=false;
true
gap> IsGrobnerPair([NPone, NPone],[NPzero])=false;
true
gap> 
gap> IsGrobnerPair([],[NPone]);
true
gap> IsGrobnerPair([NPone],[NPone]);
true
gap> IsGrobnerPair([NPone, NPone],[NPone]);
true
gap> 
gap> # MakeGrobnerPair
gap> F:=Rationals;;
gap> NPone:=[[[]],[One(F)]];;
gap> NPzero:=[[],[]];;
gap> # some grobner basis checks (zero in G -> then no Grobner Pair)
gap> check:=function(r,G,todo) return r.G=G and r.todo=todo; end;;
gap> 
gap> check(MakeGrobnerPair([],[]), [], []);
true
gap> check(MakeGrobnerPair([NPzero],[]), [],[]);
true
gap> check(MakeGrobnerPair([NPone],[]),[NPone],[]);
true
gap> check(MakeGrobnerPair([NPzero, NPone],[]),[NPone],[]);
true
gap> check(MakeGrobnerPair([NPone, NPone],[]),[NPone,NPone],[]);
true
gap> 
gap> check(MakeGrobnerPair([],[NPzero]),[],[]);
true
gap> check(MakeGrobnerPair([NPone],[NPzero]),[NPone],[]);
true
gap> check(MakeGrobnerPair([NPone, NPone],[NPzero]),[NPone,NPone],[]);
true
gap> 
gap> check(MakeGrobnerPair([],[NPone]),[],[NPone]);
true
gap> check(MakeGrobnerPair([NPone],[NPone]),[NPone],[NPone]);
true
gap> check(MakeGrobnerPair([NPone, NPone],[NPone]),[NPone,NPone],[NPone]);
true
gap> F:=GF(2);;
gap> NPone:=[[[]],[One(F)]];;
gap> # some grobner basis checks (zero in G -> then no Grobner Pair)
gap> check(MakeGrobnerPair([NPone],[]),[NPone],[]);
true
gap> check(MakeGrobnerPair([NPzero, NPone],[]),[NPone],[]);
true
gap> check(MakeGrobnerPair([NPone, NPone],[]),[NPone,NPone],[]);
true
gap> 
gap> check(MakeGrobnerPair([],[NPzero]),[],[]);
true
gap> check(MakeGrobnerPair([NPone],[NPzero]),[NPone],[]);
true
gap> check(MakeGrobnerPair([NPone, NPone],[NPzero]),[NPone,NPone],[]);
true
gap> 
gap> check(MakeGrobnerPair([],[NPone]),[],[NPone]);
true
gap> check(MakeGrobnerPair([NPone],[NPone]),[NPone],[NPone]);
true
gap> check(MakeGrobnerPair([NPone, NPone],[NPone]),[NPone,NPone],[NPone]);
true
gap> STOP_TEST("test-bound-04.g.g",10000);
gap> LoadPackage("gbnp");
true
gap> GBNP.ConfigPrint();
gap> 
gap> # reset Info levels
gap> SetInfoLevel(InfoGBNP,0);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> 
gap> # reset options
gap> GBNP.ClearOptions();
gap> START_TEST("GBNP test-bound-05.g");
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
gap> LoadPackage("gbnp");
true
gap> 
gap> # BaseQA
gap> F:=Rationals;;
gap> NPone:=[[[]],[One(F)]];;
gap> BaseQA([NPone],0,0)=[];
true
gap> BaseQA([NPone],2,0)=[];
true
gap> BaseQA([],2,5);; # warning length is 7 !
gap> 
gap> # DimQA
gap> DimQA([NPone],0)=0;
true
gap> DimQA([NPone],2)=0;
true
gap> 
gap> # MatrixQA
gap> 
gap> # MatricesQA
gap> 
gap> MatricesQA(1,[],[[[[]],[1]]])=[[]];
true
gap> 
gap> MatricesQA(1,[[[[]],[1]]],[[[[1]],[1]]])=[[[0]]];
true
gap> MatricesQA(1,[[[[]],[1]],[[[1]],[1]]],[[[[1,1]],[1]]])=[[[0,1],[0,0]]];
true
gap> MatricesQA(1,[[[[]],[1]],[[[1]],[1]]],[[[[1,1],[]],[1,-1]]])=[[[0,1],[1,0]]];
true
gap> 
gap> # MulQA
gap> F:=Rationals;;
gap> NPone:=[[[]],[One(F)]];;
gap> NPzero:=[[],[]];;
gap> 
gap> MulQA(NPone,NPone,[])=NPone;
true
gap> MulQA(NPzero,NPone,[])=NPzero;
true
gap> MulQA(NPone,NPzero,[])=NPzero;
true
gap> MulQA(NPzero,NPzero,[])=NPzero;
true
gap> MulQA(NPone,NPone,[NPzero])=NPone;
true
gap> MulQA(NPone,NPone,[NPone])=NPzero;
true
gap> 
gap> F:=GF(2);;
gap> NPone:=[[[]],[One(F)]];;
gap> NPzero:=[[],[]];;
gap> 
gap> MulQA(NPone,NPone,[])=NPone;
true
gap> MulQA(NPzero,NPone,[])=NPzero;
true
gap> MulQA(NPone,NPzero,[])=NPzero;
true
gap> MulQA(NPzero,NPzero,[])=NPzero;
true
gap> MulQA(NPone,NPone,[NPzero])=NPone;
true
gap> MulQA(NPone,NPone,[NPone])=NPzero;
true
gap> 
gap> # StrongNormalFormNP
gap> StrongNormalFormNP(NPone,[])=NPone;
true
gap> StrongNormalFormNP(NPzero,[])=NPzero;
true
gap> StrongNormalFormNP(NPone,[NPzero])=NPone;
true
gap> StrongNormalFormNP(NPone,[NPone])=NPzero;
true
gap> StrongNormalFormNP(NPzero,[NPzero])=NPzero;
true
gap> STOP_TEST("test-bound-05.g.g",10000);
gap> LoadPackage("gbnp");
true
gap> GBNP.ConfigPrint();
gap> 
gap> # reset Info levels
gap> SetInfoLevel(InfoGBNP,0);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> 
gap> # reset options
gap> GBNP.ClearOptions();
gap> START_TEST("GBNP test-bound-06.g");
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
gap> LoadPackage("gbnp");
true
gap> 
gap> check:=function (l, i) 
> 	# exact answer matches
> 	if IsInt(l) and l=i then
> 		return true;
> 	fi;
> 	# no exact answer, but correct answer is in interval
> 	if IsList(l) and l[1]<=i and i<=l[2] then
> 		return true;
> 	fi;
> 	# not a correct answer
> 	return false;
> end;
function( l, i ) ... end
gap> 
gap> # DetermineGrowthQA
gap> DetermineGrowthQA([],2,true)="exponential growth";
true
gap> DetermineGrowthQA([[1]],2,true)=1; 
true
gap> DetermineGrowthQA([[1,2]],2,true)=2; 
true
gap> DetermineGrowthQA([[2,1]],2,true)=2;
true
gap> DetermineGrowthQA([[1,2,1],[2,2,1]],2,true)=2; # correct
true
gap> DetermineGrowthQA([[1],[2]],2,true)=0; # correct
true
gap> 
gap> DetermineGrowthQA([],2,false)="exponential growth";
true
gap> DetermineGrowthQA([[1]],2,false)=1; 
true
gap> check(DetermineGrowthQA([[1,2]],2,false),2); 
true
gap> DetermineGrowthQA([[2,1]],2,false)=2;
true
gap> DetermineGrowthQA([[1,2,1],[2,2,1]],2,false)=2; # correct
true
gap> DetermineGrowthQA([[1],[2]],2,false)=0; # correct
true
gap> 
gap> # FinCheckQA
gap> FinCheckQA([],2)=false;
true
gap> FinCheckQA([[]],2);
true
gap> FinCheckQA([[1],[2]],2);
true
gap> FinCheckQA([[1],[2]],2);
true
gap> FinCheckQA([[2]],2)=false;
true
gap> 
gap> # HilbertSeriesQA
gap> HilbertSeriesQA([],2,10)=[1,2,4,8,16,32,64,128,256,512,1024];
true
gap> HilbertSeriesQA([[]],2,10)=[];
true
gap> HilbertSeriesQA([[1,2]],2,10)=[1,2,3,4,5,6,7,8,9,10,11];
true
gap> HilbertSeriesQA([[2,1]],2,10)=[1,2,3,4,5,6,7,8,9,10,11];
true
gap> HilbertSeriesQA([[1]],2,10)=[1,1,1,1,1,1,1,1,1,1,1];
true
gap> HilbertSeriesQA([[1,2,1],[2,2,1]],2,10)=[ 1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20 ];
true
gap> 
gap> # PreprocessAnalysisQA
gap> 
gap> PreprocessAnalysisQA([],2,10)=[];
true
gap> PreprocessAnalysisQA([[]],2,10)=[[]];
true
gap> 
gap> # now for some not completely trivial ones, that tested true when I wrote them
gap> PreprocessAnalysisQA([[1,2],[1,1],[2,2]],2,1)=[[1,1],[2]];
true
gap> PreprocessAnalysisQA([[1,2],[1,1],[2,2]],2,2)=[[1],[2]];
true
gap> STOP_TEST("test-bound-06.g.g",10000);
gap> LoadPackage("gbnp");
true
gap> GBNP.ConfigPrint();
gap> 
gap> # reset Info levels
gap> SetInfoLevel(InfoGBNP,0);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> 
gap> # reset options
gap> GBNP.ClearOptions();
gap> START_TEST("GBNP test-bound-07.g");
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
gap> LoadPackage("gbnp");
true
gap> 
gap> # EvalTrace
gap> NPTzero:=rec(pol:=[[],[]],trace:=[]);;
gap> EvalTrace(NPTzero,[[]])=[[],[]];
true
gap> 
gap> # PrintTraceList
gap> 
gap> PrintTraceList([]);
gap> 
gap> # PrintTracePol
gap> NPTzero:=rec(pol:=[[],[]],trace:=[]);;
gap> PrintTracePol(NPTzero); # note does not print anything (!)

gap> 
gap> # PrintNPListTrace
gap> PrintNPListTrace([]);
gap> 
gap> # SGrobnerTrace
gap> SGrobnerTrace([])=[];
true
gap> SGrobnerTrace([[[],[]]])=[];
true
gap> 
gap> GBT:=SGrobnerTrace([[[[]],[1]]]);;
gap> Length(GBT)=1;
true
gap> GBT[1].pol=[[[]],[1]];
true
gap> GBT[1].trace=[[[],1,[],1]];
true
gap> 
gap> # StrongNormalFormTraceDiff
gap> 
gap> GBT:=SGrobnerTrace([[[[1]],[1]]]);;
gap> 
gap> tr:=StrongNormalFormTraceDiff([[[1]],[1]],GBT);;
gap> tr.pol=[[[1]],[1]];
true
gap> tr.trace=[[[],1,[],1]];
true
gap> # cannot be reduced
gap> tr:=StrongNormalFormTraceDiff([[[]],[1]],GBT);;
gap> tr.pol=[[],[]];
true
gap> tr.trace=[];
true
gap> # cannot be reduced
gap> tr:=StrongNormalFormTraceDiff([[],[]],GBT);;
gap> tr.pol=[[],[]];
true
gap> tr.trace=[];
true
gap> 
gap> GBT:=SGrobnerTrace([[[[]],[1]]]);;
gap> 
gap> tr:=StrongNormalFormTraceDiff([[[1]],[1]],GBT);;
gap> tr.pol=[[[1]],[1]];
true
gap> tr.trace=[[[],1,[1],1]];
true
gap> tr:=StrongNormalFormTraceDiff([[[2]],[1]],GBT);;
gap> tr.pol=[[[2]],[1]];
true
gap> tr.trace=[[[],1,[2],1]];
true
gap> # cannot be reduced
gap> tr:=StrongNormalFormTraceDiff([[],[]],GBT);;
gap> tr.pol=[[],[]];
true
gap> tr.trace=[];
true
gap> STOP_TEST("test-bound-07.g.g",10000);
gap> LoadPackage("gbnp");
true
gap> GBNP.ConfigPrint();
gap> 
gap> # reset Info levels
gap> SetInfoLevel(InfoGBNP,0);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> 
gap> # reset options
gap> GBNP.ClearOptions();
gap> START_TEST("GBNP test-bound-08.g");
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
gap> LoadPackage("gbnp");
true
gap> 
gap> # SGrobnerTrunc
gap> F:=Rationals;;
gap> NPzero:=[[],[]];;
gap> NPone:=[[[]],[One(F)]];;
gap> 
gap> SGrobnerTrunc([NPzero],5,[1,1])=[];
true
gap> SGrobnerTrunc([],5,[1,1])=[];
true
gap> SGrobnerTrunc([NPone],5,[1])=[NPone];
true
gap> 
gap> F:=GF(2);;
gap> NPzero:=[[],[]];;
gap> NPone:=[[[]],[One(F)]];;
gap> 
gap> # CheckHomogeneousNPs
gap> CheckHomogeneousNPs([],[1,1])=[];
true
gap> 
gap> F:=Rationals;;
gap> NPzero:=[[],[]];;
gap> NPone:=[[[]],[One(F)]];;
gap> 
gap> CheckHomogeneousNPs([NPone],[1,1])=[0];
true
gap> 
gap> # XXX NPzero is Homogeneous but the degree can not be determined -> so false is
gap> # returned fail might be better here though
gap> CheckHomogeneousNPs([NPzero],[1,1])=false;
true
gap> 
gap> F:=GF(2);;
gap> NPzero:=[[],[]];;
gap> NPone:=[[[]],[One(F)]];;
gap> 
gap> CheckHomogeneousNPs([NPone],[1,1])=[0];
true
gap> 
gap> # XXX NPzero is Homogeneous but the degree can not be determined -> so false is
gap> # returned fail might be better here though
gap> CheckHomogeneousNPs([NPzero],[1,1])=false;
true
gap> 
gap> # BaseQATrunc
gap> BaseQATrunc([],1,[2,3])=[ [ [] ], [] ];
true
gap> BaseQATrunc([],2,[2,3])=[ [ [] ], [], [ [1] ]];
true
gap> # why GB instead of lterms (to check homogeneous-ness ?)
gap> BaseQATrunc([ [[[1]],[1]] ],2,[2,3])=[ [ [] ], [], [] ];
true
gap> BaseQATrunc([ [[[1]],[1]] ],3,[2,3])=[ [ [] ], [], [], [ [2] ] ];
true
gap> BaseQATrunc([ [[[]],[1]] ],3,[2,3])=[ [], [], [], [] ];
true
gap> BaseQATrunc([ [[[]],[One(GF(3))]] ],3,[2,3])=[ [], [], [], [] ];
true
gap> 
gap> # DimsQATrunc
gap> DimsQATrunc([],1,[2,3])=[1,0];
true
gap> DimsQATrunc([],2,[2,3])=[1,0,1];
true
gap> DimsQATrunc([ [[[1]],[1]] ],2,[2,3])=[1,0,0];
true
gap> DimsQATrunc([ [[[1]],[1]] ],3,[2,3])=[1,0,0,1];
true
gap> DimsQATrunc([ [[[]],[1]] ],3,[2,3])=[0,0,0,0];
true
gap> DimsQATrunc([ [[[]],[One(GF(3))]] ],3,[2,3])=[0,0,0,0];
true
gap> 
gap> # FreqsQATrunc
gap> FreqsQATrunc([],1,[2,3])=[ [ [ [  ], 1 ] ] ];
true
gap> FreqsQATrunc([],2,[2,3])=[ [ [ [  ], 1 ] ], [ [ [ 1, 0 ], 1 ] ] ];
true
gap> FreqsQATrunc([ [[[1]],[1]] ],2,[2,3])=[ [ [ [  ], 1 ] ] ];
true
gap> FreqsQATrunc([ [[[1]],[1]] ],3,[2,3])=[ [ [ [  ], 1 ] ], [ [ [ 0, 1 ], 1 ] ] ];
true
gap> FreqsQATrunc([ [[[]],[1]] ],3,[2,3])=[];
true
gap> FreqsQATrunc([ [[[]],[One(GF(3))]] ],3,[2,3])=[];
true
gap> STOP_TEST("test-bound-08.g.g",10000);
gap> LoadPackage("gbnp");
true
gap> GBNP.ConfigPrint();
gap> 
gap> # reset Info levels
gap> SetInfoLevel(InfoGBNP,0);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> 
gap> # reset options
gap> GBNP.ClearOptions();
gap> START_TEST("GBNP test-bound-09.g");
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
gap> LoadPackage("gbnp");
true
gap> 
gap> NPzero:=[[],[]];;
gap> NPone:=[[[]],[1]];;
gap> NPone_2:=[[[]],[One(GF(2))]];;
gap> NPMone1:=[[[-1,]],[1]];;
gap> NPMone2:=[[[-2,]],[1]];;
gap> NPMone1_2:=[[[-1,]],[One(GF(2))]];;
gap> NPMone2_2:=[[[-2,]],[One(GF(2))]];;
gap> 
gap> GBRempty:=SGrobnerModule([],[]);;
gap> GBRone:=SGrobnerModule([],[NPone]);;
gap> GBRone_12:=SGrobnerModule([NPMone1,NPMone2],[]);;
gap> GBRone_1:=SGrobnerModule([NPMone1],[]);;
gap> # BaseQM
gap> BaseQM(GBRempty,1,1,2);
"infinite"
gap> BaseQM(GBRone,0,0,0)=[];
true
gap> BaseQM(GBRone_12,0,0,0)=[];
true
gap> BaseQM(GBRone_12,0,2,0)=[];
true
gap> 
gap> # DimQM
gap> DimQM(GBRone,0,0)=0;
true
gap> DimQM(GBRone_12,0,0)=0;
true
gap> DimQM(GBRone_12,0,2)=0;
true
gap> 
gap> # MulQM
gap> MulQM(NPone,NPone,GBRempty)=NPone;
true
gap> MulQM(NPone,NPzero,GBRempty)=NPzero;
true
gap> MulQM(NPzero,NPone,GBRempty)=NPzero;
true
gap> MulQM(NPzero,NPzero,GBRempty)=NPzero;
true
gap> MulQM(NPone,NPone,GBRone)=NPzero;
true
gap> MulQM(NPMone1,NPone,GBRone_1)=NPzero;
true
gap> MulQM(NPMone2,NPone,GBRone_1)=NPMone2;
true
gap> 
gap> # SGrobnerModule
gap> # check function 
gap> check:=function(r, p, ts)
> 	return (r.p = p) and (r.ts = ts);
> end;;
gap> 
gap> # first some standard checks
gap> check(SGrobnerModule([],[]), [], []);
true
gap> check(SGrobnerModule([],[NPzero]), [], []);
true
gap> check(SGrobnerModule([],[NPone]), [], [NPone]);
true
gap> check(SGrobnerModule([],[NPone_2]), [], [NPone_2]);
true
gap> # now some prefix checks
gap> check(SGrobnerModule([NPMone1],[]),[NPMone1],[]);
true
gap> check(SGrobnerModule([NPMone1],[NPone]),[],[NPone]);
true
gap> check(SGrobnerModule([NPMone1_2],[NPone_2]),[],[NPone_2]);
true
gap> check(SGrobnerModule([NPMone1_2,NPMone2_2],[NPone_2]),[],[NPone_2]);
true
gap> check(SGrobnerModule([NPMone1_2,NPMone2_2],[]),[NPMone2_2,NPMone1_2],[]);
true
gap> 
gap> # StrongNormalFormNPM
gap> StrongNormalFormNPM(NPzero,GBRempty)=NPzero;
true
gap> StrongNormalFormNPM(NPone,GBRempty)=NPone;
true
gap> StrongNormalFormNPM(NPMone1,GBRempty)=NPMone1;
true
gap> StrongNormalFormNPM(NPMone1,GBRone)=NPzero;
true
gap> StrongNormalFormNPM(NPone,GBRone)=NPzero;
true
gap> StrongNormalFormNPM(NPone,GBRone_12)=NPone;
true
gap> StrongNormalFormNPM(NPMone1,GBRone_12)=NPzero;
true
gap> STOP_TEST("test-bound-09.g.g",10000);
gap> 
