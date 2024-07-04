######################### BEGIN COPYRIGHT MESSAGE #########################
# GBNP - computing Gröbner bases of noncommutative polynomials
# Copyright 2001-2010 by Arjeh M. Cohen, Dié A.H. Gijsbers, Jan Willem
# Knopper, Chris Krook. Address: Discrete Algebra and Geometry (DAM) group
# at the Department of Mathematics and Computer Science of Eindhoven
# University of Technology.
#
# For acknowledgements see the manual. The manual can be found in several
# formats in the doc subdirectory of the GBNP distribution. The
# acknowledgements formatted as text can be found in the file chap0.txt.
#
# GBNP is free software; you can redistribute it and/or modify it under
# the terms of the Lesser GNU General Public License as published by the
# Free Software Foundation (FSF); either version 2.1 of the License, or
# (at your option) any later version. For details, see the file 'LGPL' in
# the doc subdirectory of the GBNP distribution or see the FSF's own site:
# https://www.gnu.org/licenses/lgpl.html
########################## END COPYRIGHT MESSAGE ##########################

### file "printing.gi"
###

# THIS IS PART OF A NON COMMUTATIVE GROBNER BASIS PACKAGE FOR GAP

#PrintNP:=function(np);
#PrintNPList:=function(G);
#GBNP.PrintNPnonewline:=function(np);
#GBNP.PrintNPM:=function(np);
#GBNP.TransLetter:=function(y);
#GBNP.TransWord:=function(wrd);
#GBNP.PrintTraceTerm:=function(term);
#PrintTracePol:=function(pol);
#PrintTraceList:=function(G);
#PrintNPListTrace:=function(G);

###############
### PrintNP ###
###############
### Printing the polynomial np
### <#GAPDoc Label="PrintNP">
### <ManSection>
### <Func Name="PrintNP" Comm="Print a polynomial in NP format" Arg="np"/>
###
### <Description>
### This function prints a polynomial <A>np</A> in NP format, using the letters
### <C>a</C>, <C>b</C>, <C>c</C>, <M>\ldots</M> for <M>x_1</M>, <M>x_2</M>,
### <M>x_3</M>, <M>\ldots</M>, except that everything beyond <M>l</M> (the 12-th
### letter) is printed as <M>x</M>.
### <P/>
### This function prints a polynomial <A>np</A> in NP format
### as configured by the function <Ref Func="GBNP.ConfigPrint" Style="Text"/>.
### <P/>
### <#Include Label="example-PrintNP">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### #PrintNP uses: GBNP.GetOptions GBNP.PrintNPM GBNP.TransWord#
### #PrintNP is used in: PrintNPList#
###

InstallGlobalFunction(
PrintNP,function(ff) local ans,hlp,j,addon,l,sgn, opt, pg;
    ans:="";
    l:=Length(ff[2]);
    addon:=false;
    if l=0 then
           ans:="0";
    else
        if not Length(ff[1][1])=0 # (length=0->no module generators)
                and ff[1][1][1]<0 # module generators
                then
                pg:=GBNP.GetOption("PrintModuleGenerators");
                if pg = fail then
                        pg:= GBNP.GetOptions().pg;
                fi;
                GBNP.PrintNPM(ff, pg);
                return;
        fi;
    fi;
    for j in [1..l] do
        hlp:=ff[2][j];
        if not IsZero(hlp) then
            if not(IsRat(hlp)) then
                sgn:="+ ";
            else if (SignInt(hlp)=1) then
                     sgn:="+ ";
                else
                     sgn:="- ";
                     hlp:=AbsInt(hlp);
                fi;
            fi;
            if addon or sgn = "- " then
                 Append(ans,sgn);
            fi;
            addon:=true;
            if not IsOne(hlp) or ff[1][j]=[] then
                Append(ans,String(hlp));
            fi;
            Append(ans,GBNP.TransWord(ff[1][j]));
            Append(ans," ");
        fi;
      od;
      Print(" ",ans,"\n");
end);;

###################
### PrintNPList ###
###################
### Printing nicely
### <#GAPDoc Label="PrintNPList">
### <ManSection>
### <Func Name="PrintNPList" Comm="Print a list of polynomial in NP format" Arg="Lnp"/>
###
### <Description>
### This function prints a list <A>Lnp</A>
### of polynomials in NP format, using the
### function <C>PrintNP</C>.
### <P/>
### <#Include Label="example-PrintNPList">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### #PrintNPList uses: PrintNP#
### #PrintNPList is used in: PrintNPListTrace#
###

InstallGlobalFunction(
PrintNPList,function(G) local f;
    for f in G do
           PrintNP(f);
    od;
end);;

