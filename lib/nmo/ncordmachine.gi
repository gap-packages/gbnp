#############################################################################
##
#W  ncordmachine.gi
##  NMO: Machinery for installing NM orderings                Randall Cone
##
##
##  (C) 2010 Mathematics Dept., Virginia Polytechnic Institute, USA
##
#############################################################################


# Create the family object for ordering:
BindGlobal("MakeNoncommutativeMonomialOrdering",
  function(name, ordfun, palgebra, lextable, idxtable, auxtable, idxperm, nextordering)
    local obj;
    obj := rec();
    ObjectifyWithAttributes( obj,
              NewType(NoncommutativeMonomialOrderingsFamily,
                      IsNoncommutativeMonomialOrderingDefaultRep),
              Name, name,
              LtFunctionListRep, ordfun,
              ParentAlgebra, palgebra,
              LexicographicTable, lextable,
              LexicographicIndexTable, idxtable,
              AuxilliaryTable, auxtable,
              LexicographicPermutation, idxperm
            );
    if (IsNoncommutativeMonomialOrdering(nextordering)) then
      SetNextOrdering(obj, nextordering);
    fi;
    return obj;
  end
);


# Install Ordering, based on what kind of information
# we receive.
#
InstallGlobalFunction("InstallNoncommutativeMonomialOrdering",
  function(ord, ordfun, idxordfun)
    InstallGlobalFunction(ord,
      function(arg)
        local gens,lextable,auxtable,len,parentalgebra,ordname,x,idxtable,idxperm,nextordering;

        # Get name of our monomial ordering function:
        ordname := NameFunction(ord);

        # Check that we're passed the correct parameter types:
        if ( Length(arg) <= 0 or
             ( Length(arg) >= 1 and
               not IsAlgebra(arg[1]))   ) then
          Error("usage: ", ordname, "(<algebra>)\n",
                "\t or ", ordname,
                "(<algebra>, <generator list>)\n",
                "\t or ", ordname,
                "(<algebra>, <generator index list>)\n",
                "\t or ", ordname,
                "(<algebra>, <generator list>,<weight list>)\n");
        else
          # First argument should be parent algebra:
          parentalgebra := arg[1];

          # Set nextordering to something we can check later,
          #  initialize auxilliary table:
          nextordering := [];
          auxtable := [];

          # If we have a multiplicative identity (one) in this
          #  algebra, we need get correct generating set:
          if (HasOne(parentalgebra)) then
            gens := GeneratorsOfAlgebraWithOne(parentalgebra);
          else
            gens := GeneratorsOfAlgebra(parentalgebra);
          fi;

          len := Length(gens);


          # Case 1: Just algebra given:
          if ( Length(arg) = 1 ) then
            lextable := gens;

          # Case 2: Algebra and Lex List given:
          elif ( Length(arg) = 2 ) and ( IsList(arg[2]) ) then
            lextable := Unique(arg[2]);

          # Case 3: Algebra and ordering given:
          elif ( Length(arg) = 2 ) and
               ( IsNoncommutativeMonomialOrdering(arg[2]) ) then
            nextordering := arg[2];
            lextable := gens;
            auxtable :=  ListWithIdenticalEntries(Length(gens),1);

          # Case 4: Algebra, Lex List, and Auxilliary Vector
          #         (e.g. weight vector) given:
          elif ( Length(arg) = 3 ) and
               ( IsList(arg[2]) and IsList(arg[3]) ) then

            lextable := Unique(arg[2]);
            auxtable := arg[3];

          # Case 5: Algebra, Lex List, and ordering:
          elif ( Length(arg) = 3 ) and
               ( IsList(arg[2]) and
               IsNoncommutativeMonomialOrdering(arg[3]) ) then

            lextable := Unique(arg[2]);
            nextordering := arg[3];

          # Case 6: Algebra, Lex List, and Auxilliary Vector
          #         (e.g. weight vector), and ordering given:
          elif ( Length(arg) = 4 ) and
               ( IsList(arg[2]) and IsList(arg[3]) ) and
               ( IsNoncommutativeMonomialOrdering(arg[4]) ) then

            lextable := Unique(arg[2]);
            auxtable := arg[3];
            nextordering := arg[4];

            # Check here to make sure correct size of aux vector?

          # Case 7: Algebra and parameters given:
          else
            lextable := Unique(arg{[2..Length(arg)]});
          fi;

          # Make sure list is homogeneous, and contains either:
          #   Valid indices for generators of the parent algebra, or
          #   Generators of the parent algebra.
          if ( IsHomogeneousList(lextable) and
                 ( ForAll(lextable,x->x in [1..len])
                    or ForAll(lextable,x->x in gens)  )
                                                         ) then
            lextable := OrderGenerators(parentalgebra, lextable);
            idxtable  := IndexGenerators(lextable);
            idxperm := MappingPermListList([1 .. Length(idxtable)],idxtable);

            ordname := Concatenation(ordname,"(",String(lextable),")");

            # Check if we need the indexed, or non-indexed function:
            #  (Non-indexed is faster!):
            if ( not IsSSortedList(idxtable) ) then
              return MakeNoncommutativeMonomialOrdering(
                          ordname, idxordfun, parentalgebra,
                          lextable, idxtable, auxtable, idxperm,
                          nextordering );
            else
              return MakeNoncommutativeMonomialOrdering(
                          ordname, ordfun, parentalgebra,
                          lextable, idxtable, auxtable, idxperm,
                          nextordering );
            fi;

          else
            Error("usage: ", ordname, "(<algebra>)\n",
                  "\t or ", ordname,
                  "(<algebra>, <generator list>)\n",
                  "\t or ", ordname,
                  "(<algebra>, <generator index list>)\n",
                  "\t or ", ordname,
                  "(<algebra>, <generator list>,<weight list>)\n");
          fi;

        fi;

        return fail;
      end
    );
  end
);


