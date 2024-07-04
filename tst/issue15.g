LoadPackage("gbnp");
SetInfoLevel( InfoGBNP, 2 );
A:=FreeAssociativeAlgebraWithOne(Rationals,"a","b");
a:=A.1;
b:=A.2;
rels := [ a^3, a^2*b, a*b^2+a^2, b*a^2, a^3+b^2+b*a, a*b^2+a*b*a,
          b*a*b+b*a^2, b^2*a+b*a^2, b^3+b*a^2, a^2*b*a, a*b*a^2, b*a^2*b ];
relsnp := List( rels, x-> GP2NP(x) );
grobnp := Grobner(relsnp);
grob := List( grobnp, p -> NP2GP(p,A) );
