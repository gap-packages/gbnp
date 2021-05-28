# Verify that String works for elements of free associative algebras
gap> A := FreeAssociativeAlgebraWithOne(ZmodpZ(19),"x","y");
<algebra-with-one over GF(19), with 2 generators>
gap> x := A.x; y := A.y;
(Z(19)^0)*x
(Z(19)^0)*y
gap> String(x^2+x*y*x);
"(Z(19)^0)*x^2+(Z(19)^0)*x*y*x"
