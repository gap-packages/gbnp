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

# SGrobnerTrunc
F:=Rationals;;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;

SGrobnerTrunc([NPzero],5,[1,1])=[];
SGrobnerTrunc([],5,[1,1])=[];
SGrobnerTrunc([NPone],5,[1])=[NPone];

F:=GF(2);;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;

# CheckHomogeneousNPs
CheckHomogeneousNPs([],[1,1])=[];

F:=Rationals;;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;

CheckHomogeneousNPs([NPone],[1,1])=[0];

# XXX NPzero is Homogeneous but the degree can not be determined -> so false is
# returned fail might be better here though
CheckHomogeneousNPs([NPzero],[1,1])=false;

F:=GF(2);;
NPzero:=[[],[]];;
NPone:=[[[]],[One(F)]];;

CheckHomogeneousNPs([NPone],[1,1])=[0];

# XXX NPzero is Homogeneous but the degree can not be determined -> so false is
# returned fail might be better here though
CheckHomogeneousNPs([NPzero],[1,1])=false;

# BaseQATrunc
BaseQATrunc([],1,[2,3])=[ [ [] ], [] ];
BaseQATrunc([],2,[2,3])=[ [ [] ], [], [ [1] ]];
# why GB instead of lterms (to check homogeneous-ness ?)
BaseQATrunc([ [[[1]],[1]] ],2,[2,3])=[ [ [] ], [], [] ];
BaseQATrunc([ [[[1]],[1]] ],3,[2,3])=[ [ [] ], [], [], [ [2] ] ];
BaseQATrunc([ [[[]],[1]] ],3,[2,3])=[ [], [], [], [] ];
BaseQATrunc([ [[[]],[One(GF(3))]] ],3,[2,3])=[ [], [], [], [] ];

# DimsQATrunc
DimsQATrunc([],1,[2,3])=[1,0];
DimsQATrunc([],2,[2,3])=[1,0,1];
DimsQATrunc([ [[[1]],[1]] ],2,[2,3])=[1,0,0];
DimsQATrunc([ [[[1]],[1]] ],3,[2,3])=[1,0,0,1];
DimsQATrunc([ [[[]],[1]] ],3,[2,3])=[0,0,0,0];
DimsQATrunc([ [[[]],[One(GF(3))]] ],3,[2,3])=[0,0,0,0];

# FreqsQATrunc
FreqsQATrunc([],1,[2,3])=[ [ [ [  ], 1 ] ] ];
FreqsQATrunc([],2,[2,3])=[ [ [ [  ], 1 ] ], [ [ [ 1, 0 ], 1 ] ] ];
FreqsQATrunc([ [[[1]],[1]] ],2,[2,3])=[ [ [ [  ], 1 ] ] ];
FreqsQATrunc([ [[[1]],[1]] ],3,[2,3])=[ [ [ [  ], 1 ] ], [ [ [ 0, 1 ], 1 ] ] ];
FreqsQATrunc([ [[[]],[1]] ],3,[2,3])=[];
FreqsQATrunc([ [[[]],[One(GF(3))]] ],3,[2,3])=[];
