gap> START_TEST("GBNP issue 15");
gap> 
gap> LoadPackage("gbnp");;
gap> 
gap> A:=FreeAssociativeAlgebraWithOne(Rationals,"a","b");;
gap> a:=A.1;;
gap> b:=A.2;;
gap> rels := [ a^3, a^2*b, a*b^2+a^2, b*a^2, a^3+b^2+b*a,
>              a*b^2+a*b*a, b*a*b+b*a^2, b^2*a+b*a^2, b^3+b*a^2,
>              a^2*b*a, a*b*a^2, b*a^2*b ];;
gap> Display(rels);
[ (1)*a^3, (1)*a^2*b, (1)*a^2+(1)*a*b^2, (1)*b*a^2, (1)*b*a+(1)*b^2+(1)*a^3,
  (1)*a*b*a+(1)*a*b^2, (1)*b*a^2+(1)*b*a*b, (1)*b*a^2+(1)*b^2*a,
  (1)*b*a^2+(1)*b^3, (1)*a^2*b*a, (1)*a*b*a^2, (1)*b*a^2*b ]
gap> relsnp := List( rels, x-> GP2NP(x) );;
gap> grobnp := Grobner(relsnp);;
gap> grob := List( grobnp, p -> NP2GP(p,A) );;
gap> Display(grob);
[ (1)*b^2+(1)*b*a, (1)*a^3, (1)*a^2*b, (1)*a*b*a+(-1)*a^2, (1)*b*a^2,
  (1)*b*a*b+(1)*b*a^2 ]
gap> 
gap> STOP_TEST("GBNP issue 15",10000);

