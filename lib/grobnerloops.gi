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


#GBNP.SGrobnerLoops:=function(G,todo,funcs)
#GBNP.SGrobnerLoop:=function(G,todo)
#GBNP.GrobnerLoop:=function(G,todo)
#GBNP.SGrobnerTruncLoop:=function(G,todo,wtv,k)
#GBNP.GrobnerLoopAll:=function(G,todo,options)
#GBNP.SGrobnerTraceLoop:=function(G,todo)
#GBNP.ObsTall:=function(j,G,todo,OT,funcs)
#GBNP.StrongNormalFormTall:=function(f,G,GLOT,funcs)
#GBNP.StrongNormalForm2Tall:=function(f,G,G2,OT,funcs)
#GBNP.StrongNormalForm3Dall:=function(f,G,G2,OT,funcs,skip)
#GBNP.StrongNormalForm2TSPTS:=function(G,j,GLOT,prefix)
#GBNP.ReducePolTails:=function(G,todo,GLOT)
#GBNP.ReducePolTailsPTS:=function(G,todo,OT,funcs)
#GBNP.ReduceCancellation:=function(pol)
#GBNP.Find3Dnum:=function(l, skip)

############################
### GBNP.SGrobnerLoops
### - The loop in the SGrobner basis computation
###
###
### Assumptions:
### - G is a list of clean polynomials all of whose minimal S polynomials
###   have a rewritten form wrt G  lying in todo.
###   the arguments are preserved! So it is really a routine
###   acting on the lists G and todo
###
### Arguments:
### G           - list of non-commutative polynomials
### todo        - list of non-commutative polynomials
###
### observe:    - this loop may never end: the noncommutative GB is
###               not guaranteed to terminate: in general the word problem
###               is unsolvable.
### #GBNP.SGrobnerLoops  uses:#
### #GBNP.SGrobnerLoops is used in: GBNP.GrobnerLoop GBNP.GrobnerLoopAll GBNP.SGrobnerLoop GBNP.SGrobnerTruncLoop Grobner SGrobner#
###

GBNP.SGrobnerLoops := function(G,todo,funcs) local i,lG,count,ltspoly,spoly,sltspoly,spo,l,h,Gset,genlist,b,OT,todoheap,iterations;


    if not IsBound(funcs.pg) then
        funcs.pg:=GBNP.GetOptions().pg;
    else
        if (funcs.pg<>0) then
                GBNP.SetOption("pg",funcs.pg); # XXX check that funcs.pg is not
                                               # erroneously 0
        fi;
    fi;

    # if G is empty or one, no iterations are needed
    if (G=[]) or (Length(G)=1 and G[1][1]=[[]] and IsOne(G[1][2][1])) then
      return rec(G:=G, todo:=[], completed:=true, iterations:=0);
    fi;


    genlist:=[1..Maximum(Flat(List(G,x->x[1])))]; # largest generator used in G
    Gset:=List(LMonsNP(G),x->BlistList(genlist,Set(x)));
    OT:=rec();

    #if IsBound(funcs.GB) then
    #   OT.GBL:=GBNP.CreateOccurTreePTSLR(LMonsNP(funcs.GB),funcs.pg,true);
    #fi;
    OT.GL:=GBNP.CreateOccurTreePTSLR(LMonsNP(G),funcs.pg,true);
    OT.GR:=GBNP.CreateOccurTreePTSLR(LMonsNP(G),funcs.pg,false);

    OT.todoL:=GBNP.CreateOccurTreePTSLR(LMonsNP(todo),funcs.pg,true);
    lG:=Length(G);
    todoheap:=THeapOT(todo, OT.todoL);
    #Print("debug: start\n");
    #GBNP.THeapOTCheck(todoheap);
    #Print("debug: start 2\n");
    count:=[Length(todoheap)];
    iterations:=0;
    while not IsTHeapOTEmpty(todoheap) do
      iterations:=iterations+1;

# Fase IIIa, Take the first element 'spoly' of todo and add it to 'G'
# - Take the first element of the todo list and remove it from todo
# - Add this to the basis

      spoly:=HeapMin(todoheap);
      ltspoly := spoly[1][1];
      sltspoly:=BlistList(genlist,Set(ltspoly)); # jwk -set
      Info(InfoGBNP,3,"added Spolynomial is:\n", spoly);
      Add(G,spoly);
      Add(Gset,sltspoly);       # jwk - Gset/todoset
      Remove(todoheap,1);       # only remove after it is added to G
                # XXX this removing might be expensive for large todo lists,
                # it might be worthwhile to implement todo as a 3-tree

      lG:=lG+1;

      # update the tree
      GBNP.AddMonToTreePTSLR(ltspoly,-1,OT.GL,true);
      GBNP.AddMonToTreePTSLR(ltspoly,-1,OT.GR,false);
      #GBNP.RemoveMonFromTreePTSLR(ltspoly,1,OT.todoL,true);

