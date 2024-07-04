gap> START_TEST("GBNP test-bound-04");
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
gap> 
gap> STOP_TEST("test-bound-04.g",10000);
