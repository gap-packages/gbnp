#############################################################################
##
#W  ncinterface.gd
#W  NMO: Interface routines                                  Randall Cone
##
##  User interface to lower-level functions
##
##  (C) 2010 Mathematics Dept., Virginia Polytechnic Institute, USA
##
#############################################################################


#############################################################################
##
##  <#GAPDoc Label="NCLessThanByOrdering">
##  <ManSection>
##  <Oper Name="NCLessThanByOrdering"
##        Arg="&lt;NoncommutativeMonomialOrdering>, &lt;a>, &lt;b>"/>
##
##  <Description>
##  Given a <C>&lt;NoncommutativeMonomialOrdering></C> on an algebra <M>A</M>
##  and <M>a,b \in A</M>,
##  <C>NCLessThanByOrdering</C> returns the (boolean) result of
##  <M>a &lt; b</M>, where <M>&lt;</M> represents the comparison operator
##  determined by <C>&lt;NoncommutativeMonomialOrdering></C>.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation("NCLessThanByOrdering",
  [ IsNoncommutativeMonomialOrdering,
    IsElementOfFreeAssociativeRing,
    IsElementOfFreeAssociativeRing   ]
);


#############################################################################
##
##  <#GAPDoc Label="NCGreaterThanByOrdering">
##  <ManSection>
##  <Oper Name="NCGreaterThanByOrdering"
##        Arg="&lt;NoncommutativeMonomialOrdering>, &lt;a>, &lt;b>"/>
##
##  <Description>
##  Given a <C>&lt;NoncommutativeMonomialOrdering></C> on an algebra <M>A</M>
##  and <M>a,b \in A</M>,
##  <C>NCLessThanByOrdering</C> returns the (boolean) result of
##  <M>a > b</M>, where <M>></M> represents the comparison operator
##  determined by <C>&lt;NoncommutativeMonomialOrdering></C>.
##  <P/>
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation("NCGreaterThanByOrdering",
  [ IsNoncommutativeMonomialOrdering,
    IsElementOfFreeAssociativeRing,
    IsElementOfFreeAssociativeRing   ]
);

#############################################################################
##
##  <#GAPDoc Label="NCEquivalentByOrdering">
##  <ManSection>
##  <Oper Name="NCEquivalentByOrdering"
##        Arg="&lt;NoncommutativeMonomialOrdering>, &lt;a>, &lt;b>"/>
##
##  <Description>
##  Given a <C>&lt;NoncommutativeMonomialOrdering></C> on an algebra <M>A</M>
##  and <M>a,b \in A</M>,
##  <C>NCLessThanByOrdering</C> returns the (boolean) result of
##  <M>a = b</M>, where <M>=</M> represents the comparison operator
##  determined by <C>&lt;NoncommutativeMonomialOrdering></C>.
##  <P/>
##
##  Some examples of these methods in use:
##  <Example>
##  gap> A := FreeAssociativeAlgebraWithOne(Rationals,"x","y","z");
##  &lt;algebra-with-one over Rationals, with 3 generators>
##  gap> x := A.x;; y := A.y;; z := A.z;; id := One(A);;
##  gap> w1 := x*x*y;; w2 := x*y*x;; w3 := z*x;;
##
##  gap> ml := NCMonomialLeftLengthLexOrdering(A);
##  NCMonomialLeftLengthLexicographicOrdering([ (1)*x, (1)*y, (1)*z ])
##
##  gap> ml2 := NCMonomialLengthOrdering(A);
##  NCMonomialLengthOrdering([ (1)*x, (1)*y, (1)*z ])
##
##  gap> ml7 := NCMonomialWeightOrdering(A,[1,2,3],[1,1,2]);
##  NCMonomialWeightOrdering([ (1)*x, (1)*y, (1)*z ])
##
##  gap> ml8 := NCMonomialWeightOrdering(A,[2,3,1],[1,1,2]);
##  NCMonomialWeightOrdering([ (1)*y, (1)*z, (1)*x ])
##
##  gap> #  Left length-lex ordering, x&lt;y&lt;z:
##  gap> NCEquivalentByOrdering(ml,w1,w2);
##  false
##  gap> #  Length ordering:
##  gap> NCEquivalentByOrdering(ml2,w1,w2);
##  true
##  gap> NCEquivalentByOrdering(ml2,w3,w2);
##  false
##  gap> # Weight ordering ( z=2, x=y=1 ):
##  gap> NCEquivalentByOrdering(ml7,w1,w2);
##  true
##  gap> NCEquivalentByOrdering(ml7,w3,w2);
##  true
##  gap> # Weight ordering ( z=2, x=y=1 ), different lex:
##  gap> NCEquivalentByOrdering(ml8,w1,w2);
##  true
##  gap> NCEquivalentByOrdering(ml8,w3,w2);
##  true
##  </Example>
##  <P/>
##
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation("NCEquivalentByOrdering",
  [ IsNoncommutativeMonomialOrdering,
    IsElementOfFreeAssociativeRing,
    IsElementOfFreeAssociativeRing   ]
);


#############################################################################
##
##  <#GAPDoc Label="NCSortNP">
##  <ManSection>
##  <Oper Name="NCSortNP"
##        Arg="&lt;NoncommutativeMonomialOrdering>, &lt;list>, &lt;function>"/>
##
##  <Description>
##  Given a <C>&lt;list></C> of NP `list' representations for monomials from
##  a noncommutative algebra, and an NP comparison (ordering) function
##  <C>&lt;function></C>,
##  <C>NCSortNP</C> returns a sorted version of <C>&lt;list></C>
##  (with respect to the NP comparison function <C>&lt;function></C>).
##  The sort used here is an insertion sort, per the recommendation
##  from <Cite Key="gN02"/>.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation("NCSortNP",
  [ IsList, IsFunction ]
);

##
#E
