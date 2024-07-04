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

### filename = "trace.gi"
### authors Cohen & Gijsbers

### THIS IS PART OF A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES


### jwk: StrongNormalFormTraceNP has been rewritten into
### StrongNormalFormTraceDiff, di 12 jun 2007 17:39:59 CEST
###
### Last change: September 23, 2003
### jwk StrongNormalFormTraceNP can now be called with a non-record NP
###     polynomial
### Last change: August 13, 2003.
### jwk split into .gd/.gi files and added GAPDoc comments
### Last change: Sep 11, 2001.
### dahg
### Last change: Sep 5, 2001.
### dahg
###NB: documentation not completed

#EvalTrace:=function(pol,rels);
#GBNP.SortTP:=function(pol);
#GBNP.SortTPList:=function(GB);
#GBNP.SpolyTrace:=function(l,G);
#GBNP.StrongNormalFormTrace2:=function(f,G,G2)
#StrongNormalFormTraceDiff:=function(f,G);
#GBNP.ObsTrace:=function(j,G,todo);
#GBNP.CentralTrace:=function(j,G,todo);
#GBNP.ReducePolTrace2:=function(G);
#GBNP.ReducePolTrace:=function(B);
#GBNP.AllObsTrace:=function(G);
#GBNP.SGrobnerTraceLoop:=function(G,todo);
#  SGrobnerTrace:=function(KI);

#################
### EvalTrace ###
#################
### <#GAPDoc Label="EvalTrace">
### <ManSection>
### <Func Name="EvalTrace" Comm="Evaluates the trace of a traced polynomial" Arg="p,
### Lnp"/>
###
### <Returns>
### The trace evaluated to a polynomial in NP format.
### </Returns>
###
### <Description>
### For a traced polynomial <A>p</A> and a list <A>Lnp</A> of polynomials
### in NP format,
### this program evaluates the trace by substituting
### the polynomials of <A>Lnp</A> back in the expression
### <C>p.trace</C> and computing the resulting polynomial.
### The result should have
### the same value as <C>p.pol</C>.
### <P/>
### <#Include Label="example-EvalTrace">
### </Description>
### </ManSection>
### <#/GAPDoc>

InstallGlobalFunction(
EvalTrace,function(p,K)
    local c,    # trace scalar
          i,    # trace index of original relation
          ml,   # trace left monomial
          mr,   # trace right monomial
          one,  # the one of the field
          t,    # current term
          val;  # result so far

    val:=[[],[]];
    if p.trace = [] then
        return val;
    fi;

    one:=One(p.trace[1][4]);

    for t in p.trace do
        c:=t[4];
        i:=t[2];
        ml:=t[1];
        mr:=t[3];
        # add the value of the trace c * ml * K[i] * mr to val
        val:=CleanNP(AddNP(val,BimulNP(ml, K[i], mr),one,c));
    od;

    return val;
end);

#################
### GBNP.SortTP
### - Sorts the trace of a polynomial
###
### Arguments:
### pol         - non-commutative traced polynomial
###
### Returns:
### pol         - non-commutative traced polynomial
###               with sorted trace
###
###***further sorting is possible, eg by right pol factor...***
###
### #GBNP.SortTP uses:#
### #GBNP.SortTP is used in: GBNP.SortTPList#
###

GBNP.SortTP := function (p) local i,k,h;
    h := p.trace;
    k := [];
    for i in h do
        if IsInt(i[2]) then
            Add(k,i[2]);
        else
            Add(k,10^8); # combinations last, XXX can be sorted more
        fi;
    od;
    SortParallel(k,h);
end;

#################
### GBNP.SortTPList
### - Sorts the traces of a list of traced polynomials
###
### Arguments:
### G           - set of non-commutative traced polynomials
###
### Returns:
### G           - set of non-commutative traced polynomials
###               with sorted trace
###
### #GBNP.SortTPList uses: GBNP.SortTP#
### #GBNP.SortTPList is used in: SGrobnerTrace#
###

GBNP.SortTPList := function (GB) local i,k,h;
    for i in [1..Length(GB)] do
        GBNP.SortTP(GB[i]);
    od;
end;



