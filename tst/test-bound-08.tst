gap> START_TEST("GBNP test-bound-08");
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
gap> # SGrobnerTrunc
gap> F:=Rationals;;
gap> NPzero:=[[],[]];;
gap> NPone:=[[[]],[One(F)]];;
gap> 
gap> SGrobnerTrunc([NPzero],5,[1,1])=[];
true
gap> SGrobnerTrunc([],5,[1,1])=[];
true
gap> SGrobnerTrunc([NPone],5,[1])=[NPone];
true
gap> 
gap> F:=GF(2);;
gap> NPzero:=[[],[]];;
gap> NPone:=[[[]],[One(F)]];;
gap> 
gap> # CheckHomogeneousNPs
gap> CheckHomogeneousNPs([],[1,1])=[];
true
gap> 
gap> F:=Rationals;;
gap> NPzero:=[[],[]];;
gap> NPone:=[[[]],[One(F)]];;
gap> 
gap> CheckHomogeneousNPs([NPone],[1,1])=[0];
true
gap> 
gap> # XXX NPzero is Homogeneous but the degree can not be determined -> so false is
gap> # returned fail might be better here though
gap> CheckHomogeneousNPs([NPzero],[1,1])=false;
true
gap> 
gap> F:=GF(2);;
gap> NPzero:=[[],[]];;
gap> NPone:=[[[]],[One(F)]];;
gap> 
gap> CheckHomogeneousNPs([NPone],[1,1])=[0];
true
gap> 
gap> # XXX NPzero is Homogeneous but the degree can not be determined -> so false is
gap> # returned fail might be better here though
gap> CheckHomogeneousNPs([NPzero],[1,1])=false;
true
gap> 
gap> # BaseQATrunc
gap> BaseQATrunc([],1,[2,3])=[ [ [] ], [] ];
true
gap> BaseQATrunc([],2,[2,3])=[ [ [] ], [], [ [1] ]];
true
gap> # why GB instead of lterms (to check homogeneous-ness ?)
gap> BaseQATrunc([ [[[1]],[1]] ],2,[2,3])=[ [ [] ], [], [] ];
true
gap> BaseQATrunc([ [[[1]],[1]] ],3,[2,3])=[ [ [] ], [], [], [ [2] ] ];
true
gap> BaseQATrunc([ [[[]],[1]] ],3,[2,3])=[ [], [], [], [] ];
true
gap> BaseQATrunc([ [[[]],[One(GF(3))]] ],3,[2,3])=[ [], [], [], [] ];
true
gap> 
gap> # DimsQATrunc
gap> DimsQATrunc([],1,[2,3])=[1,0];
true
gap> DimsQATrunc([],2,[2,3])=[1,0,1];
true
gap> DimsQATrunc([ [[[1]],[1]] ],2,[2,3])=[1,0,0];
true
gap> DimsQATrunc([ [[[1]],[1]] ],3,[2,3])=[1,0,0,1];
true
gap> DimsQATrunc([ [[[]],[1]] ],3,[2,3])=[0,0,0,0];
true
gap> DimsQATrunc([ [[[]],[One(GF(3))]] ],3,[2,3])=[0,0,0,0];
true
gap> 
gap> # FreqsQATrunc
gap> FreqsQATrunc([],1,[2,3])=[ [ [ [  ], 1 ] ] ];
true
gap> FreqsQATrunc([],2,[2,3])=[ [ [ [  ], 1 ] ], [ [ [ 1, 0 ], 1 ] ] ];
true
gap> FreqsQATrunc([ [[[1]],[1]] ],2,[2,3])=[ [ [ [  ], 1 ] ] ];
true
gap> FreqsQATrunc([ [[[1]],[1]] ],3,[2,3])=[ [ [ [  ], 1 ] ], [ [ [ 0, 1 ], 1 ] ] ];
true
gap> FreqsQATrunc([ [[[]],[1]] ],3,[2,3])=[];
true
gap> FreqsQATrunc([ [[[]],[One(GF(3))]] ],3,[2,3])=[];
true
gap> 
gap> STOP_TEST("test-bound-08.g",10000);
