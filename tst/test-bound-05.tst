gap> START_TEST("GBNP test-bound-05");
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
gap> 
gap> STOP_TEST("test-bound-05.g",10000);
