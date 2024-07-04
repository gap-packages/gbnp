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
