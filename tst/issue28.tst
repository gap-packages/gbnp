gap> START_TEST("GBNP issue 28");
gap> LoadPackage("gbnp", false);
true
gap> A:=FreeAssociativeAlgebraWithOne(Rationals, "a", "b");;
gap> a:=A.a;; b:=A.b;; e:=One(A);;

# converting elements of A^1 records one module generator ...
gap> v:=GeneratorsOfLeftModule(A^1);;
gap> PrintNPList(GP2NPList([v[1]*a-v[1]]));
[ a - 1 ]

# ... which must not stick when converting elements of A^2
gap> y:=GeneratorsOfLeftModule(A^2);;
gap> PrintNPList(GP2NPList([y[1]*b-y[1], y[2]*b-y[2]]));
[ b - 1 , 0]
[ 0, b - 1 ]
gap> STOP_TEST("issue28.tst");