# Fase IIIb, update todo

      GBNP.ObsTall(lG,G,todoheap,OT,funcs); # jwk - tree variant of GBNP.Obs, no sorting needed here

# Fase IIIc, reduce the list G with the new polynomial 'spoly'

      if not IsBound(funcs.SkipIIIc) then

        i:=1;
        l:=lG;
        while i < l do
          h := G[i];
              b:=IsSubsetBlist(Gset[i],sltspoly) and
                  GBNP.Occur(ltspoly,h[1][1]) > 0;
          if b=true then # -jwk check for set
              RemoveElmList(G,i);
              RemoveElmList(Gset,i);
              GBNP.RemoveMonFromTreePTSLR(h[1][1],i,OT.GL,true);
              GBNP.RemoveMonFromTreePTSLR(h[1][1],i,OT.GR,false);

              spo:=GBNP.StrongNormalForm2Tall(h,G,todoheap!.list,OT,funcs);
              # XXX uses todo XXX
              if spo = [[],[]] then
                  lG:=lG-1;
              else
                  Add(G,MkMonicNP(spo));
                  Add(Gset,BlistList(genlist,Set(spo[1][1])));
                  GBNP.AddMonToTreePTSLR(spo[1][1],-1,OT.GL,true);
                  GBNP.AddMonToTreePTSLR(spo[1][1],-1,OT.GR,false);

                  funcs.CentralT(lG,G,todoheap,OT,funcs); # - jwk use tree variant
                  GBNP.ObsTall(lG,G,todoheap,OT,funcs); # - jwk use tree variant, no sorting needed here
              fi;
              l:=l-1;
          else
              i:=i+1;
          fi;
        od;
      fi;

      Info(InfoGBNP,2,"length of G =",lG);

# Fase IIId, reducing todo with respect to 'spoly'

      l:=Length(todoheap);
      i:=1;
      while i <= l do
          h := todoheap[i];
          # b is true if h can be reduced
          # first check G
          b:= GBNP.OccurInLstT(h[1][1],OT.GL)[1] +
          # then check todo
              GBNP.Find3Dnum(
                  GBNP.LookUpOccurTreeAllLstPTSLR(h[1][1],OT.todoL,true), i
              )[1] > 0;
          if b=true then # -jwk check for set
              #Remove(todoheap,i);
              #GBNP.RemoveMonFromTreePTSLR(h[1][1],i,OT.todoL,true);
              spo:=GBNP.StrongNormalForm3Dall(h,G,todoheap,OT,funcs,i);
              if spo<>[[],[]] then
                  Replace(todoheap,i,MkMonicNP(spo));
                  # allowed because: replacing an element in the todo heap with
                  # a smaller element does not effect elements with a higher
                  # index (but may change parent-nodes of the element that was
                  # changed, which have a smaller index)

                  #GBNP.AddMonToTreePTSLR(spo[1][1],i,OT.todoL,true);
                  i:=i+1;
              else
                  l:=l-1;
                  Remove(todoheap,i);
              fi;
          else
              i:=i+1;
          fi;
      od;
      Info(InfoGBNP,2,"length of todo is ",l);
      Info(InfoGBNP,4,"elements are\n",todoheap!.list);
      Add(count,l);

      if (GBNP.cleancount > 0) and (Length(count) mod GBNP.cleancount = 0) then
        GBNP.cleanpolys:=true;
      fi;

      if IsBound(GBNP.cleanpolys) then
        Unbind(GBNP.cleanpolys);
        GBNP.ReducePolTailsPTS(G,todoheap,OT,funcs);
      fi;

      if IsBound(GBNP.GetOptions().CheckQA) then
        Info(InfoGBNP,1,"size QA (max ",GBNP.GetOptions().CheckQA,")",
                GBNP.NondivMonsPTSenum(LMonsNP(G),LMonsNP(todoheap),
                        GBNP.GetOptions().Alphabetsize,0,
                        GBNP.GetOptions().CheckQA
                )
        );
      fi;
      # sort here: possibly cheaper XXX

      if IsBound(funcs.maxiterations) then
        if iterations >= funcs.maxiterations then
          return rec(G:=G, todo:=todoheap!.list, completed:=false,
            iterations:=iterations
          );
        fi;
      fi;
    od;
    Info(InfoGBNP,2,"List of todo lengths is ",count);
    return rec(G:=G, todo:=[], completed:=true, iterations:=iterations);
