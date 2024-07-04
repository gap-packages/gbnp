#############################################################################
##
#W  ncalgebra.gd
#W  NMO: Some nice noncommutative algebra categories/filters    Randall Cone
##
##
##  (C) 2010 Mathematics Dept., Virginia Polytechnic Institute, USA
##
#############################################################################

#############################################################################
##
#P  IsFreeAlgebra( <A> )
##
##  A *Free Algebra* in {\GAP} is an algebra (see~"IsAlgebra")
##  that is also a free magma ring (see~"IsFreeMagmaRing"),
##
##  The multiplication need *not* be associative (see~"IsAssociative").
##
DeclareSynonymAttr( "IsFreeAlgebra", IsAlgebra and IsFreeMagmaRing );

#############################################################################
##
#P  IsFreeAssociativeAlgebra( <A> )
##
##  A *Free Associative Algebra* in {\GAP} is a free algebra
##  (see~"IsFreeAlgebra") that is also associative (see~"IsAssociative"),
##
DeclareSynonymAttr( "IsFreeAssociativeAlgebra", IsFreeAlgebra
                        and IsAssociative );

#############################################################################
##
#C  IsElementOfFreeAssociativeRing( <obj> )
##
##  `IsElementOfFreeAssociativeRing' is the category of elements in free
##   associative rings.
##
DeclareSynonym( "IsElementOfFreeAssociativeRing", IsElementOfFreeMagmaRing
                    and IsAssociativeElement );

##
#E