##############################
### GBNP.PrintNPnownewline ###
##############################
### Printing the polynomial np
###
### #GBNP.PrintNPnonewline uses: GBNP.TransWord#
### #GBNP.PrintNPnonewline is used in: GBNP.PrintNPM#
###

GBNP.PrintNPnonewline:=function(np) local ans,hlp,j,addon,l,sgn;
    ans:="";
    l:=Length(np[2]);
    addon:=false;
    if l=0 then
           ans:="0";
    fi;
    for j in [1..l] do
        hlp:=np[2][j];
        if not IsZero(hlp) then
            if (not IsRat(hlp)) or SignInt(hlp)=1 then
                         sgn:="+ ";
                  else sgn:="- ";
                  fi;
            if addon or sgn = "- " then
                         Append(ans,sgn);
               fi;
            addon:=true;
            if IsRat(hlp) then
              hlp:=AbsInt(hlp);
            fi;
            if not IsOne(hlp) or np[1][j]=[] then
                Append(ans,String(hlp));
            fi;
            Append(ans,GBNP.TransWord(np[1][j]));
            Append(ans," ");
         fi;
      od;
      Print(ans);
end;;

################
### PrintNPM ###
################
### Printing the polynomial np
### <#GAPDoc Label="PrintNPM">
### <ManSection>
### <Func Name="PrintNPM" Comm="Print a polynomial in NPM format" Arg="np, mt"/>
###
### <Description>
### This function prints a polynomial <A>np</A> in NPM format, where <A>mt</A>
### should be equal to the number of module generators).
### <P/>
### The way generators of the algebra are printed can be changed
### with the function <Ref Func="GBNP.ConfigPrint" Style="Text"/>.
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### #GBNP.PrintNPM uses: GBNP.NPM2NPArray GBNP.PrintNPnonewline#
### #GBNP.PrintNPM is used in: PrintNP#
###

GBNP.PrintNPM:=function(ff,mt)
local   nparr,  # ff as an np array
        i,      # counter
        l;      # length of nparr

        nparr:=GBNP.NPM2NPArray(ff,mt);
        l:=Length(nparr);

        Print("[ ");

        for i in [1..l] do
                GBNP.PrintNPnonewline(nparr[i]);
                if i<>l then Print(", "); fi;
        od;
        Print("]\n");
end;

########################
### GBNP.TransLetter ###
########################
### Converts a generator to a string
###
### #GBNP.TransLetter uses: GBNP.GetOptions#
### #GBNP.TransLetter is used in: GBNP.TransWord#
###

GBNP.TransLetter:=function(y)
    if IsBound(GBNP.GetOptions().PrintLetterFunction) then
        return GBNP.GetOptions().PrintLetterFunction(y);
    fi;

    if y>0 and y<13 then
        return [(CHAR_INT(y-1+INT_CHAR('a')))];
    elif y>0 then
        return "x";
    fi;
    return " ";
end;

######################
### GBNP.TransWord ###
######################
### Converts a monomial to a string
###
### #GBNP.TransWord uses: GBNP.TransLetter#
### #GBNP.TransWord is used in: GBNP.PrintNPnonewline PrintNP wordfun#
###

GBNP.TransWord:=function(wrd) local ans,x,e,y;
    ans := "";
    e := 0;
    y := 0;

    for x in wrd do
        if x=y then
            e := e+1;
        else
            if y>0 then Append(ans,GBNP.TransLetter(y)); fi;
            if e>1 then Append(ans,"^");Append(ans,String(e)); fi;
            y := x;
            e := 1;
        fi;
   od;
   if y>0 then Append(ans,GBNP.TransLetter(y)); fi;
   if e>1 then Append(ans,"^");Append(ans,String(e)); fi;

   return(ans);
end;;

###########################
### GBNP.PrintTraceTerm ###
###########################
### - Prints one term of a trace of a non-commutative polynomial
###
### Arguments:
### term        - One term of a trace of a non-commutative polynomial
###
### #GBNP.PrintTraceTerm uses: GBNP.GetOptions#
### #GBNP.PrintTraceTerm is used in: GBNP.PrintTracePolCancel PrintTracePol#
###