#################
### GBNP.SpolyTrace
### - Computes the S-polynomials in a basis G w.r.t. an obstruction l.
### Output is a cleaned polynomial
###
### Arguments:
### l           - an obstruction
### G           - set of non-commutative polynomials
###
### Returns:
### pol         - cleaned S-polynomial in the basis G w.r.t. the obstruction l
###
### #GBNP.SpolyTrace uses: AddNP BimulNP GBNP.AddTrace#
### #GBNP.SpolyTrace is used in: GBNP.CentralTrace GBNP.ObsTrace#
###

GBNP.SpolyTrace:=function(l,G) local k,ans,first,second;

    ans:=rec( pol:=[], trace:=[]);
    first:=BimulNP(l[1],G[l[2]].pol,l[3]);
    second:=BimulNP(l[4],G[l[5]].pol,l[6]);
    ans.pol:=AddNP(first,second,1,-1);
    k:=StructuralCopy(G[l[2]].trace);
    ans.trace:=GBNP.AddTrace([],l[1],k,l[3],1);
    k:=StructuralCopy(G[l[5]].trace);
    ans.trace:=GBNP.AddTrace(ans.trace,l[4],k,l[6],-1);
    return(ans);
end;;

###################
### GBNP.StrongNormalFormTrace2
### - Computes the normal form of a non-commutative polynomial
### (as in Mora's algorithm)
###
### Assumptions:
###
### -  polynomials in G are ordered. (lowest degree first)
### -  polynomials in G are ordered themselves. (lowest degree first)
### -  polynomials in G are monic.
### -  polynomial f is clean, monic and ordered.
### -  polynomial f is not [[],[]] empty.
###
### Arguments:
### f           - a non-commutative polynomial
### G           - set of non-commutative polynomials (NOT containing f)
### G2          - set of non-commutative polynomials (NOT containing f)
###
### Returns:
### pol         - strong normalform of f w.r.t. G
###
### #GBNP.StrongNormalFormTrace2 uses: AddNP BimulNP GBNP.AddTrace GBNP.LTermsTrace GBNP.OccurInLst GBNP.ReduceCancellationTrace#
### #GBNP.StrongNormalFormTrace2 is used in: GBNP.CentralTrace GBNP.ObsTrace GBNP.ReducePolTailsTrace GBNP.ReducePolTrace2 GBNP.SGrobnerTraceLoop StrongNormalFormTraceDiff#
###

GBNP.StrongNormalFormTrace2:=function(f,G,G2) local g,h,i,i2,j,hh,k,l,l2,m,dr,ga,tt,lth,iid,ltsG,ltsG2,trace;

    h:=StructuralCopy(f);
    ltsG:=GBNP.LTermsTrace(G);
    ltsG2:=GBNP.LTermsTrace(G2);
    iid:=1;
    while iid <= Length(h.pol[1]) do
      lth:=h.pol[1][iid];
      l:=Length(ltsG);
      l2:=Length(ltsG2);
      i:=GBNP.OccurInLst(lth,ltsG);
      i2:=GBNP.OccurInLst(lth,ltsG2);
      while i[1]+i2[1]>0 do
            if i[1]>0 then
                g:=StructuralCopy(G[i[1]].pol);
                ga:=lth{[1..i[2]-1]};
                dr:=lth{[i[2]+Length(g[1][1])..Length(lth)]};
                m:=-h.pol[2][iid]/g[2][1];
                h.pol:=AddNP(h.pol,BimulNP(ga,g,dr),1,m);
                k:=StructuralCopy(G[i[1]].trace);
                h.trace:=GBNP.AddTrace(h.trace,ga,k,dr,m);
                if h.pol=[[],[]] then
                   # setting the trace empty is not useful
                   # h.trace:=[];
                   return(h);
                fi;
                if iid <= Length(h.pol[1]) then lth := h.pol[1][iid];
                    i:=GBNP.OccurInLst(lth,ltsG);
                    i2:=GBNP.OccurInLst(lth,ltsG2);
                else
                   return(GBNP.ReduceCancellationTrace(h));
                fi;
             else
                g:=StructuralCopy(G2[i2[1]].pol);
                ga:=lth{[1..i2[2]-1]};
                dr:=lth{[i2[2]+Length(g[1][1])..Length(lth)]};
                m:=-h.pol[2][iid]/g[2][1];
                h.pol:=AddNP(h.pol,BimulNP(ga,g,dr),1,m);
                k:=StructuralCopy(G2[i2[1]].trace);
                h.trace:=GBNP.AddTrace(h.trace,ga,k,dr,m);
                if h.pol=[[],[]] then
                   # setting the trace empty is not useful
                   # h.trace:=[];
                   return(h);
                fi;
                if iid <= Length(h.pol[1]) then lth := h.pol[1][iid];
                    i:=GBNP.OccurInLst(lth,ltsG);
                    i2:=GBNP.OccurInLst(lth,ltsG2);
                else
                   return(GBNP.ReduceCancellationTrace(h));
                fi;

             fi;
       od;
       iid := iid+1;
    od;

    return GBNP.ReduceCancellationTrace(h);

    return(h);
