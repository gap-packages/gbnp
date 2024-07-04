#############################################################################
##
#W  ncorderings.gi
##  NMO: Low-level (Less-than) functions for orderings        Randall Cone
##
##
##  (C) 2010 Mathematics Dept., Virginia Polytechnic Institute, USA
##
#############################################################################


#
# Length-lex order, based on the 'list' representations
# of free associative algebra monomials.  There need to
# be two functions here, one for an index of generators,
# and one with the default order.
# Both functions expect 'list' representations
# of a and b;
#
# Note: we return true if a < b;
#
InstallNoncommutativeMonomialOrdering( NCMonomialLeftLengthLexicographicOrdering,
  # Default ordering function, non-indexed
  function(a, b, aux)
    if ( Length(a) < Length(b) ) then
      return(true);
    elif ( Length(a) = Length(b) ) then
      return( a < b );
    else
      return(false);
    fi;
  end,

  # Indexed ordering function
  function(a, b, aux, idx)
    local i,m,n;

    m :=  Length(a);
    n :=  Length(b);

    if m < n then
      return(true);
    elif ( m = n ) then
      for i in [ 1 .. m ] do
        if ( idx[a[i]] > idx[b[i]] ) then
          return(false);
        elif ( idx[a[i]] < idx[b[i]] ) then
          return(true);
        fi;
        # Assert: a[i] = b[i]
      od;
    fi;

   return(false);
  end
);


InstallNoncommutativeMonomialOrdering( NCMonomialLLLTestOrdering,
  # Default ordering function, non-indexed
  function(a, b, aux)
    if ( Length(a) < Length(b) ) then
      return(true);
    elif ( Length(a) = Length(b) ) then
      return( a < b );
    else
      return(false);
    fi;
  end,

  # Indexed ordering function
  function(a, b, aux, idx)
    local i,m,n,p;

    m :=  Length(a);
    n :=  Length(b);

    if m < n then
      return(true);
    elif ( m = n ) then
      p := MappingPermListList([1..Length(idx)],idx);
      return(List(a, x -> x^p) < List(b, x->x^p));
    else
      return(false);
    fi;

  end
);


InstallNoncommutativeMonomialOrdering( NCMonomialLengthOrdering,
  # Default ordering function, non-indexed
  function(a, b, aux)
    if ( Length(a) < Length(b) ) then
      return(true);
    else
      return(false);
    fi;
  end,

  # Indexed ordering function (no difference from non-indexed
  #  in the length ordering case):
  function(a, b, aux, idx)
    if ( Length(a) < Length(b) ) then
      return(true);
    else
      return(false);
    fi;
  end
);


InstallNoncommutativeMonomialOrdering( NCMonomialLeftLexicographicOrdering,
  # Default ordering function, non-indexed
  function(a, b, aux)
      return( a < b );
  end,

  # Indexed ordering function
  function(a, b, aux, idx)
    local i,m,n;
    m :=  Length(a);
    n :=  Length(b);

    for i in [ 1 .. Minimum(m,n) ] do
      if ( idx[a[i]] > idx[b[i]] ) then
        return(false);
      elif ( idx[a[i]] < idx[b[i]] ) then
        return(true);
      fi;
    od;

   # if we get to here, we need to make sure b is not
   #  a proper prefix of a:
   if (m < n) then
     return(true);
   fi;

   return(false);
  end
);


InstallNoncommutativeMonomialOrdering( NCMonomialCommutativeLexicographicOrdering,
  # Default ordering function, non-indexed
  function(a, b, aux)
    local arep, brep, alen, blen, i;

    # Initialize commutative representations of a and b:
    arep := [];
    brep := [];

    # Create commutative rep for a:
    i := 1;
    alen := Length(a);
    while (Sum(arep)<>alen) do
      arep[i] := Length(Positions(a,i));
      i := i + 1;
    od;

    # Create commutative rep for b:
    i := 1;
    blen := Length(b);
    while (Sum(brep)<>blen) do
      brep[i] := Length(Positions(b,i));
      i := i + 1;
    od;

#Print(arep," ?<? ",brep,"\n");
    return(Reversed(arep) < Reversed(brep));
  end,

  # Indexed ordering function
  function(a, b, aux, idx)
    local arep, brep, arep2, brep2, alen, blen, i, idxlen;

    # Initialize commutative representations of a and b:
    idxlen := Length(idx);
    arep := ListWithIdenticalEntries(idxlen,0);
    brep := ListWithIdenticalEntries(idxlen,0);
    arep2 := [];
    brep2 := [];

    # Create commutative reps for a and b:
    i := 1;
    while (i <= idxlen) do
      arep[i] := Length(Positions(a,i));
      brep[i] := Length(Positions(b,i));
      i := i + 1;
    od;

    # Re-order indices (based on idx and then highest to
    #  lowest):
    # Create commutative reps for a and b:
    i := 0;
    while (i < idxlen) do
      arep2[i+1] := arep[idx[idxlen-i]];
      brep2[i+1] := brep[idx[idxlen-i]];
      i := i + 1;
    od;

#Print(arep2," ?<? ",brep2,"\n");
    return(arep2 < brep2);
  end
);


InstallNoncommutativeMonomialOrdering( NCMonomialWeightOrdering,
  # Default ordering function, non-indexed:
  function(a, b, aux)
    local awt, bwt;

    awt := Sum(a,x->aux[x]);
    bwt := Sum(b,x->aux[x]);

    return awt < bwt;
  end,

  # Indexed ordering function (no difference from non-indexed
  #  in the weight ordering case):
  function(a, b, aux, idx)
    local awt, bwt;

    awt := Sum(a,x->aux[x]);
    bwt := Sum(b,x->aux[x]);

    return awt < bwt;
  end
);


##
#E
