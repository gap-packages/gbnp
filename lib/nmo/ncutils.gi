#############################################################################
##
#W  ncutils.gi                NMO Utils                        Randall Cone
##
##  (C) 2010 Mathematics Dept., Virginia Polytechnic Institute, USA
##
#############################################################################

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
