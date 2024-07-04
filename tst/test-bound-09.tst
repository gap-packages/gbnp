gap> START_TEST("GBNP test-bound-09");
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
>   return (r.p = p) and (r.ts = ts);
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
gap> 
gap> STOP_TEST("test-bound-09.g",10000);
