FG := 
FreeGroup("U1","U2","U3","U4","U5","U6","U7","U8","V1","V2","V3","V4","V5","V6","V7","V8","r1","r8");

U1 := FG.1;
U2 := FG.2;
U3 := FG.3;
U4 := FG.4;
U5 := FG.5;
U6 := FG.6;
U7 := FG.7;
U8 := FG.8;
V1 := FG.9;
V2 := FG.10;
V3 := FG.11;
V4 := FG.12;
V5 := FG.13;
V6 := FG.14;
V7 := FG.15;
V8 := FG.16;
r1 := FG.17;
r8 := FG.18;

GeneratorsOfGroup(FG);

rels := [
U1^4, U2^2 ,U3^4 ,U4^2, U5^4 ,U6^2 ,U7^4 ,U8^2 ,
V1^4, V2^2 ,V3^4 ,V4^2, V5^4 ,V6^2 ,V7^4 ,V8^2 ,
	U1^(-1)*U2^(-1)*U1*U2, 
        U1^(-1)*U5^(-1)*U1*U5,
        U2^(-1)*U4^(-1)*U2*U4,
        U2^(-1)*U6^(-1)*U2*U6,
	U2^(-1)*U1^(-1)*U3*U1*U3^(-1),
	U3^(-2)*U1^(-1)*U4*U1*U4^(-1),
        U6^(-1)*U4^(-1)*U2^(-1)*U8*U2*U8^(-1),
	(U3^2*U4*U5^2)^(-1)*U1^(-1)*U6*U1*U6^(-1),
	(U2*U3^3*U5)^(-1)*U1^(-1)*U7*U1*U7^(-1),
	(U2*U3^2*U4*U5^3*U6*U7)^(-1)*U1^(-1)*U8*U1*U8^(-1),
	r1^(-1)*U1*V1^2*U1^(-1),
	r8^(-1)*U8*V8*U8^(-1),
	r1^2,r8^2, 
	(r1*r8)^8,
	(r1*U1*r1)^(-1)*V1,
	(r1*U2*r1)^(-1)*U8,
	(r1*U3*r1)^(-1)*U7,
	(r1*U4*r1)^(-1)*U6,
	(r1*U5*r1)^(-1)*U5,
	(r1*V2*r1)^(-1)*V8,
	(r1*V3*r1)^(-1)*V7,
	(r1*V4*r1)^(-1)*V6,
	(r1*V5*r1)^(-1)*V5,
	(r8*U1*r8)^(-1)*U7,
	(r8*U2*r8)^(-1)*U6,
	(r8*U3*r8)^(-1)*U5,
	(r8*U4*r8)^(-1)*U4,
	(r8*U8*r8)^(-1)*V8,
	(r8*V1*r8)^(-1)*V7,
	(r8*V2*r8)^(-1)*V6,
	(r8*V3*r8)^(-1)*V5,
	(r8*V4*r8)^(-1)*V4
 ];

 T := FG/rels;

#check with Tits Weiss??
U:=Subgroup(T,[T.1,T.2,T.3,T.4,T.5,T.6,T.7,T.8,T.17]);;
# RT:=RightTransversal(T,U);
CT := CosetTable(T,U);
p := Index(T,U);
Print("Get permutation action on ",p," elements\n");
FA := FactorCosetAction( T, U );
Tperms := List(GeneratorsOfGroup(T),xxx -> xxx^FA);
Tpermgrp := Group(Tperms);
#Image(ActionHomomorphism(T,RT,OnRight));
Print("order of the group is 35942400? ", Order(Tpermgrp)=35942400,".\n");

u1 := Tpermgrp.1;
u2 := Tpermgrp.2;
u3 := Tpermgrp.3;
u4 := Tpermgrp.4;
u5 := Tpermgrp.5;
u6 := Tpermgrp.6;
u7 := Tpermgrp.7;
u8 := Tpermgrp.8;
v1 := Tpermgrp.9;
v2 := Tpermgrp.10;
v3 := Tpermgrp.11;
v4 := Tpermgrp.12;
v5 := Tpermgrp.13;
v6 := Tpermgrp.14;
v7 := Tpermgrp.15;
v8 := Tpermgrp.16;
r1 := Tpermgrp.17;
r8 := Tpermgrp.18;

Q := Subgroup(Tpermgrp,[u2,u3,u4,u5,u6,u7,u8]);

c := u1*v1^(-1);
f := v1;

a0 := u5;
a1 := u8;
a2 := u2* u3^3* u4* u5* u6* u7^2* u8;
a3 := u2* u3^2* u4* u5^3* u6* u7* u8;
a4 := u2;
a5 := u2* u3* u4* u5^2* u6* u7^3* u8;

Q1 := Subgroup(Q,[a1]);
Q2 := Subgroup(Q,[a1,u8]);
Q3 := Subgroup(Q,[a1,u8,u7]);
Q4 := Subgroup(Q,[a1,u8,u7,u6]);
Q5 := Subgroup(Q,[a1,u8,u7,u6,u5]);
Q6 := Subgroup(Q,[a1,u8,u7,u6,u5,u4]);
Q7 := Subgroup(Q,[a1,u8,u7,u6,u5,u4,u3]);

findWord := function(aa) local i2, i3, i4, i5, i6, i7, i8, nfnd, ans;
  for i2 in [0..1] do
      for i3 in [0..3] do
        for i4 in [0..1] do
            for i5 in [0..3] do
                for i6 in [0..1] do
                    for i7 in [0..3] do
                        for i8 in [0..1] do
            if aa = u2^i2 *u3^i3 *u4^i4 *u5^i5 *u6^i6 *u7^i7 *u8^i8 then
                   return [i2,i3,i4,i5,i6,i7,i8];
            fi;
                        od;
                    od;
                od;
            od;
        od;
     od;
  od;
end;


Qorbs := Orbits(Q);

nfnd := true; i := 0;
while nfnd and i< Length(Qorbs) do
  i := i+1; 
  if Size(Qorbs[i]) = 1024 then nfnd := false; fi;
od;
S := Qorbs[i];

fixpts := function(sbgpT) local ans, hlp, j;
  ans := [];
  for j in [1..p] do 
    if Orbit(sbgpT,j) = Set([j]) then Add(ans,j); fi;
  od;
  return(Set(ans));
end;