# Complete an ordering of generators based on provided indices
#  or generators, given a partial (or full) list of indices or
#  generators for a free associative algebra.
InstallMethod(OrderGenerators,
  "forms/completes generator ordering for algebra",
  true,
  [ IsAlgebra, IsList ],
  0,
  function(A, table)
    local gens, len, el, idx, i, oldtable;

    # If we have a one, we need to always make that
    # first so we take it out list of possible
    # generators:
    if (HasOne(A)) then
      gens := GeneratorsOfAlgebraWithOne(A);
    else
      gens := GeneratorsOfAlgebra(A);
    fi;

    len := Length(gens);

    # Just return full gen list if none provided
    if ( IsEmpty(table) ) then
      table := gens;

    # Handle the indices case
    elif ( IsPosInt(table[1]) ) then

      # Grab index set:
      idx := ShallowCopy(table);
      table := [];

      # Add elements we already have:
      for el in idx do
        Add(table, gens[el]);
      od;

      # Remove these same elements from generator list:
      gens := Difference(gens, table);

      # Add in the rest of the generators:
      for el in gens do
        Add(table, el);
      od;

    # Handle the generators case
    else

      # Cannot use "table := Difference(table,i);"
      # here since GAP sorts the generators.
      oldtable := ShallowCopy(table);
      table := [];

      # remove identity element(s) from list
      for el in oldtable do
        if el <> One(A) then
          Add(table,el);
        fi;
      od;

      # Get all nonidentity generators left over
      gens := Difference(gens,table);

      # add them to end of list (in default order)
      for el in gens do
        Add(table, el);
      od;

    fi;

    return table;
  end
);


# Given an ordered list of generators for an algebra,
# IndexGenerators transforms the list to one with
# which sorting comparisons may be made.
InstallMethod(IndexGenerators,
  "transforms generator ordering to numeric list for sorting use",
  true,
  [ IsList ],
  0,
  function(table)
    local i, o, idx, x;

    o := List(table, x->ExtRepOfObj(x)[2][1][1]);
    idx := [];

    for i in [ 1 .. Length(o) ] do
      idx[o[i]] := i;
    od;

    #Print("ordering: ",o," index: ",idx,"\n");
    return idx;
  end
);


#
# This function is really a wrapper for the ordering
# function given by the noncommutative monomial ordering
# passed in.  It returns the appropriate function
# for the ordering, based on whether or not it's the
# indexed version.
# Note: this returns a function that compares `list'
# representations of monomials in a free algebra.
#
InstallMethod(OrderingLtFunctionListRep,
  "returns function given by monomial ordering object",
  true,
  [ IsNoncommutativeMonomialOrdering ],
  0,
  function(ord)
    return function(a,b)
      local fun, fun2, aux, idx, retval, flag, numargs;

      retval := false;
#Print("Using: ", Name(ord),"\n");
      if ( not a=b ) then

        # Get our list rep comparison function from
        # our ordering, and our auxilliary table:
        fun := LtFunctionListRep(ord);
        aux := AuxilliaryTable(ord);

        # If has 3 arguments, then return indexed
        #  function, otherwise non-indexed function:
        numargs := NumberArgumentsFunction(fun);
        if ( numargs = 4 ) then
          idx := LexicographicIndexTable(ord);
          retval :=  fun(a,b,aux,idx);
        else
          retval :=  fun(a,b,aux);
        fi;

        # If retval == true, return right away, otherwise
        #  do more checks:
        if (retval) then
          return(true);
        else

          # Check if a > b:
          if ( numargs = 4 ) then
            idx := LexicographicIndexTable(ord);
            flag :=  fun(b,a,aux,idx);
          else
            flag :=  fun(b,a,aux);
          fi;

          if (flag) then
            return(false);
          else
            # We must have equivalence at this point:
            # Check if we have a next ordering:
            if (HasNextOrdering(ord)) then
              fun2 := OrderingLtFunctionListRep(NextOrdering(ord));
              retval := fun2(a,b);
            fi;
          fi;

        fi;
      fi;

      return(retval);
    end;
  end
);


InstallMethod(OrderingGtFunctionListRep,
  "returns function given by monomial ordering object",
  true,
  [ IsNoncommutativeMonomialOrdering ],
  0,
  function(ord)
    return function(a,b)
      local fun, fun2, idx, aux, retval, retval2, flag, numargs;

      retval := false;
#Print("Using: ", Name(ord),"\n");
      if ( not a=b ) then

        # Get our list rep comparison function from
        # our ordering:
        fun := LtFunctionListRep(ord);
        aux := AuxilliaryTable(ord);

        # If has 3 arguments, then return indexed
        #  function, otherwise non-indexed function:
        numargs := NumberArgumentsFunction(fun);
        if ( numargs = 4 ) then
          idx := LexicographicIndexTable(ord);
          retval :=  fun(a,b,aux,idx);
        else
          retval :=  fun(a,b,aux);
        fi;

        # If retval == false, return right away since
        #  we cannot have a > b if a < b, otherwise
        #  do more checks:
        if (retval) then
          return(false);
        else

          # Check if a < b:
          if ( numargs = 4 ) then
            idx := LexicographicIndexTable(ord);
            flag :=  fun(b,a,aux,idx);
          else
            flag :=  fun(b,a,aux);
          fi;

          if (flag) then
            return(true);
          else
            # We must have equivalence at this point:
            # Check if we have a next ordering:
            if (HasNextOrdering(ord)) then
              fun2 := OrderingGtFunctionListRep(NextOrdering(ord));
              retval := fun2(a,b);
            fi;
          fi;

        fi;
      fi;

      return(retval);
    end;
  end
);


##
#E