end;;

###################
### <#GAPDoc Label="StrongNormalFormTraceDiff">
### <ManSection>
### <Func Name="StrongNormalFormTraceDiff" Comm="computes the difference with
### the strong normal form of an NP polynomial with trace
### information" Arg="np, GBT"
### />
### <Returns>
### The traced polynomial for the
### difference of <A>f</A> with the strong normal form of <A>np</A> with
### respect to <A>GBT</A>
### </Returns>
### <Description>
### When invoked with a polynomial <A>np</A> in NP format as
### its first argument, and a traced Gröbner basis <A>GBT</A> as generated by
### <Ref Func="SGrobnerTrace" Style="Text"/>, this function returns the
### difference of <A>np</A> with the strong normal form of <A>np</A>
### with respect to <A>GBT</A>. This difference <C>d</C> is returned as a
### traced polynomial.
### The trace information <C>d.trace</C> gives an expression of <C>d.pol</C>
### as a combination of polynomials from the list of polynomials
### to which the trace parts of <A>GBT</A> are referring.
### Typically, this is the set of relations used as input to the computation
### of <A>GBT</A>.
### <P/>
### Note that the difference of the polynomials <A>np</A> and <C>d.pol</C>
### is the same as the StrongNormalForm of <A>np</A>.
### <P/>
### <#Include Label="example-StrongNormalFormTraceDiff">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
###
### StrongNormalFormTraceDiff
### - Computes the difference with the strong normal form of a non-commutative
###   polynomial as a trace
###
### Assumptions:
###
### -  GBT is a traced Gröbner basis
### -  polynomial f is clean.
###
### Arguments:
### f           - a non-commutative polynomial
### GBT         - list of non-commutative polynomials
###
### Returns:
### pol         - strong normalform of f w.r.t. G
###
### #StrongNormalFormTraceDiff uses: AddNP GBNP.StrongNormalFormTrace2#
### #StrongNormalFormTraceDiff is used in:#
###

InstallGlobalFunction(
StrongNormalFormTraceDiff,function(f,GBT)
local minus_f,
      minus_fs,
      one;

    # input of a trace polynomial for f is no longer supported
    if IsRecord(f) then
        return fail;
    fi;

    if f = [[],[]] then
        # if f = 0 then return 0
        return rec(pol:=f,trace:=[]);
    else
        # if f is not 0 then set one to the one of the field
        one:=One(f[2][1]);

        # calculate -fs instead of fs
        minus_f:=AddNP(f,[[],[]],-one,one);
        minus_fs:=GBNP.StrongNormalFormTrace2(rec(pol:=minus_f,trace:=[]),GBT,
            []);

        # return f - fs (where fs is the strongnormalform of f)
        return rec(pol:=AddNP(f,minus_fs.pol,one,one),trace:=minus_fs.trace);
    fi;

end);;

