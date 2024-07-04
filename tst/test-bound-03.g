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

# calculation examples

# NumAlgGensNP
NumAlgGensNP([[],[]])=0;
NumAlgGensNP([[[]],[1]])=0;
NumAlgGensNP([[[1,2],[3]],[1,-1]])=3;

# NumAlgGensNPList
NumAlgGensNPList([])=0;
NumAlgGensNPList([[[],[]]])=0;
NumAlgGensNPList([[[],[]],[[[]],[1]]])=0;
NumAlgGensNPList([[[],[]],[[[]],[1]],[[[1,2],[3]],[1,-1]]])=3;

# NumModGensNP
NumModGensNP([[],[]])=0;
NumModGensNP([[[]],[1]])=0;
NumModGensNP([[[1,2],[3]],[1,-1]])=0;

# AddNP
F:=Rationals;;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;
AddNP(NPzero,NPzero,One(F),One(F))=NPzero;
AddNP(NPone,NPone,One(F),-One(F))=NPzero;
AddNP(NPzero,NPone,One(F),One(F))=NPone;
AddNP(NPone,NPone,One(F),One(F))=AddNP(NPone,NPzero,One(F)+One(F),One(F));
F:=GF(2);;
NPone:=[[[]],[One(F)]];;
AddNP(NPzero,NPzero,One(F),One(F))=NPzero;
AddNP(NPone,NPone,One(F),-One(F))=NPzero;
AddNP(NPzero,NPone,One(F),One(F))=NPone;
AddNP(NPone,NPone,One(F),One(F))=AddNP(NPone,NPzero,One(F)+One(F),One(F));
AddNP(NPone,NPone,One(F),One(F))=NPzero; #field

# BimulNP
# NOTE only testing zero/one case
F:=Rationals;;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;
BimulNP([],NPzero,[])=NPzero;
BimulNP([1],NPzero,[2])=NPzero;
BimulNP([],NPzero,[2])=NPzero;
BimulNP([1],NPzero,[])=NPzero;
BimulNP([1],NPone,[])=[[[1]],[One(F)]];
BimulNP([],NPone,[2])=[[[2]],[One(F)]];
BimulNP([1],NPone,[2])=[[[1,2]],[One(F)]];

# CleanNP
F:=Rationals;;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;
CleanNP(NPzero)=NPzero;
CleanNP(NPone)=NPone;
F:=GF(2);;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;
CleanNP(NPzero)=NPzero;
CleanNP(NPone)=NPone;
CleanNP(2*NPone)=NPzero;
CleanNP([[[1],[1]],[One(F),One(F)]])=NPzero; # field

# GtNP
M0:=[];;
M1:=[1];;
GtNP(M0,M0)=false;
GtNP(M0,M1)=false;
GtNP(M1,M0)=true;
GtNP(M1,M1)=false;

# LtNP
M0:=[];;
M1:=[1];;
LtNP(M0,M0)=false;
LtNP(M0,M1)=true;
LtNP(M1,M0)=false;
LtNP(M1,M1)=false;

# LMonsNP
F:=Rationals;;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;
M0:=[];;

# fails if zero occurs in the list -> what is the leading monomial of zero ??
# not sure what the desired action should be (fail perhaps ?)
# might be better to document this
LMonsNP([])=[];
#LMonsNP([NPzero])=[];
LMonsNP([NPone])=[M0];
#LMonsNP([NPone,NPzero])=[M0];
LMonsNP([NPone,NPone])=[M0,M0];

# MkMonicNP
F:=Rationals;;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;
MkMonicNP(NPzero)=NPzero;
MkMonicNP(NPone)=NPone;
MkMonicNP(2*NPone)=NPone;

# MulNP
F:=Rationals;;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;
MulNP(NPzero,NPzero)=NPzero;
MulNP(NPone,NPzero)=NPzero;
MulNP(NPone,NPzero)=NPzero;
MulNP(NPone,NPone)=NPone;