end;


#########################
### GBNP.SGrobnerLoop ###
#########################
###
### Loop function for Strong Gröbner basis
### When the input (G,todo) is a partial Gröbner pair, the output will be a
### Gröbner basis.
###
### Arguments:
### - G     a basis of the ideal I
### - todo  a basic set of G belonging to I and in strong normal form wrt G
###
### Returns:
### - a strong Gröbnerbasis of I
###
### #GBNP.SGrobnerLoop uses: GBNP.SGrobnerLoops#
### #GBNP.SGrobnerLoop is used in:#
###

GBNP.SGrobnerLoop:=function(G,todo)
        GBNP.SGrobnerLoops(G,todo,GBNP.SGrobnerLoopRec);
end;

########################
### GBNP.GrobnerLoop ###
########################
###
### Loop function for Strong Gröbner basis
### When the input (G,todo) is a partial Gröbner pair, the output will be a
### Gröbner basis.
###
### Arguments:
### - G     a basis of the ideal I
### - todo  a basic set of G belonging to I and in strong normal form wrt G
###
### Returns:
###   a Gröbner basis of I
###
### #GBNP.GrobnerLoop uses: GBNP.SGrobnerLoops#
### #GBNP.GrobnerLoop is used in:#

GBNP.GrobnerLoop:=function(G,todo)
        GBNP.SGrobnerLoops(G,todo,GBNP.GrobnerLoopRec);
end;

##############################
### GBNP.SGrobnerTruncLoop ###
##############################
###
### Loop function for a truncated Gröbner basis
### When the input (G,todo) is a partial Gröbner pair, the output will be a
### truncated Gröbner basis, with respect to the list of weights wtv and the
### number of generators k.
###
### Arguments:
### - G     a basis of the ideal I
### - todo  a basic set of G belonging to I and in strong normal form wrt G
### - wtv   a list of weights
### - k     the number of generators
###
### Returns:
###   a Gröbner basis of I
###
### #GBNP.SGrobnerTruncLoop uses: GBNP.SGrobnerLoops#
### #GBNP.SGrobnerTruncLoop is used in: GBNP.SGrobnerTruncLevel#


GBNP.SGrobnerTruncLoop:=function(G,todo,wtv,k)
local r;
        r:=ShallowCopy(GBNP.SGrobnerTruncLoopRec);

        r.k:=k;
        r.wtv:=wtv;
        r.trunc:=true;

        GBNP.SGrobnerLoops(G,todo,r);
end;

# following function not used yet

###########################
### GBNP.GrobnerLoopAll ###
###########################
###
### Grobner loop entry based on options record
### When the input (G,todo) is a partial Gröbner pair, the output will be a
### Gröbner basis.
###
### *not used yet*
###
### Arguments:
### - G     a basis of the ideal I
### - todo  a basic set of G belonging to I and in strong normal form wrt G
### - options record used to choose the right variant
###
### Returns:
### - a strong Gröbnerbasis of I corresponding to the options chosen
###
### #GBNP.GrobnerLoopAll uses: GBNP.SGrobnerLoops#
### #GBNP.GrobnerLoopAll is used in:#

GBNP.GrobnerLoopAll:=function(G,todo,options)
local o,r;
        r:=ShallowCopy(GBNP.SGrobnerLoopRec);
        for o in options do
                if o.name="trunc" then
                        r.k             :=      o.k;
                        r.wtv           :=      o.wtv;
                        r.SkipIIIc      :=      true;
                        r.trunc         :=      true;
                elif o.name="strong" then
                        r.strong        :=      true;
                elif o.name="normal" then
                        r.strong        :=      false;
                elif o.name="trace" then
                        r.trace         :=      true;
                fi;
        od;
        GBNP.SGrobnerLoops(G,todo,r);
end;

# some records

