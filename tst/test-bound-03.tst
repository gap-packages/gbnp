gap> START_TEST("GBNP test-bound-03");
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
gap> LoadPackage("gbnp", false);
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
gap> # (04/09/23) the function now returns 'fail'
gap> LMonsNP([])=[];
true
gap> #LMonsNP([NPzero])=[];
gap> LMonsNP([NPone])=[M0];
true
gap> LMonsNP([NPone,NPzero]);
[ [  ], fail ]
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
gap> 
gap> STOP_TEST("test-bound-03.g",10000);
