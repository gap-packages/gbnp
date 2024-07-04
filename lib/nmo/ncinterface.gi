#############################################################################
##
#W  ncinterface.gi
#W  NMO: High level interface into routines                   Randall Cone
##
##
##  (C) 2010 Mathematics Dept., Virginia Polytechnic Institute, USA
##
#############################################################################

InstallMethod(
  NCLessThanByOrdering,
  "returns boolean based on if a < b in given ordering",
  true,
    [ IsNoncommutativeMonomialOrdering,
      IsElementOfFreeAssociativeRing,
      IsElementOfFreeAssociativeRing  ],
  0,
  function(ord,a,b)
    local arep, brep, alt, blt, ordfunc;

    # Get given order's (lessthan) ordering function:
    ordfunc := OrderingLtFunctionListRep(ord);

    # Get GBNP's NP representation of each element:
    arep := GP2NP(a);
    brep := GP2NP(b);

    # Sort elements (internally), based on given ordering:
    alt := NCSortNP(arep,ordfunc);
    blt := NCSortNP(brep,ordfunc);

    # Need to check for zeroes, and act appropriately:
    if IsEmpty(alt[1]) then

      # a and b both zero:
      if IsEmpty(blt[1]) then
        return(false);
      # a < b (a=0, b>0):
      else
        return(true);
      fi;

    else

      # a>0, b=0:
      if IsEmpty(blt[1]) then
        return(false);
      # a>0, b>0, so compare leading terms:
      else
        return ordfunc(alt[1][1],blt[1][1]);
      fi;

    fi;

  end
);


InstallMethod(
  NCGreaterThanByOrdering,
  "returns boolean based on if a > b in given ordering",
  true,
    [ IsNoncommutativeMonomialOrdering,
      IsElementOfFreeAssociativeRing,
      IsElementOfFreeAssociativeRing  ],
  0,
  function(ord,a,b)
    return(NCLessThanByOrdering(ord,b,a));
  end
);


InstallMethod(
  NCEquivalentByOrdering,
  "returns boolean based on if a == b in given ordering",
  true,
    [ IsNoncommutativeMonomialOrdering,
      IsElementOfFreeAssociativeRing,
      IsElementOfFreeAssociativeRing  ],
  0,
  function(ord,a,b)
    return((not NCLessThanByOrdering(ord,a,b)) and (not NCLessThanByOrdering(ord,b,a)));
  end
);


# Insertion Sort.
InstallMethod(
  NCSortNP,
  "sorts element of nc free algebra wrt given monomial ordering",
  true,
  [ IsList, IsFunction ],
  0,
  function(rep,ordfunc)
    local i,j,len,coeff,term,fun,retrep;

#    retrep := ShallowCopy(rep);

    # Determine number of monomials:
    len := Length(rep[1]);

    # Main loop variable:
    i := len;

    while i >= 1 do

      term := rep[1][i];
      coeff := rep[2][i];

      j := i + 1;

      while ((j <= len) and ordfunc(term,rep[1][j])) do

        rep[1][j-1] := rep[1][j];
        rep[2][j-1] := rep[2][j];
        j := j + 1;

      od;

      rep[1][j-1] := term;
      rep[2][j-1] := coeff;

      i := i - 1;

    od;

    return rep;

  end
);