GBNP.GrobnerLoopRec:=rec(
        strong          :=      false,
        CentralT        :=      GBNP.CentralT,
);
GBNP.SGrobnerLoopRec:=rec(
        strong          :=      true,
        CentralT        :=      GBNP.CentralT,
);
GBNP.SGrobnerTruncLoopRec:=rec(
        strong          :=      true,
        SkipIIIC        :=      true,
        CentralT        :=      GBNP.CentralT,
        trunc           :=      true
);
GBNP.SGrobnerLoopPTSRec:=rec(
        strong          :=      true,
        CentralT        :=      GBNP.CentralT,
        PTS             :=      true
);

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
### #GBNP.SGrobnerTraceLoop uses: GBNP.CentralTrace GBNP.MkMonicNPTrace GBNP.ObsTrace GBNP.StrongNormalFormTrace2#
### #GBNP.SGrobnerTraceLoop is used in: SGrobnerTrace#
###

GBNP.SGrobnerTraceLoop:=function(G,todo) local i,j,count,ltspoly,spoly,spo,temp,lt;

    j:=Length(G);
    count:=[Length(todo)];
    while todo <> [] do

# Fase IIIa, Take the first element 'spoly' of todo and add it to 'G'
# - Take the first element of the todo list and remove it from todo
# - Add this to the basis

      temp:=StructuralCopy(todo[1]);
      todo:=todo{[2..Length(todo)]};
      ltspoly := temp.pol[1][1];

      Add(G,temp);
      j:=j+1;


# Fase IIIb, update todo

      GBNP.ObsTrace(j,G,todo);


# Fase IIIc, reduce the set G with the new polynomial 'term.pol'


      i:=1;
      lt:=j;
      while i < lt do
        if PositionSublist(G[i].pol[1][1],ltspoly) <> fail
        then
           spo:= StructuralCopy(G[i]);
               RemoveElmList(G,i);
               spo:=GBNP.StrongNormalFormTrace2(spo,G,todo);
               if spo.pol=[[],[]]
                   then
                     j:=j-1;
                   else
                     spo:=GBNP.MkMonicNPTrace(spo);
                     Add(G,StructuralCopy(spo));
                     GBNP.CentralTrace(j,G,todo);
                     GBNP.ObsTrace(j,G,todo);
             fi;
             lt:=lt-1;
                     else
         i:=i+1;
        fi;
      od;
      Info(InfoGBNP,2,"j =",j);


# Fase IIId, reducing todo with respect to 'ter,.pol'

      lt:=Length(todo);
      i:=1;
      while i <= lt do
        if PositionSublist(todo[i].pol[1][1],ltspoly) <> fail
           then
                spo:=StructuralCopy(todo[i]);
                RemoveElmList(todo,i);
                spo :=GBNP.StrongNormalFormTrace2(spo,G,todo);
               if spo.pol=[[],[]]
                   then
                        lt:=lt-1;
                   else
                        spo:=GBNP.MkMonicNPTrace(spo);
                        InsertElmList(todo,i,StructuralCopy(spo));
                        i:=i+1;
                fi;
           else
                i:=i+1;
        fi;
      od;
      Info(InfoGBNP,2,"Current number of elements in todo is ",lt);
      Add(count,lt);
    od;
    Info(InfoGBNP,1,"List of todo lengths is ",count);
end;;


##################
### GBNP.ObsTall
### - Finding all self, left and right obstructions of u, leading term of G[j],
### w.r.t. the list of leading terms of G.
### - uses lterm-sets
###
### Assumptions:
### - Central obstructions are already done, so only self, left and right.
###
### Arguments:
### j           - index of a non-commutative polynomial in G
### G           - list of non-commutative polynomials
### lst         - list of S-polynomials (todo)
###
### Returns:
### todo        - new list of S-polynomials. S-polynomials with G[j] added
###
### #GBNP.ObsTall uses: GBNP.AddMonToTreePTSLR GBNP.LeftObsT GBNP.RightObsT GBNP.SortParallelOT GBNP.Spoly GBNP.StrongNormalForm2Tall GBNP.WeightedDegreeMon LMonsNP MkMonicNP#
### #GBNP.ObsTall is used in: GBNP.AllObs GBNP.SGrobnerLoops#
###

