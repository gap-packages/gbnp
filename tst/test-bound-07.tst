gap> START_TEST("GBNP test-bound-07");
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
gap> 
gap> STOP_TEST("test-bound-07.g",10000);