##################
### GBNP.ObsTrace
### - Finding all obstructions of u, leading term of G[j],
### w.r.t. the set of leading terms of G.
###
### Assumptions:
### - Central obstructions are already done, so only self, left and right.
###
### Arguments:
### j           - index of a non-commutative polynomial in G
### G           - set of non-commutative polynomials
### todo        - set of S-polynomials (todo)
###
### Returns:
### todo        - new list of S-polynomials. S-polynomials with G[j] added
###
### #GBNP.ObsTrace uses: GBNP.LTermsTrace GBNP.LeftObs GBNP.MkMonicNPTrace GBNP.RightObs GBNP.SelfObs GBNP.SpolyTrace GBNP.StrongNormalFormTrace2#
### #GBNP.ObsTrace is used in: GBNP.AllObsTrace GBNP.SGrobnerTraceLoop#
###

GBNP.ObsTrace:=function(j,G,todo) local R,obs,sob,ob,temp;

   R:=GBNP.LTermsTrace(G);
   sob:=GBNP.SelfObs(j,R);
   obs:=GBNP.LeftObs(j,R,sob);
   Append(obs,GBNP.RightObs(j,R,sob));
#   Print("There are ",Length(obs)," new obstructions found.\n");
   for ob in obs do
       temp:=GBNP.SpolyTrace(ob,G);
       if temp.pol <> [[],[]] then
           temp:=GBNP.StrongNormalFormTrace2(temp,G,todo);
           if temp.pol <> [[],[]] then
           temp:=GBNP.MkMonicNPTrace(temp);
           Add(todo,StructuralCopy(temp));
           fi;
       fi;
    od;
    temp:=GBNP.LTermsTrace(todo);
    SortParallel(temp,todo,LtNP);
end;;



##################
### GBNP.CentralTrace
### - Finding all central obstructions of u, leading term of G[j],
###   w.r.t. the set of leading terms of G.
###
### Arguments:
### j           - index of a non-commutative polynomial in G
### G           - set of non-commutative polynomials
### todo        - set of S-polynomials (todo)
###
### Returns:
### todo        - new list of S-polynomials. S-polynomials with G[j] added
###
### #GBNP.CentralTrace uses: GBNP.LTermsTrace GBNP.MkMonicNPTrace GBNP.Occur GBNP.SpolyTrace GBNP.StrongNormalFormTrace2#
### #GBNP.CentralTrace is used in: GBNP.SGrobnerTraceLoop#
###

GBNP.CentralTrace:=function(j,G,todo) local R,ob,temp,i,o,u,v,lu,lv;
   R := GBNP.LTermsTrace(G);
   u:=R[j];
   lu:=Length(u);
   for i in [1..j-1] do
          v:=R[i];
          lv:=Length(v);
          o:=GBNP.Occur(u,v);
          if o > 1 and o+lu<=lv then
                 temp:=GBNP.SpolyTrace([v{[1..o-1]},j,v{[o+lu..lv]},[],i,[]],G);
                 if temp.pol <> [[],[]] then
                    temp:=GBNP.StrongNormalFormTrace2(temp,G,todo);
                    if temp.pol <> [[],[]] then
                        temp:=GBNP.MkMonicNPTrace(temp);
                        Add(todo,StructuralCopy(temp));
                    fi;
                 fi;
          fi;
   od;
end;;

##################
### GBNP.ReducePolTrace2
### New function to clean the input
###
### Arguments:
### G           - set of non-commutative polynomials
###
### Returns:
### G           - Cleaned, reduced, ordered list of non trivial S-polynomials.
###
### #GBNP.ReducePolTrace2 uses: GBNP.LTermsTrace GBNP.MkMonicNPTrace GBNP.Occur GBNP.StrongNormalFormTrace2 LtNP#
### #GBNP.ReducePolTrace2 is used in: GBNP.AllObsTrace GBNP.ReducePolTrace SGrobnerTrace#
###