GBNP.ObsTall:=function(j,G,todo,OT,funcs)
local R,sob,ob,temp,temp2,obs,spo,added;
   R:=LMonsNP(G);
   if IsBound(OT.pGL) then
        # generating all obstructions: use only a partial tree to generate
        # obstructions
        temp:=GBNP.LeftObsT(j,R,OT.pGL);
   else
        temp:=GBNP.LeftObsT(j,R,OT.GL);
   fi;
   if IsBound(OT.pGR) then
        # generating all obstructions: use only a partial tree to generate
        # obstructions
        temp2:=GBNP.RightObsT(j,R,OT.pGR);
   else
        temp2:=GBNP.RightObsT(j,R,OT.GR);
   fi;
        # self obstructions should be both a non-reducible left
        # obstruction and a non-reducible right obstruction. If either
        # is reducible it can be removed. The following code will only
        # leave one if both temp and temp2 contain a selfobstruction
   if temp.sobnr<>0 then
       RemoveElmList(temp.obs,temp.sobnr);
   elif temp2.sobnr<>0 then
       RemoveElmList(temp2.obs,temp2.sobnr);
   fi;
   obs:=Concatenation(temp.obs,temp2.obs);

   added:=0;
   Info(InfoGBNP,5,"ObsTall(",j,"): obs: ",obs);
   for ob in obs do
     if IsBound(funcs.trunc) then
         temp := GBNP.WeightedDegreeMon(ob[1],funcs.wtv);
         temp := temp + GBNP.WeightedDegreeMon(R[ob[2]],funcs.wtv);
         temp := temp + GBNP.WeightedDegreeMon(ob[3],funcs.wtv);
     fi;
     # temp:=GBNP.WeightedDegreeMon(Concatenation(ob[1],R[ob[2]],ob[3]),wtv);
     if (not IsBound(funcs.trunc)) or (temp=funcs.k) then
       spo:=GBNP.Spoly(ob,G);
       if spo <> [[],[]] then
                if IsTHeapOT(todo) then
                   spo:=GBNP.StrongNormalForm2Tall(spo,G,todo!.list,OT,funcs);
                else
                   spo:=GBNP.StrongNormalForm2Tall(spo,G,todo,OT,funcs);
                fi;
           if spo <> [[],[]] then
               Add(todo,MkMonicNP(spo));
               if not IsTHeapOT(todo) then
                   GBNP.AddMonToTreePTSLR(spo[1][1],-1,OT.todoL,true); # also add it to the tree for
               fi;
               added:=added+1;
           fi;
       fi;
     fi;
   od;
   if not IsTHeapOT(todo) then
        temp:=LMonsNP(todo);
        temp2:=StructuralCopy(temp);
        SortParallel(temp,todo,LtNP);
        GBNP.SortParallelOT(temp2,OT.todoL,LtNP);
   fi;
   Info(InfoGBNP,3,"ObsTall(",j,"): ",added,"/",Length(obs)," new obstructions added");
end;;

#################################
### GBNP.StrongNormalFormTall ###
#################################
###
###
###
### Arguments:
### - f         non commutative polynomial
### - G         a list of non-commutative polynomials
### - GLOT      an left occur tree of G
### - funcs     an info record
###
### Returns:
### pol         - strong normalform of f w.r.t. G
###
### #GBNP.StrongNormalFormTall uses: GBNP.CreateOccurTreePTSLR GBNP.StrongNormalForm2Tall#
### #GBNP.StrongNormalFormTall is used in: GBNP.AllObs GBNP.IsGrobnerBasisTest IsGrobnerPair MakeGrobnerPair#
###

GBNP.StrongNormalFormTall:=function(f,G,GLOT,funcs)

        if f=[[],[]] then return f;
        else
                return GBNP.StrongNormalForm2Tall(f,G,[],rec(GL:=GLOT,
                        todoL:=GBNP.CreateOccurTreePTSLR([],funcs.pg,true)),
                        funcs);
        fi;
end;


###################
### GBNP.StrongNormalForm2Tall
### - Computes the strong normal form of a non-commutative polynomial
### - occur trees
###
### Assumptions:
### -  monomials of each polynomial are ordered. (highest degree first)
### -  polynomials in G union G2 are monic and clean.
### -  polynomial f is clean.
### -  polynomial f is not empty (that is, f <> [[],[]]).
###
### Arguments:
### f           - a non-commutative polynomial
### G           - list of non-commutative polynomials
### G2          - list of non-commutative polynomials
### Gset        - list of the leading term-sets
### G2set       - list of the leading term-sets
###
### Returns:
### pol         - strong normalform of f w.r.t. G
###
### #GBNP.StrongNormalForm2Tall uses: AddNP BimulNP GBNP.OccurInLstT GBNP.ReduceCancellation#
### #GBNP.StrongNormalForm2Tall is used in: GBNP.CentralT GBNP.ObsTall GBNP.SGrobnerLoops GBNP.StrongNormalFormTall IsGrobnerPair MakeGrobnerPair#
###

