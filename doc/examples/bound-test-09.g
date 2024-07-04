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

NPzero:=[[],[]];;
NPone:=[[[]],[1]];;
NPone_2:=[[[]],[One(GF(2))]];;
NPMone1:=[[[-1,]],[1]];;
NPMone2:=[[[-2,]],[1]];;
NPMone1_2:=[[[-1,]],[One(GF(2))]];;
NPMone2_2:=[[[-2,]],[One(GF(2))]];;

GBRempty:=SGrobnerModule([],[]);;
GBRone:=SGrobnerModule([],[NPone]);;
GBRone_12:=SGrobnerModule([NPMone1,NPMone2],[]);;
GBRone_1:=SGrobnerModule([NPMone1],[]);;
# BaseQM
BaseQM(GBRempty,1,1,2);
BaseQM(GBRone,0,0,0)=[];
BaseQM(GBRone_12,0,0,0)=[];
BaseQM(GBRone_12,0,2,0)=[];

# DimQM
DimQM(GBRone,0,0)=0;
DimQM(GBRone_12,0,0)=0;
DimQM(GBRone_12,0,2)=0;

# MulQM
MulQM(NPone,NPone,GBRempty)=NPone;
MulQM(NPone,NPzero,GBRempty)=NPzero;
MulQM(NPzero,NPone,GBRempty)=NPzero;
MulQM(NPzero,NPzero,GBRempty)=NPzero;
MulQM(NPone,NPone,GBRone)=NPzero;
MulQM(NPMone1,NPone,GBRone_1)=NPzero;
MulQM(NPMone2,NPone,GBRone_1)=NPMone2;

# SGrobnerModule
# check function
check:=function(r, p, ts)
        return (r.p = p) and (r.ts = ts);
end;;

# first some standard checks
check(SGrobnerModule([],[]), [], []);
check(SGrobnerModule([],[NPzero]), [], []);
check(SGrobnerModule([],[NPone]), [], [NPone]);
check(SGrobnerModule([],[NPone_2]), [], [NPone_2]);
# now some prefix checks
check(SGrobnerModule([NPMone1],[]),[NPMone1],[]);
check(SGrobnerModule([NPMone1],[NPone]),[],[NPone]);
check(SGrobnerModule([NPMone1_2],[NPone_2]),[],[NPone_2]);
check(SGrobnerModule([NPMone1_2,NPMone2_2],[NPone_2]),[],[NPone_2]);
check(SGrobnerModule([NPMone1_2,NPMone2_2],[]),[NPMone2_2,NPMone1_2],[]);

# StrongNormalFormNPM
StrongNormalFormNPM(NPzero,GBRempty)=NPzero;
StrongNormalFormNPM(NPone,GBRempty)=NPone;
StrongNormalFormNPM(NPMone1,GBRempty)=NPMone1;
StrongNormalFormNPM(NPMone1,GBRone)=NPzero;
StrongNormalFormNPM(NPone,GBRone)=NPzero;
StrongNormalFormNPM(NPone,GBRone_12)=NPone;
StrongNormalFormNPM(NPMone1,GBRone_12)=NPzero;