GBNP.ReducePolTrace2:=function(G) local i,j,h,ind,lts,new,lans,newind;

    lts:= GBNP.LTermsTrace(G);
    SortParallel(lts,G,LtNP);
    lans:= Length(G);
    ind:=[1..lans];
    while ind <> [] do
        i:=ind[1];
        RemoveSet(ind,i);
        j:=i+1;
        while j <= lans do
            if GBNP.Occur(G[i].pol[1][1],G[j].pol[1][1]) <> 0 then
                # If lt(j) is a multiple of lt(i) then compute
                # g(i)'s strongnormalform with respect to all other poly's
                new:=GBNP.StrongNormalFormTrace2(G[j],G{[1..j-1]},G{[j+1..lans]});
                if new.pol = [[],[]] then
                  # If strongnormalform is zero, remove pol(j) from the list,
                  RemoveElmList(G,j);
                  RemoveSet(ind,lans);
                  lans:=lans-1;
                else
                  newind:=1;
                  # If strongnormalform is not zero, replace pol(j) by its snf
                  while LtNP(G[newind].pol[1][1],new.pol[1][1]) and newind < lans+1 do
                        newind:=newind+1;
                  od;
                  RemoveElmList(G,j);
                  new:=GBNP.MkMonicNPTrace(new);
                  InsertElmList(G,newind,StructuralCopy(new));
                  RemoveSet(ind,j);
                  for h in [1..Length(ind)] do
                        if ind[h] in [newind..j-1] then ind[h]:=ind[h]+1; fi;
                  od;
                  if i in [newind..j-1] then i:=i+1; fi;
                  AddSet(ind,newind);
                  j:=j+1;
                fi;
            else j:=j+1;
            fi;
        od;
    od;
end;;

##################
### GBNP.ReducePolTrace
### function to clean, order and reduce a list of non-commutative polynomials
###
### Arguments:
### G           - list of non-commutative polynomials
###
### Returns:
### G           - Cleaned, reduced, ordered list of non-commutative polynomials.
###
### #GBNP.ReducePolTrace uses: CleanNP GBNP.MkMonicNPTrace GBNP.ReducePolTrace2 GBNP.Traced#
### #GBNP.ReducePolTrace is used in: SGrobnerTrace#
###

GBNP.ReducePolTrace:=function(B) local ans;

        ans:=GBNP.Traced(List(B,x -> CleanNP(x)));
        ans:=List(ans, x -> GBNP.MkMonicNPTrace(x));
        ans:=Filtered(ans, x-> x.pol <> [[],[]]); # remove zero polynomials
        GBNP.ReducePolTrace2(ans);
        return(ans);
end;;


################################
### GBNP.ReducePolTailsTrace ###
################################
###
### This is a function to reduce the tails of a Gröbner basis that is already
### in the right order.
###
### This function assumes that all polynomials are sorted and cleaned.
###
### The order will only be preserved if:
### - no leading terms are the same
### - no leading terms can be reduced by other relations in G
###
### Arguments:
### - G   A Gröbner basis of which no leading terms
###
### Returns:
### - G   A list of polynomials with the tail reduced

GBNP.ReducePolTailsTrace:=function(G)
    local
        j,  # loop variable (of G)
        lg; # length of G

    lg:=Length(G);

    # for each polynomial...
    for j in [1..lg] do
        # ... reduce it with the other relations (note that the leading term
        # should not change)
        G[j]:=GBNP.StrongNormalFormTrace2(G[j],G{[1..j-1]},G{[j+1..lg]});
    od;
end;

##################
### GBNP.AllObsTrace
### - Computing all obstructions w.r.t. basis at that time
### (first part of the algorithm).
###
### Assumptions:
### - Central obstructions are already done, so only self, left and right.
###
### Arguments:
### G           - set of non-commutative polynomials
###
### Returns:
### todo        - list of non trivial S-polynomials.
###
### #GBNP.AllObsTrace uses: GBNP.LTermsTrace GBNP.ObsTrace GBNP.ReducePolTrace2#
### #GBNP.AllObsTrace is used in: SGrobnerTrace#
###

GBNP.AllObsTrace:=function(G) local k,ans,temp,temp2;

    ans:=[];
    for k in [1..Length(G)] do
        GBNP.ObsTrace(k,G,ans);
    od;
    GBNP.ReducePolTrace2(ans);
    temp:=GBNP.LTermsTrace(ans);
    SortParallel(temp,ans,LtNP);
    return(ans);
end;;

##################
### GBNP.SGrobnerTraceLoop
### - Computing a grobner basis
### (loop of the algorithm).
###
###
### Arguments:
### G           - set of non-commutative polynomials
### todo        - list of non trivial S-polynomials.
###
### Returns:
### G           - non-commutative grobner basis
###