GBNP.StrongNormalForm2Tall:=function(f,G,G2,OT,funcs)
    local g,h,i1,i2,j,l,dr,ga,tt,lth,iid;
    tt:=Runtime();
    h:=StructuralCopy(f);
    iid := 1;
    repeat # iid <= Length(h[i]) since h=f is nonempty
      lth:=h[1][iid];
      i1:=GBNP.OccurInLstT(lth,OT.GL);
      i2:=GBNP.OccurInLstT(lth,OT.todoL);
      while i1[1]+i2[1]>0 do
            if i1[1]>0 then
                g:=G[i1[1]];
                ga:=lth{[1..i1[2]-1]};
                dr:=lth{[i1[2]+Length(g[1][1])..Length(lth)]};
                h:=AddNP(h,BimulNP(ga,g,dr),One(g[2][1]),-h[2][iid]/g[2][1]);
                if h=[[],[]] then return(h);  fi;
                if iid <= Length(h[1]) then
                   lth := h[1][iid];
                   i1:=GBNP.OccurInLstT(lth,OT.GL);
                   i2:=GBNP.OccurInLstT(lth,OT.todoL);
                else
                   return(GBNP.ReduceCancellation(h));
                fi;
            elif i2[1]>0 then
                g:=G2[i2[1]];
                ga:=lth{[1..i2[2]-1]};
                dr:=lth{[i2[2]+Length(g[1][1])..Length(lth)]};
                h:=AddNP(h,BimulNP(ga,g,dr),One(g[2][1]),-h[2][iid]/g[2][1]);
                if h=[[],[]] then return(h);  fi;
                if iid <= Length(h[1]) then
                   lth := h[1][iid];
                   i1:=GBNP.OccurInLstT(lth,OT.GL);
                   i2:=GBNP.OccurInLstT(lth,OT.todoL);
                else
                   return(GBNP.ReduceCancellation(h));
                fi;
            fi;
       od;
       iid := iid+1;
    until not (IsBound(funcs.strong) and iid <= Length(h[1]));
    # while (IsBound(funcs.strong) and iid <= Length(h[1]));

    return(GBNP.ReduceCancellation(h));
end;;

###################
### GBNP.StrongNormalForm3DAll
### - Computes the strong normal form of a non-commutative polynomial
### - occur trees
###
### Assumptions:
### -  monomials of each polynomial are ordered. (highest degree first)
### -  polynomials in G union G2 are monic and clean.
### -  polynomial f is clean.
### -  polynomial f is not empty (that is, f <> [[],[]]).
###
### Arguments:
### f           - a non-commutative polynomial
### G           - list of non-commutative polynomials
### G2          - list of non-commutative polynomials
### OT          - record with occur trees
### j           - item of G2 not to skip
###
### Returns:
### pol         - strong normalform of f w.r.t. G
###
### #GBNP.StrongNormalForm2Tall uses: AddNP BimulNP GBNP.OccurInLstT GBNP.ReduceCancellation#
### #GBNP.StrongNormalForm2Tall is used in: GBNP.CentralT GBNP.ObsTall GBNP.SGrobnerLoops GBNP.StrongNormalFormTall IsGrobnerPair MakeGrobnerPair#
###

