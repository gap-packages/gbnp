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

# BaseQA
F:=Rationals;;
NPone:=[[[]],[One(F)]];;
BaseQA([NPone],0,0)=[];
BaseQA([NPone],2,0)=[];
BaseQA([],2,5);; # warning length is 7 !

# DimQA
DimQA([NPone],0)=0;
DimQA([NPone],2)=0;

# MatrixQA

# MatricesQA

MatricesQA(1,[],[[[[]],[1]]])=[[]];

MatricesQA(1,[[[[]],[1]]],[[[[1]],[1]]])=[[[0]]];
MatricesQA(1,[[[[]],[1]],[[[1]],[1]]],[[[[1,1]],[1]]])=[[[0,1],[0,0]]];
MatricesQA(1,[[[[]],[1]],[[[1]],[1]]],[[[[1,1],[]],[1,-1]]])=[[[0,1],[1,0]]];

# MulQA
F:=Rationals;;
NPone:=[[[]],[One(F)]];;
NPzero:=[[],[]];;

MulQA(NPone,NPone,[])=NPone;
MulQA(NPzero,NPone,[])=NPzero;
MulQA(NPone,NPzero,[])=NPzero;
MulQA(NPzero,NPzero,[])=NPzero;
MulQA(NPone,NPone,[NPzero])=NPone;
MulQA(NPone,NPone,[NPone])=NPzero;

F:=GF(2);;
NPone:=[[[]],[One(F)]];;
NPzero:=[[],[]];;

MulQA(NPone,NPone,[])=NPone;
MulQA(NPzero,NPone,[])=NPzero;
MulQA(NPone,NPzero,[])=NPzero;
MulQA(NPzero,NPzero,[])=NPzero;
MulQA(NPone,NPone,[NPzero])=NPone;
MulQA(NPone,NPone,[NPone])=NPzero;

# StrongNormalFormNP
StrongNormalFormNP(NPone,[])=NPone;
StrongNormalFormNP(NPzero,[])=NPzero;
StrongNormalFormNP(NPone,[NPzero])=NPone;
StrongNormalFormNP(NPone,[NPone])=NPzero;
StrongNormalFormNP(NPzero,[NPzero])=NPzero;
