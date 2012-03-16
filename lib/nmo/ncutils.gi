#############################################################################
##
#W  ncutils.gi                NMO Utils                        Randall Cone
##
##  (C) 2010 Mathematics Dept., Virginia Polytechnic Institute, USA
##
#############################################################################

# String routine for elements of algebras.
InstallMethod(
  String,
  "free magma element",
  [ IsElementOfFreeAssociativeRing ],
  function(el)
    local i, rep, len, str;

    rep := CoefficientsAndMagmaElements(el);
    len := Length(rep);

    if (len = 0) then
      str := "0";
    else
      str := "";

      for i in [2,4 .. len] do
        if (i = len) then
          str := Concatenation(str, "(", String(rep[i]), ")*", String(rep[i-1]) );
        else
          str := Concatenation(str, "(", String(rep[i]), ")*", String(rep[i-1]), "+" );
        fi;
      od;

    fi;

    return str;
  end
);


InstallMethod(
  PatchGBNP,
  "patches GBNP to use new orderings",
  true,
  [ IsNoncommutativeMonomialOrdering ],
  0,
  function(ncordering)
    MakeReadWriteGlobal("LtNP");
    UnbindGlobal("LtNP");
    DeclareGlobalFunction("LtNP");
    MakeReadWriteGlobal("LtNP");
    LtNP := OrderingLtFunctionListRep(ncordering);
    MakeReadOnlyGlobal("LtNP");

    Print("LtNP patched.\n");

    MakeReadWriteGlobal("GtNP");
    UnbindGlobal("GtNP");
    DeclareGlobalFunction("GtNP");
    MakeReadWriteGlobal("GtNP");
    GtNP := OrderingGtFunctionListRep(ncordering);
    MakeReadOnlyGlobal("GtNP");

    Print("GtNP patched.\n");
  end
);


InstallGlobalFunction(
  UnpatchGBNP,
  function()

    # Fix GBNP's LtNP function:
    MakeReadWriteGlobal("LtNP");
    UnbindGlobal("LtNP");
    DeclareGlobalFunction("LtNP");
    MakeReadWriteGlobal("LtNP");

    InstallGlobalFunction(
      LtNP,function(u,v)
        if Length(u)<Length(v) then
           return(true);
        elif Length(u)=Length(v) then
           return(u<v);
        else return(false);
        fi;
      end);;

    MakeReadOnlyGlobal("LtNP");
    Print("LtNP restored.\n");

    # Fix GBNP's GtNP function:
    MakeReadWriteGlobal("GtNP");
    UnbindGlobal("GtNP");
    DeclareGlobalFunction("GtNP");
    MakeReadWriteGlobal("GtNP");

    InstallGlobalFunction(
      GtNP,function(u,v)
        if Length(u)>Length(v) then
           return(true);
        elif Length(u)=Length(v) then
               return(u>v);
        else return(false);
        fi;
    end);;

    MakeReadOnlyGlobal("GtNP");
    Print("GtNP restored.\n");

  end
);;


##
#E