GBNP.StrongNormalForm3Dall:=function(f,G,G2,OT,funcs,skip)
    local g,h,i1,i2,j,l,dr,ga,tt,lth,iid;
    tt:=Runtime();
    h:=StructuralCopy(f);
    iid := 1;
    repeat # iid <= Length(h[i]) since h=f is nonempty
      lth:=h[1][iid];
      i1:=GBNP.OccurInLstT(lth,OT.GL);
      i2:=GBNP.LookUpOccurTreeAllLstPTSLR(lth,OT.todoL,true);
      i2:=GBNP.Find3Dnum(i2,skip);
      while i1[1]+i2[1]>0 do
            if i1[1]>0 then
                g:=G[i1[1]];
                ga:=lth{[1..i1[2]-1]};
                dr:=lth{[i1[2]+Length(g[1][1])..Length(lth)]};
                h:=AddNP(h,BimulNP(ga,g,dr),One(g[2][1]),-h[2][iid]/g[2][1]);
                if h=[[],[]] then return(h);  fi;
                if iid <= Length(h[1]) then
                   lth := h[1][iid];
                   i1:=GBNP.OccurInLstT(lth,OT.GL);
                   i2:=GBNP.LookUpOccurTreeAllLstPTSLR(lth,OT.todoL,true);
                   i2:=GBNP.Find3Dnum(i2,skip);
                else
                   return(GBNP.ReduceCancellation(h));
                fi;
            elif i2[1]>0 then
                g:=G2[i2[1]];
                ga:=lth{[1..i2[2]-1]};
                dr:=lth{[i2[2]+Length(g[1][1])..Length(lth)]};
                h:=AddNP(h,BimulNP(ga,g,dr),One(g[2][1]),-h[2][iid]/g[2][1]);
                if h=[[],[]] then return(h);  fi;
                if iid <= Length(h[1]) then
                   lth := h[1][iid];
                   i1:=GBNP.OccurInLstT(lth,OT.GL);
                   i2:=GBNP.LookUpOccurTreeAllLstPTSLR(lth,OT.todoL,true);
                   i2:=GBNP.Find3Dnum(i2,skip);
                else
                   return(GBNP.ReduceCancellation(h));
                fi;
            fi;
       od;
       iid := iid+1;
    until not (IsBound(funcs.strong) and iid <= Length(h[1]));
    # while (IsBound(funcs.strong) and iid <= Length(h[1]));

    return(GBNP.ReduceCancellation(h));
end;;

###################
### GBNP.StrongNormalForm2TSall
### - Computes the strong normal form of a non-commutative polynomial
### - occur trees
### - special case G[j] reduced by the rest
###
### Assumptions:
### -  monomials of each polynomial are ordered. (highest degree first)
### -  polynomials in G union G2 are monic and clean.
### -  polynomial f is clean.
### -  polynomial f is not empty (that is, f <> [[],[]]).
###
### Arguments:
### f           - a non-commutative polynomial
### G           - list of non-commutative polynomials
### G2          - list of non-commutative polynomials
### Gset        - list of the leading term-sets
### G2set       - list of the leading term-sets
###
### Returns:
### pol         - strong normalform of f w.r.t. G
###
### #GBNP.StrongNormalForm2TSPTS uses: AddNP BimulNP GBNP.LookUpOccurTreeAllLstPTSLR#
### #GBNP.StrongNormalForm2TSPTS is used in: GBNP.ReducePolTailsPTS#
###

GBNP.StrongNormalForm2TSPTS:=function(G,j,GLOT,prefix)
    local g,h,il,i1,l,dr,ga,lth,iid;

    h:=StructuralCopy(G[j]);
    iid := 1;
    while iid <= Length(h[1]) do
      lth:=h[1][iid];
      if prefix then
          il:=GBNP.LookUpOccurTreeAllLstPTSLRPos(lth,GLOT,true,1);
      else
          il:=GBNP.LookUpOccurTreeAllLstPTSLR(lth,GLOT,true);
      fi;
      il:=Filtered(il,x->x[1]<>j);
      while il<>[] do
           i1:=il[1];
           g:=G[i1[1]];
           ga:=lth{[1..i1[2]-1]};
           dr:=lth{[i1[2]+Length(g[1][1])..Length(lth)]};
           h:=AddNP(h,BimulNP(ga,g,dr),One(g[2][1]),-h[2][iid]/g[2][1]);
           if h=[[],[]] then return(h);  fi;
           if iid <= Length(h[1]) then
                lth := h[1][iid];
                if prefix then
                    il:=GBNP.LookUpOccurTreeAllLstPTSLRPos(lth,GLOT,true,1);
                else
                    il:=GBNP.LookUpOccurTreeAllLstPTSLR(lth,GLOT,true);
                fi;
                il:=Filtered(il,x->x[1]<>j);
           else
                return(h);
           fi;
       od;
       iid := iid+1;
    od;
    return(h);
end;;

###########################
### GBNP.ReducePolTails ###
###########################
###
###
###
### Arguments:
### - G
### - todo
### - OT
### - funcs
###
### Returns:
###
### #GBNP.ReducePolTails uses: GBNP.StrongNormalForm2TS#
### #GBNP.ReducePolTails is used in: SGrobner#
###

GBNP.ReducePolTails:=function(G,todo,GLOT)
local   i,
        newg,
        count,
        tt,
        OT2;

        tt:=Runtime();
        count:=0;

        for i in [1..Length(G)] do