# new version in grobnerloops2.gi

##################
### SGrobnerTrace
### <#GAPDoc Label="SGrobnerTrace">
### <ManSection>
### <Func Name="SGrobnerTrace" Comm="Buchberger's algorithm with normalform" Arg="Lnp" />
### <Returns>
### Gröbner Basis, traceable
### </Returns>
### <Description>
### For a list of noncommutative polynomials <A>Lnp</A> this function will use
### Buchberger's algorithm with strong normal form to find a Gröbner Basis
### <C>G</C> (if possible; the general problem is unsolvable).
### <P/>
### The results will be traceable. Functions that can print the Gröbner basis
### are <Ref Func="PrintTraceList" Style="Text"/> (with the trace) and
### <Ref Func="PrintNPListTrace" Style="Text"/> (without the trace).
### <P/>
### <#Include Label="example-SGrobnerTrace">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Buchberger's algorithm with normalform
###
### Input: List of polynomials. shape a^2-b  = [[[1,1],[2]],[1,-1]]
###
### Output: Grobner Basis
###
### Invariants of set G={g_1,...,g_s}
### - G is basis of ideal
### - all g_i are monic
### - for all S-polynomials S(i,j) with g_i and g_j in G holds
###  S(i,j) has a weak grobner representation (defined by MORA)
###                     or !
###  S(i,j) is an element of todo.
###
### Thm 5.1 (MORA) A basis G of an ideal I is a Grobner basis of I if and only if
### - all elements of G are monic
### - all S-polynomials have a weak grobner representation
###
### Quick observation, if todo is empty then G is a Grobner basis
###
### #SGrobnerTrace uses: GBNP.AllObsTrace GBNP.ReducePolTailsTrace GBNP.ReducePolTrace GBNP.ReducePolTrace2 GBNP.SGrobnerTraceLoop GBNP.SortTPList#
### #SGrobnerTrace is used in:#

InstallGlobalFunction(
SGrobnerTrace,function(KI) local G,tt,todo;

    tt:=Runtime();

# phase I, start-up, building G
# - Clean the list and make all polynomials monic
# - Sort each polynomial so that its leading term is in front
# - Order the set of polynomials such that
#      the one with smallest leading term comes first
# - Compute internal NormalForm


     Info(InfoGBNP,1,"number of entered polynomials is ",Length(KI));
     G := GBNP.ReducePolTrace(KI);

     Info(InfoGBNP,1,"number of polynomials after reduction is ",Length(G));
#    Print("The list of starting polynomials is:\n ",G,"\n");
     Info(InfoGBNP,1,"End of phase I");


# phase II, initialization, making todo
# - Compute all possible obstructions
# - Compute their S-polynomials
# - Make a list of the non-trivial NormalForms

     todo:=GBNP.AllObsTrace(G);

#    Print("Current set of spolynomials is ",todo,"\n");
#    Print("Current number of spolynomials is ",Length(todo),"\n");
     Info(InfoGBNP,1,"End of phase II");


# phase III, The loop

     GBNP.SGrobnerTraceLoop(G,todo);
     Info(InfoGBNP,1,"End of phase III");


# phase IV, make the result reduced

     GBNP.ReducePolTrace2(G);
     GBNP.ReducePolTailsTrace(G);
     Info(InfoGBNP,1,"End of phase IV");

# End of the algorithm


#    Print("Current number of base leading terms is ",Length(G),"\n");
     Info(InfoGBNPTime,1,"The computation took ",Runtime()-tt, " msecs.");

     GBNP.SortTPList(G);
     return(G);
end);;

### #GBNP.ReduceCancellationTrace uses: GBNP.GetOptions#
### #GBNP.ReduceCancellationTrace is used in: GBNP.StrongNormalFormTrace2#
###

