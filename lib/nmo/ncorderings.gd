#############################################################################
##
#W  ncorderings.gd
#W  NMO: Low-level (Less-than) functions for orderings         Randall Cone
##
##
##  (C) 2010 Mathematics Dept., Virginia Polytechnic Institute, USA
##
#############################################################################

#############################################################################
##
##  <#GAPDoc Label="NCMonomialLeftLengthLexicographicOrdering">
##  <ManSection>
##  <Func Name="NCMonomialLeftLengthLexicographicOrdering"
##        Arg="&lt;algebra>, &lt;list>"/>
##
##  <Description>
##  Given a free algebra <M>A</M>, and an optional ordered (possibly partial)
##  ordered list of generators for the algebra <M>A</M>,
##  <C>NCMonomialLeftLengthLexicographicOrdering</C> returns a noncommutative length
##  lexicographic ordering object.  If an ordered list of generators
##  is provided, its order is used in creation of the ordering object.
##  If a list is not provided, then the ordering object is created
##  based on the order of the generators when the free algebra <M>A</M>
##  was created.
##  <P/>
##  Note: the synonym <C>NCMonomialLeftLengthLexOrdering</C> may also be used.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction("NCMonomialLeftLengthLexicographicOrdering");
DeclareSynonym("NCMonomialLeftLengthLexOrdering",
                NCMonomialLeftLengthLexicographicOrdering);


#############################################################################
##
##  <#GAPDoc Label="NCMonomialLengthOrdering">
##  <ManSection>
##  <Func Name="NCMonomialLengthOrdering"
##        Arg="&lt;algebra>"/>
##
##  <Description>
##  Given a free algebra <M>A</M>,
##  <C>NCMonomialLengthOrdering</C> returns a noncommutative length
##  ordering object.  Only the lengths of the words of monomials in <M>A</M>
##  are compared using this ordering.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction("NCMonomialLengthOrdering");


#############################################################################
##
##  <#GAPDoc Label="NCMonomialLeftLexicographicOrdering">
##  <ManSection>
##  <Func Name="NCMonomialLeftLexicographicOrdering"
##        Arg="&lt;algebra>, &lt;list>"/>
##
##  <Description>
##  Given a free algebra <M>A</M>, and an optional ordered (possibly partial)
##  ordered list of generators for the algebra <M>A</M>,
##  <C>NCMonomialLeftLexicographicOrdering</C> returns a simple noncommutative
##  left-lexicographic ordering object.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction("NCMonomialLeftLexicographicOrdering");


#############################################################################
##
##  <#GAPDoc Label="NCMonomialCommutativeLexicographicOrdering">
##  <ManSection>
##  <Func Name="NCMonomialCommutativeLexicographicOrdering"
##        Arg="&lt;algebra>, &lt;list>"/>
##
##  <Description>
##  Given a free algebra <M>A</M>, and an optional ordered (possibly partial)
##  ordered list of generators for the algebra <M>A</M>,
##  <C>NCMonomialCommutativeLexicographicOrdering</C> returns a commutative
##  left-lexicographic ordering object.
##  Under this ordering, monomials from <M>A</M> are compared
##  using their respective commutative analogues.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction("NCMonomialCommutativeLexicographicOrdering");


#############################################################################
##
##  <#GAPDoc Label="NCMonomialWeightOrdering">
##  <ManSection>
##  <Func Name="NCMonomialWeightOrdering"
##        Arg="&lt;algebra>, &lt;list>, &lt;list2>"/>
##
##  <Description>
##  Given a free algebra <M>A</M>, an ordered (possibly partial)
##  ordered <C>&lt;list></C> of generators for the algebra <M>A</M>,
##  and a <C>&lt;list2></C> of respective weights for the generators,
##  <C>NCMonomialWeightOrdering</C> returns a noncommutative
##  weight ordering object.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction("NCMonomialWeightOrdering");

DeclareGlobalFunction("NCMonomialLLLTestOrdering");

##
#E
