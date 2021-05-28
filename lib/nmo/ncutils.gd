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
