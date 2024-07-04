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

LoadPackage("gbnp", false);

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