GBNP.ReduceCancellationTrace:=function(old)
local   pol,    # the polynomial of old
        nummon, # the number of monomials in pol
        bound,  # boolean, true if all monomials are longer than 1
        same,   # boolean, true if all checked symbols are the same
        i,j,    # counters
        sym,    # symbol to check (generator that is first or last in the lt)
        lenmin, # minimum length (if 0 -> no further cancellation possible)
        n,      # alphabetsize
        pre,
        post,
        new;

        if not IsBound(GBNP.GetOptions().CancellativeMonoid) then
                return old;
        fi;

        n := GBNP.GetOptions().Alphabetsize;
        pol := StructuralCopy(old.pol);
        pre:=[];
        post:=[];

        nummon := Length(pol[1]);
        if nummon < 2 then
                return old; # cancellation only if there are at least 2 words
        fi;

        # calculate min len
        lenmin:=Minimum(List(pol[1],x->Length(x)));

        same:=true;
        while lenmin>0 and same do
                sym:=pol[1][1][Length(pol[1][1])];
                i:=2;
                while i<=nummon and same do
                        same:=same and pol[1][i][Length(pol[1][i])]=sym;
                        i:=i+1;
                od;

                if same then
                        for i in [1..nummon] do
                                RemoveElmList(pol[1][i],Length(pol[1][i]));
                        od;
                        InsertElmList(post,Length(post)+1,sym+n);
                        lenmin:=lenmin-1;
                fi;
        od;

        same:=true;
        while lenmin>0 and same=true do
                sym:=pol[1][1][1];
                i:=2;
                while i<=nummon and same do
                        same:=same and pol[1][i][1]=sym;
                        i:=i+1;
                od;
                if same then
                        for i in [1..nummon] do
                                RemoveElmList(pol[1][i],1);
                        od;
                        InsertElmList(pre,1,sym+n);
                        lenmin:=lenmin-1;
                fi;
        od;

        if pre<>[] or post<>[] then
                new:=rec(pol:=pol,trace:=[[pre,old,post,1]]);
                return new;
        else
                return old;
        fi;
end;

# sort trace tupels (which are of the form ml, i, mr, c)
# order: i, ml*mr, ml, mr, c
# returns true if tupel1<tupel2 and false otherwise
GBNP.TraceSortFun:=function(tupel1,tupel2)
local   i1,i2,
        ml1,ml2,
        mr1,mr2,
        c1,c2;

        # tupel is ml i mr c
        ml1:=tupel1[1];
        i1:=tupel1[2];
        mr1:=tupel1[3];
        c1:=tupel1[4];

        ml2:=tupel2[1];
        i2:=tupel2[2];
        mr2:=tupel2[3];
        c2:=tupel2[4];

        # compare i1 and i2
        if (i1<i2) then
                return true;
        elif (i1>i2) then
                return false;
        fi;

        # compare ml1*mr1 and ml2*mr2
        if LtNP(Concatenation(ml1,mr1),Concatenation(ml2,mr2)) then
                return true;
        elif GtNP(Concatenation(ml1,mr1),Concatenation(ml2,mr2)) then
                return false;
        fi;

        # compare ml1 and ml2
        if LtNP(ml1,ml2) then
                return true;
        elif GtNP(ml1,ml2) then
                return false;
        fi;

        # compare mr1 and mr2
        if LtNP(mr1,mr2) then
                return true;
        elif GtNP(mr1,mr2) then
                return false;
        fi;

        # compare c1 and c2
        return c1<c2;
end;

# Clean function for trace.
# trace is of the form ml, i, mr, c
#
# this function sorts the traces and combines terms with the same ml, i and mr
# by adding the scalars.
#
# in the end all zero terms are filtered out
GBNP.CombineTrace:=function(trace)
local   sorted,
        reduced,
        max,
        tupel;

        sorted:=ShallowCopy(trace);
        Sort(sorted, GBNP.TraceSortFun);

        reduced:=[];
        max:=0;
        for tupel in sorted do
                if max = 0 then
                        Add(reduced,tupel);
                        max:=max+1;
                elif reduced[max][1]=tupel[1] and reduced[max][2]=tupel[2]
                                and reduced[max][3]=tupel[3] then
                        reduced[max][4]:=reduced[max][4]+tupel[4];
                else
                        Add(reduced,tupel);
                        max:=max+1;

                fi;

        od;
        return Filtered(reduced,tupel->not(IsZero(tupel[4])));
end;