#       directly assigning to G[i] is faster, but doesn't allow statistics
                newg:=GBNP.StrongNormalForm2TS(G,i,GLOT);
                #
                if (newg<>G[i]) then count:=count+1; fi;
                G[i]:=newg;
        od;

        Info(InfoGBNP,2,"G: Cleaning finished, ", count, " polynomials reduced");

        Info(InfoGBNPTime,2,"Time needed to clean G :", Runtime()-tt);
end;

##############################
### GBNP.ReducePolTailsPTS ###
##############################
###
###
###
### Arguments:
### - G
### - todo
### - OT
### - funcs
###
### Returns:
###
### #GBNP.ReducePolTailsPTS uses: GBNP.StrongNormalForm2TSPTS#
### #GBNP.ReducePolTailsPTS is used in: GBNP.SGrobnerLoops#
###

GBNP.ReducePolTailsPTS:=function(G,todo,OT,funcs)
local   i,
        newg,
        count,
        tt,
        OT2;

        tt:=Runtime();
        count:=0;

        for i in [1..Length(G)] do

#       directly assigning to G[i] is faster, but doesn't allow statistics
                newg:=GBNP.StrongNormalForm2TSPTS(G,i,OT.GL,
                                IsBound(funcs.PTS));
                #
                if (newg<>G[i]) then count:=count+1; fi;
                G[i]:=newg;
        od;

        Info(InfoGBNP,2,"G: Cleaning finished, ", count, " polynomials reduced");

        Info(InfoGBNPTime,2,"Time needed to clean G :", Runtime()-tt);
end;


###############################
### GBNP.ReduceCancellation ###
###############################
###
###
###
### Arguments:
### - pol
###
### #GBNP.ReduceCancellation uses: GBNP.GetOptions#
### #GBNP.ReduceCancellation is used in: GBNP.ReducePol2 GBNP.StrongNormalForm2Tall GBNP.StrongNormalForm3Dall#

GBNP.ReduceCancellation:=function(pol)
local   nummon, # the number of monomials in pol
        bound,  # boolean, true if all monomials are longer than 1
        same,   # boolean, true if all checked symbols are the same
        i,j,    # counters
        sym,    # symbol to check (generator that is first or last in the lt)
        lenmin, # minimum length (if 0 -> no further cancellation possible)
        n,      # alphabetsize how to get this ?
        pre,
        post,
        new;

        if not IsBound(GBNP.GetOptions().CancellativeMonoid) then
                return pol;
        fi;

        n := GBNP.GetOptions().Alphabetsize;

        nummon := Length(pol[1]);
        if nummon < 2 then
                return pol; # cancellation only if there are at least 2 words
        fi;

        # calculate min len
        lenmin:=Minimum(List(pol[1],x->Length(x)));

        same:=true;
        while lenmin>0 and same do
                sym:=pol[1][1][Length(pol[1][1])];
                if sym<0 then           # prefix generator (do not cancel now)
                        same:=false;    # XXX prefix not cancelled
                fi;
                i:=2;
                while i<=nummon and same do
                        same:=same and pol[1][i][Length(pol[1][i])]=sym;
                        i:=i+1;
                od;

                if same then
                        for i in [1..nummon] do
                                RemoveElmList(pol[1][i],Length(pol[1][i]));
                        od;
                        lenmin:=lenmin-1;
                fi;
        od;

        same:=true;
        while lenmin>0 and same=true do
                sym:=pol[1][1][1];
                if sym<0 then           # prefix generator (do not cancel now)
                        same:=false;    # XXX prefix not cancelled
                fi;
                i:=2;
                while i<=nummon and same do
                        same:=same and pol[1][i][1]=sym;
                        i:=i+1;
                od;
                if same then
                        for i in [1..nummon] do
                                RemoveElmList(pol[1][i],1);
                        od;
                        lenmin:=lenmin-1;
                fi;
        od;

        return pol;
end;

######################
### GBNP.Find3Dnum ###
######################
###
###
###
### Arguments:
### - l
### -  skip
###
### Returns:
###
### #GBNP.Find3Dnum uses:#
### #GBNP.Find3Dnum used in:#
###

GBNP.Find3Dnum:=function(l, skip)
local   i,
        ans;
                ans:=[0,0];
        for i in l do
                if i[1]<>skip then
                        if ans[1]=0 or ans[1]>l[1] then
                                ans:=i;
                        fi;
                fi;
        od;
        return ans;
end;
