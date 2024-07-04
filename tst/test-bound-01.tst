gap> START_TEST("GBNP test-bound-01");
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
gap> 
gap> STOP_TEST("test-bound-01.g",10000);