GBNP.PrintTraceTerm:=function(term) local k,options,wordfun,times,e;
   options:=GBNP.GetOptions();

   if IsBound(options.PrintTraceAsGP) and IsBound(options.Algebra) then
        e:=One(LeftActingDomain(options.Algebra));
        wordfun:=function(w)
                if w<>[] then
                        Print(NP2GP([[w],[e]],options.Algebra));
                fi;
        end;
        times:=function(x)
                if x<>[] then
                        return "*";
                else
                        return "";
                fi;
        end;
   else
        wordfun:=function(w) Print(GBNP.TransWord(w)); end;
        times:=x->"";
   fi;

   k:= term[4];
   if not IsZero(k) then
      if (IsRat(k)) and (SignInt(k)<>1) then
         Print("-");
         k:=-k;
      fi;
   fi;
   Print(" ");
   if not IsOne(k) then Print(k); fi;

    if IsInt(term[2]) then
        wordfun(term[1]);
        Print(times(term[1]),"G(",term[2],")",times(term[3]));
        wordfun(term[3]);
        Print(" ");
    else
        wordfun(term[1]);Print(times(term[1]),"(");
        GBNP.PrintTracePolCancel(term[2]);
        Print(")",times(term[3]));
        wordfun(term[3]);
        Print(" ");
    fi;
end;

################################
### GBNP.PrintTracePolCancel ###
################################
###
### Prints a tracepolynomial inside the brackets (which could be cancelled)
###
### Arguments:
### - pol               the polynomial to print
###
### #GBNP.PrintTracePolCancel uses: GBNP.PrintTraceTerm#
### #GBNP.PrintTracePolCancel is used in: wordfun#
###

GBNP.PrintTracePolCancel:=function(pol)
local i,k;
        if pol.pol <> [[],[]] then
                k:=Length(pol.trace);
                GBNP.PrintTraceTerm(pol.trace[1]);
                if k > 1 then
                        for i in [2..k] do
                                if (not IsRat(pol.trace[i][4])) or (SignInt(pol.trace[i][4]) > 0) then Print("+"); fi;
                                GBNP.PrintTraceTerm(pol.trace[i]);
                        od;
                fi;
        fi;
        return "";
end;


#####################
### PrintTracePol ###
#####################
### <#GAPDoc Label="PrintTracePol">
### <ManSection>
### <Func Name="PrintTracePol" Comm="Prints the trace of a traced non-commutative polynomial" Arg="p" />
### <Description>
### This function prints the trace of an NP polynomial <A>p</A>.
### <P/>
### <#Include Label="example-PrintTracePol">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Prints the trace of an NP polynomial
###
### Arguments:
### p           - traced NP polynomial
###
### #PrintTracePol uses: GBNP.PrintTraceTerm#
### #PrintTracePol is used in: PrintTraceList#
###

InstallGlobalFunction(
PrintTracePol,function(p) local i,k,trace;
       if p.pol <> [[],[]] then
           # reduce the trace before printing
           trace:=GBNP.CombineTrace(p.trace);
           k:=Length(trace);
           GBNP.PrintTraceTerm(trace[1]);
           if k > 1 then
              for i in [2..k] do
                 if (not IsRat(trace[i][4])) or (SignInt(trace[i][4]) > 0) then Print("+"); fi;
                 GBNP.PrintTraceTerm(trace[i]);
              od;
           fi;
        fi;
        Print("\n");
end);


######################
### PrintTraceList ###
######################
### <#GAPDoc Label="PrintTraceList">
### <ManSection>
### <Func Name="PrintTraceList" Comm="prints the traces of a list of non-commutative polynomials" Arg="G" />
### <Description>
### When invoked with a list  <A>G</A> of traced polynomials,
### this function prints the traces of that list.
### <P/>
### <#Include Label="example-PrintTraceList">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Prints the traces of a list of non-commutative polynomials
###
### Arguments:
### G           - Set of traced non-commutative polynomials
###
### #PrintTraceList uses: PrintTracePol#
### #PrintTraceList is used in:#
###

InstallGlobalFunction(
PrintTraceList,function(G) local i,lg;
        lg:=Length(G);
        for i in [1..lg] do
           PrintTracePol(G[i]);
           if (i<>lg) then
              Print("\n");
           fi;
        od;
end);


########################
### PrintNPListTrace ###
########################
### <#GAPDoc Label="PrintNPListTrace">
### <ManSection>
### <Func Name="PrintNPListTrace" Comm="Prints the a list of traced non-commutative polynomials, NOT using the trace." Arg="G" />
### <Description>
### When invoked with a set of traced non-commutative polynomials <A>G</A>,
### this function prints the list of the traced polynomials, without the
### trace.
### <P/>
### <#Include Label="example-PrintNPListTrace">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Prints the a list of traced non-commutative polynomials
###   NOT using the trace
###
### Arguments:
### G           - Set of traced non-commutative polynomials
###
### #PrintNPListTrace uses: PrintNPList#
### #PrintNPListTrace is is used in:#
###

InstallGlobalFunction(
PrintNPListTrace,function(G) local tra;
        for tra in G do
           PrintNPList([tra.pol]);
#          Print("\n"); # commented out by jwk so this function's output looks
                        # more like PrintNPList
        od;
end);
