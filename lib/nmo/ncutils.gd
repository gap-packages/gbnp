#############################################################################
##
#W  ncutils.gd                NMO Utils                        Randall Cone
##
##  (C) 2010 Mathematics Dept., Virginia Polytechnic Institute, USA
##
#############################################################################


#############################################################################
##
##  <#GAPDoc Label="PatchGBNP">
##  <Oper Name="PatchGBNP"
##        Arg="&lt;NoncommutativeMonomialOrdering>"/>
##
##  <Description>
##  </Description>
##
##  <Func Name="UnpatchGBNP" Arg=""/>
##
##  <Description>
##  Let <C>&lt;NoncommutativeMonomialOrdering></C> be a
##   monomial ordering (on an algebra <M>A</M>).
##  <C>PatchGBNP</C> overwrites the <Package>GBNP</Package>
##  Global functions <C>LtNP</C> and <C>GtNP</C>
##  with the less-than and greater-than functions defined for
##  <C>&lt;NoncommutativeMonomialOrdering></C>.
##  The purpose of such a patching is to force <Package>GBNP</Package> to use
##  <C>&lt;NoncommutativeMonomialOrdering></C> in its computation of a Gröbner basis.
##  <C>UnpatchGBNP()</C> simply restores the <C>LtNP</C> and <C>GtNP</C> functions
##  to their original state.
##
##  The examples in Quickstart section  are more illustrative, but
##  here is an example of the use of the patching routines above:
##  <Example>
##  gap> A := FreeAssociativeAlgebraWithOne(Rationals,"x","y","z");
##  &lt;algebra-with-one over Rationals, with 3 generators>
##  gap> ml := NCMonomialLeftLexicographicOrdering(A,3,2,1);
##  NCMonomialLeftLexicographicOrdering([ (1)*z, (1)*y, (1)*x ])
##  gap> PatchGBNP(ml);
##  LtNP patched.
##  GtNP patched.
##  gap> UnpatchGBNP();
##  LtNP restored.
##  GtNP restored.
##  </Example>
##  <P/>
##  </Description>
##
##  <#/GAPDoc>
##
DeclareOperation("PatchGBNP", [ IsNoncommutativeMonomialOrdering ] );
DeclareGlobalFunction("UnpatchGBNP");

#############################################################################
##
##  <#GAPDoc Label="String">
##  <Oper Name="String"
##        Arg="&lt;obj>"/>
##
##  <Description>
##  <Package>GAP</Package> seems to be currently lacking a method to convert an object
##  from a free associative ring to a string version of the same object.
##  This routine fills that gap.
##  <P/>
##  
##  Example (after loading <Package>NMO</Package> via the <Package>GBNP</Package> package):
##  <Example>
##  gap> A := FreeAssociativeAlgebraWithOne(ZmodpZ(19),"x","y");
##  &lt;algebra-with-one over GF(19), with 2 generators>
##  gap> x := A.x; y := A.y;
##  (Z(19)^0)*x
##  (Z(19)^0)*y
##  gap> IsString(String(x^2+x*y*x));
##  true
##  gap> String(x^2+x*y*x);
##  "(Z(19)^0)*x^2+(Z(19)^0)*x*y*x"
##  </Example>
##
##
##  Example (before loading <Package>NMO</Package> via the <Package>GBNP</Package> package):
##  <Example>
##  gap>  A := FreeAssociativeAlgebraWithOne(ZmodpZ(19),"x","y");
##  &lt;lgebra-with-one over GF(19), with 2 generators>
##  gap> x := A.x; y := A.y;
##  (Z(19)^0)*x
##  (Z(19)^0)*y
##  gap>  String(x^2+x*y*x);
##  Error, no method found! For debugging hints type ?Recovery from NoMethodFound
##  Error, no 1st choice method found for `String' on 1 arguments called from
##  &lt;function>( &lt;arguments> ) called from read-eval-loop
##  Entering break read-eval-print loop ...
##  you can 'quit;' to quit to outer loop, or
##  you can 'return;' to continue
##  brk>
##  </Example>
##
##  </Description>
##
##  <#/GAPDoc>
##

##
#E
