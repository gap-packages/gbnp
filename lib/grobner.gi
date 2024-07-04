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

### filename = "grobner.gi"
### authors Cohen & Gijsbers
### vs 0.9

### THIS IS PART OF A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES

#functions defined in this file:
#GBNP.RightOccur:=function(u,v)
#GBNP.LeftOccur:=function(u,v)
#GBNP.Occur:=function(u,v)
#GBNP.RightOccurInLst:=function(u,Rlst)
#GBNP.OccurInLst:=function(u,Rlst)
#GBNP.SelfObs:=function(j,R)
#GBNP.LeftObs:=function(j,R,sob)
#GBNP.RightObs:=function(j,R,sob)
#GBNP.Spoly:=function(l,G)
#GBNP.NormalForm2:=function(f,G,G2)
#GBNP.NormalForm:=function(f,G)
#GBNP.StrongNormalForm2:=function(f,G,G2)
#StrongNormalFormNP:=function(f,G)
#GBNP.ReducePol2:=function(arg) function(G, GLOT (optional) )
#  warning ReducePol2 not optimized for trees yet
#GBNP.ReducePol:=function(B)
#GBNP.AllObs:=function(G)
#Grobner:=function(KI)
#SGrobner:=function(KI)
#BaseQA := function(G,t,maxno)
#DimQA := function(G,n)
#MulQA := function(p1,p2,G)
#GBNP.StrongNormalForm2TS:=function(G,j,GLOT)
#GBNP.NormalForm2T:=function(f,G,G2,GLOT,G2LOT)
#GBNP.CentralT:=function(j,G,todo,OT,funcs)
#GBNP.LeftObsT:=function(j,R,GLOT)
#GBNP.RightObsT:=function(j,R,GLOT)
#IsGrobnerBasis:=function(G)
#IsStrongGrobnerBasis:=function(G)
#GBNP.IsGrobnerBasisTest:=function(G, strong)
#IsGrobnerPair:=function(G,D)
#GBNP.MakeGrobnerPairMakeMonic:=function(G)
#MakeGrobnerPair:=function(G,D)
#StrongNormalFormNPM:=function(v,GR)
#SGrobnerModule:=function(KI_p,KI_ts)
#MulQM:=function(p1,p2,GBR)
#BaseQM:=function(GBR,t,maxno)
#DimQM:=function(GBR,n,mn)

##################
### GBNP.RightOccur
### - Checks whether v=t.u
### returns 0 if there is no such t
### returns the start of u in v if there is such a t
###
### Arguments:
### u,v     - two monomials
###
### Returns:
### i         - position in v where the monomial u starts
### 0         - the monomial u is not contained in v
###
### #GBNP.RightOccur uses: LtNP#
### #GBNP.RightOccur is used in: GBNP.RightOccurInLst#
###

GBNP.RightOccur:=function(u,v) local lu,lv;
    if u = v then
        return 1;
    fi;
    if LtNP(u,v) then
        lu:=Length(u);
        lv:=Length(v);
        if v{[lv-lu+1..lv]}=u then
            return(lv-lu+1);
        fi;
    fi;
    return(0);
end;;

##################
### GBNP.LeftOccur
###
### - Checks whether v=u.t
### returns 0 if there is no such t
### returns 1 if there is such a t
###
### Arguments:
### u,v     - two monomials
###
### Returns:
### 1         - if u occurs at the left of v
### 0         - the monomial u is not contained in v
###
### #GBNP.LeftOccur uses: LtNP#
### #GBNP.LeftOccur is used in: GBNP.LeftObs GBNP.RightObs#
###

GBNP.LeftOccur:=function(u,v)
    local lu;
    if u = v then
        return 1;
    fi;
    if LtNP(u,v) then
        lu:=Length(u);
        if v{[1..lu]}=u then
            return(1);
        fi;
    fi;
    return(0);
end;;

##################
### GBNP.Occur
### - Searches one occurrence of a word u in a word v,
### that is, finding the first position in v where a word u starts,
### returns 0 if there is none
### returns 1 if u = [], the empty word
###
### Arguments:
### u,v     - two monomials
###
### Returns:
### i         - position in v where the monomial u starts
### 0         - the monomial u is not contained in v
###
### #GBNP.Occur uses: LtNP#
### #GBNP.Occur is used in: FinCheckQA GBNP.CentralT GBNP.CentralTrace GBNP.OccurInLst GBNP.ReducePol2 GBNP.ReducePolTrace2 GBNP.SGrobnerLoops#
###

GBNP.Occur:=function(u,v)
    local i,lu,p;
    if u = v then
        return 1;
    fi;
    if LtNP(u,v) then
        lu:=Length(u);
        for i in [1..Length(v)-lu+1] do
            if v{[i..lu+i-1]}=u then
                return(i);
            fi;
        od;
#    p:=PositionSublist(v,u);
#    if p<>fail then
#        return p;
#    fi;
    fi;
    return(0);
end;

##################
### GBNP.RightOccurInLst
### - Finding the first index i such that the monomial R[i]
### in the list R is a solution to t.R[i]=u.
###
### Arguments:
### u         - monomial
### Rlst    - list of monomials
###
### Returns:
### [i,j]    - the monomial R[i] is the first monomial in R dividing u and
###          is thus contained in u, starting at position j
### [0,0]    - no monomial of R divides the monomial u
###
### #GBNP.RightOccurInLst uses: GBNP.RightOccur#
### #GBNP.RightOccurInLst is used in:#
###

GBNP.RightOccurInLst:=function(u,Rlst)
    local i,j,lr;
    i := 0;
    lr := Length(Rlst);
    while i < lr do
        i := i+1;
        j:= GBNP.RightOccur(Rlst[i],u);
        if j>0 then return([i,j]); fi;
    od;
    return([0,0]);
end;;

##################
### GBNP.OccurInLst
### - Finding the first index i such that the monomial R[i]
### in the list R divides the given monomial u.
###
### Arguments:
### u         - monomial
### Rlst    - list of monomials
###
### Returns:
### [i,j]    - the monomial R[i] is the first monomial in R dividing u and
###          is thus contained in u, starting at position j
### [0,0]    - no monomial of R divides the monomial u
###
### #GBNP.OccurInLst uses: GBNP.Occur#
### #GBNP.OccurInLst is used in: GBNP.MakeArgumentLevel GBNP.NondivMonsByLevel GBNP.NondivMonsPTS GBNP.NondivMonsPTSenum GBNP.NormalForm2 GBNP.StrongNormalForm2 GBNP.StrongNormalFormTrace2#
###

GBNP.OccurInLst:=function(u,Rlst) local i,j,lr;
    i := 0;
    lr := Length(Rlst);
    while i < lr do
        i := i+1;
        j:= GBNP.Occur(Rlst[i],u);
        #j:= PositionSublist(u,Rlst[i]);
        if j>0 then
            return [i,j];
        fi;
        #if j<>fail then return([i,j]); fi;
    od;
    return([0,0]);
end;;

#################
### GBNP.SelfObs
### - Searches for a non-empty self-obstruction of the monomial R[j]
### in a set of leading terms R={T(g_1),...,T(g_t)}. For u = R[j],
### search one decomposition au = ub; then s = [[],j,b,a,j,[]].
### Only the one with the smallest a and b is needed, see ****.
###
### Arguments:
### j         - index of the monomial for which we search a self-obs.
### R        - list of monomials (in the application: leading terms)
###
### Returns:
### [[[],j,b,a,j,[]]]    - the self obstruction with smallest a and b
### []            - if R[j] has no self obstructions
###
####Note: ***same form as left obs***
### #GBNP.SelfObs uses:#
### #GBNP.SelfObs is used in: GBNP.ObsTrace GBNP.ObsTrunc#
###

GBNP.SelfObs:=function(j,R)
    local i,u,lu;
    u:=R[j];
    lu:=Length(u);
    for i in [1..lu-1] do
        if u{[1..lu-i]}=u{[i+1..lu]} then
            return([[[],j,u{[lu-i+1..lu]},u{[1..i]},j,[]]]);
        fi;
    od;
    return([]);
end;;

#################
### GBNP.LeftObs
### - Searches "left" obstructions of a monomial u w.r.t. monomials in R.
### Because "left" and "right" obstructions are symmetric,
### we only search for i<j.
### All redundant obstructions are removed. For efficiency reasons, the
### self obstruction of R[j] (if present) is taken into account.
###
### Arguments:
### j         - index of the monomial for which we search left-obs.
### R        - set of leading terms (monomials)
### sob        - 'smallest' self-obstruction of R[j]
###
### Returns:
### ans        - List of found left-obstructions
###
### #GBNP.LeftObs uses: GBNP.LeftOccur#
### #GBNP.LeftObs is used in: GBNP.ObsTrace GBNP.ObsTrunc#
###

GBNP.LeftObs:=function(j,R,sob)
    local i,h,k,u,v,dr,ga,lu,lv,mi,ans,eli,flag;
    ans:=sob;
    u:=R[j];
    lu:=Length(u);
    for i in [1..j-1] do
        v:=R[i];
        lv:=Length(v);
        mi:=Minimum([lu,lv]);
        for k in [1..mi-1] do
            if u{[lu-k+1..lu]}=v{[1..k]} then
                ga:=u{[1..lu-k]};
                dr:=v{[k+1..lv]};
                flag:=true;
                eli:=[];
                for h in ans do
                    if GBNP.LeftOccur(h[3],dr)=1 then
                        flag:=false;
                        break; # saves time - jwk
                    elif GBNP.LeftOccur(dr,h[3])=1 then
                        Add(eli,h);
                    fi;
                od;
                ans:=Difference(ans,eli);
                if flag then
                    Add(ans,[[],j,dr,ga,i,[]]);
                fi;
            fi;
        od;
    od;
    return(ans);
end;;

#################
### GBNP.RightObs
### - Searches "right" obstructions  of monomial u w.r.t. monomials in R.
### Because "left" and "right" obstructions are symmetric,
### we only search for i<j.
### All redundant obstructions are removed. For efficiency, the
### self obstruction of R[j] (written as a right obstruction) is taken
### into account (if it exists).
###
### Arguments:
### j         - index of the monomial for which we search the right
###               obstructions
### R        - list of monomials (leading terms)
### sob        - 'smallest' self-obstruction of R[j]
###
### Returns:
### ans        - List of found right-obstructions (not containing sob)
###
### #GBNP.RightObs uses: GBNP.LeftOccur#
### #GBNP.RightObs is used in: GBNP.ObsTrace GBNP.ObsTrunc#
###

GBNP.RightObs:=function(j,R,sob)
    local i,h,k,u,v,dr,ga,lu,lv,mi,eli,flag, sobr, ans;
    if sob<>[] then
        sobr := [sob[1][4],sob[1][5],sob[1][6],
                 sob[1][1],sob[1][2],sob[1][3]];
        ans:=[sobr];
    else
        ans:=[];
        sobr:=[];
    fi;
    u:=R[j];
    lu:=Length(u);
    for i in [1..j-1] do
        v:=R[i];
        lv:=Length(v);
        mi:=Minimum([lu,lv]);
        for k in [1..mi-1] do
            if v{[lv-k+1..lv]}=u{[1..k]} then
                ga:=v{[1..lv-k]};
                dr:=u{[k+1..lu]};
                flag:=true;
                eli:=[];
                for h in ans do
                    if GBNP.LeftOccur(Reversed(h[1]),Reversed(ga))=1 then
                        flag:=false;
                        break; # saves time - jwk
                    elif GBNP.LeftOccur(Reversed(ga),Reversed(h[1]))=1 then
                        Append(eli,h);
                    fi;
                od;
                ans:=Difference(ans,eli);
                if flag then
                    Add(ans,[ga,j,[],[],i,dr]);
                fi;
            fi;
        od;
    od;
    return(Difference(ans,sobr));
end;;

#################
### GBNP.Spoly
### - Computes the S-polynomials in a basis G w.r.t. an obstruction l.
### Output is a cleaned polynomial
###
### Arguments:
### l         - an obstruction
### G        - list of non-commutative polynomials
###
### Returns:
### pol        - cleaned S-polynomial in the basis G w.r.t. the obstruction l
###
### #GBNP.Spoly uses: AddNP BimulNP#
### #GBNP.Spoly is used in: GBNP.CentralT GBNP.ObsTall GBNP.ObsTrunc#
###

GBNP.Spoly:=function(l,G)
    return(AddNP(BimulNP(l[1],G[l[2]],l[3]),BimulNP(l[4],G[l[5]],l[6]),
        One(G[l[2]][2][1]),-1*One(G[l[2]][2][1])));
end;;

###################
### GBNP.NormalForm2
### - Computes the normal form of a non-commutative polynomial
###   using two lists of polynomials with respect to which it rewrites

### Assumptions:
### -  polynomials in G union G2 are monic and clean.
### -  polynomial f is clean.
### -  polynomial f is not empty. (= [[],[]])
###
### Arguments:
### f         - a non-commutative polynomial
### G        - list of non-commutative polynomials
### G2        - list of non-commutative polynomials
###
### Returns:
### pol        - normal form of f w.r.t. G union G2
###
### #GBNP.NormalForm2 uses: AddNP BimulNP GBNP.OccurInLst LMonsNP#
### #GBNP.NormalForm2 is used in: GBNP.NormalForm#
###

GBNP.NormalForm2:=function(f,G,G2)
    local g,h,i,j,l,dr,ga,tt,lth,ltsG,i2,l2,ltsG2;
    tt:=Runtime();
    h:=StructuralCopy(f);
    lth:=h[1][1];
    ltsG:=LMonsNP(G);
    l:=Length(ltsG);
    ltsG2:=LMonsNP(G2);
    l2:=Length(ltsG2);
    i:=GBNP.OccurInLst(lth,ltsG);
    i2:=GBNP.OccurInLst(lth,ltsG2);
    while i[1]>0 or i2[1]>0 do
        if i[1]>0 then
            g:=G[i[1]];
            ga:=lth{[1..i[2]-1]};
            dr:=lth{[i[2]+Length(g[1][1])..Length(lth)]};
            h:=AddNP(h,BimulNP(ga,g,dr),One(h[2][1]),-h[2][1]/g[2][1]);
            if h=[[],[]] then
#                 Print("computation time of the NormalForm = ",Runtime()-tt,"\n");
                return(h);
            fi;
            lth:=h[1][1];
            i:=GBNP.OccurInLst(lth,ltsG);
            i2:=GBNP.OccurInLst(lth,ltsG2);
        else
            g:=G2[i2[1]];
            ga:=lth{[1..i2[2]-1]};
            dr:=lth{[i2[2]+Length(g[1][1])..Length(lth)]};
            h:=AddNP(h,BimulNP(ga,g,dr),One(h[2][1]),-h[2][1]/g[2][1]);
            if h=[[],[]] then
#                 Print("computation time of the NormalForm = ",Runtime()-tt,"\n");
                return(h);
            fi;
            lth:=h[1][1];
            i:=GBNP.OccurInLst(lth,ltsG);
            i2:=GBNP.OccurInLst(lth,ltsG2);
        fi;
    od;
#   Print("computation time of the NormalForm = ",Runtime()-tt,"\n");
    return(h);
end;;

###################
### GBNP.NormalForm
### - Computes the normal form of a non-commutative polynomial
###
### Assumptions:
### -  polynomials in G are monic and clean.
### -  polynomial f is clean.
###
### Arguments:
### f         - a non-commutative polynomial
### G        - list of non-commutative polynomials
###
### Returns:
### pol        - normal form of f w.r.t. G
###
### #GBNP.NormalForm uses: GBNP.NormalForm2#
### #GBNP.NormalForm is used in:#
###

GBNP.NormalForm:=function(f,G)
    if f = [[],[]] then
        return f;
    else
        return GBNP.NormalForm2(f,G,[]);
    fi;
end;;

###################
### GBNP.StrongNormalForm2
### - Computes the strong normal form of a non-commutative polynomial
###
### Assumptions:
### -  monomials of each polynomial are ordered. (highest degree first)
### -  polynomials in G union G2 are monic and clean.
### -  polynomial f is clean.
### -  polynomial f is not empty (that is, f <> [[],[]]).
###
### Arguments:
### f         - a non-commutative polynomial
### G        - list of non-commutative polynomials
### G2        - list of non-commutative polynomials
###
### Returns:
### pol        - strong normalform of f w.r.t. G
###
### #GBNP.StrongNormalForm2 uses: AddNP BimulNP GBNP.OccurInLst LMonsNP#
### #GBNP.StrongNormalForm2 is used in: GBNP.ObsTrunc StrongNormalFormNP StrongNormalFormNPM#
###

GBNP.StrongNormalForm2:=function(f,G,G2)
    local g,h,i1,j,l,dr,ga,tt,lth,iid,ltsG,i2,ltsG2,l2;
    tt:=Runtime();
    h:=StructuralCopy(f);
    ltsG:=LMonsNP(G);
    ltsG2:=LMonsNP(G2);
    iid := 1;
    while iid <= Length(h[1]) do
        lth:=h[1][iid];
        l:=Length(ltsG);
        l2:=Length(ltsG2);
        i1:=GBNP.OccurInLst(lth,ltsG);
        i2:=GBNP.OccurInLst(lth,ltsG2);
        while i1[1]+i2[1]>0 do
            if i1[1]>0 then
                g:=G[i1[1]];
                ga:=lth{[1..i1[2]-1]};
                dr:=lth{[i1[2]+Length(g[1][1])..Length(lth)]};
                h:=AddNP(h,BimulNP(ga,g,dr),One(g[2][1]),-h[2][iid]/g[2][1]);
                if h=[[],[]] then
                    return h;
                fi;
                if iid <= Length(h[1]) then
                    lth := h[1][iid];
                    i1:=GBNP.OccurInLst(lth,ltsG);
                    i2:=GBNP.OccurInLst(lth,ltsG2);
                else
                    return(h);
                fi;
            else
                g:=G2[i2[1]];
                ga:=lth{[1..i2[2]-1]};
                dr:=lth{[i2[2]+Length(g[1][1])..Length(lth)]};
                h:=AddNP(h,BimulNP(ga,g,dr),One(g[2][1]),-h[2][iid]/g[2][1]);
                if h=[[],[]] then
                    return h;
                fi;
                if iid <= Length(h[1]) then
                    lth := h[1][iid];
                    i1:=GBNP.OccurInLst(lth,ltsG);
                    i2:=GBNP.OccurInLst(lth,ltsG2);
                else
                    return(h);
                fi;
            fi;
       od;
       iid := iid+1;
    od;
Info(InfoGBNP,3, "computation time of the StrongNormalFormNP = ",Runtime()-tt);
    return(h);
end;;

###################
### StrongNormalFormNP
### <#GAPDoc Label="StrongNormalFormNP">
### <ManSection>
### <Func Name="StrongNormalFormNP" Comm="Reduce an NP polynomial with respect to a Gröbner basis." Arg="f, G" />
### <Returns>
### The strong normal form of a polynomial with respect to
### <A>G</A>
### </Returns>
### <Description>
### When invoked with a polynomial in NP format
### (see Section <Ref Sect="NP"/>)
### and a finite set <A>G</A> of polynomials in NP format, this function will
### return a strong normal form (that is, a polynomial
### that is equal to <A>f</A>
### modulo <A>G</A>, every monomial of which is a multiple of no
### leading monomial of an element of <A>G</A>).
### <P/>
### Note that the StrongNormalForm with respect to a Gröbner
### basis is uniquely determined,  but that for an arbitrary input <A>G</A>
### the result may depend on the order in which the individual reduction
### steps are implemented.
### <P/>
### <#Include Label="example-StrongNormalFormNP">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Computes a strong normal form of a polynomial in NP format
###
###
### Arguments:
### f         - a non-commutative polynomial
### G        - list of non-commutative polynomials
###
### Returns:
### pol        - a strong normalform of f with respect to G
###
### #StrongNormalFormNP uses: CleanNP GBNP.StrongNormalForm2 MkMonicNP#
### #StrongNormalFormNP is used in: MulQA#
###

InstallGlobalFunction( StrongNormalFormNP, function(f,G)
    local ih, fm, Gl, lts, lcf, hlp;
    fm := CleanNP(f);
    if fm = [[],[]] then return fm; fi;
    lcf := fm[2][1];
    fm := MkMonicNP(fm);
    Gl := [];
    lts := [];
    for ih in G do hlp := MkMonicNP(CleanNP(ih));
        if hlp <> [[],[]] then
            Add(Gl,hlp);
            Add(lts,hlp[1][1]);
        fi;
    od;
    SortParallel(lts,Gl,LtNP);
    fm := GBNP.StrongNormalForm2(fm,Gl,[]);
    return([fm[1], lcf * fm[2]]);
end);;

##################
### GBNP.ReducePol2
### New function to clean the input
### - set variant
###
### Arguments:
### G        - list of non-commutative polynomials
### GLOT (opt)  - optional occur tree
###
### Results in:
### G        - Cleaned, reduced, ordered list of non trivial S-polynomials.
### Returns:
### GLOT    - Updated occur tree
###
### #GBNP.ReducePol2 uses: GBNP.AddMonToTreePTSLR GBNP.CalculatePGlts GBNP.CreateOccurTreePTSLR GBNP.GetOptions GBNP.Occur GBNP.ReduceCancellation GBNP.RemoveMonFromTreePTSLR GBNP.StrongNormalForm2TS LMonsNP LtNP MkMonicNP#
### #GBNP.ReducePol2 is used in: GBNP.AllObsTrunc GBNP.ReducePol GBNP.SGrobnerTruncLevel SGrobner#
###

GBNP.ReducePol2:=function(arg)
    local i,j,jl,h,ind,lts,new,lans,newind,temp,G,GLOT;
    G:=arg[1];
    if Length(arg)>=2 then
        GLOT:=arg[2];
        lts:=LMonsNP(G);
        if IsBound(GBNP.GetOptions().CancellativeMonoid) then
            lts:=StructuralCopy(lts);
            # Structural copy is needed to be able to update the tree
            # in case of a cancellative monoid
            for i in [1..Length(G)] do
                G[i]:=GBNP.ReduceCancellation(G[i]);
                if (G[i][1]<>lts[i]) then
                    GBNP.RemoveMonFromTreePTSLR(lts[i],i,GLOT,true);
                    GBNP.AddMonToTreePTSLR(G[i][1],i,GLOT,true);
                    lts[i]:=G[i][1];
                fi;
            od;

        fi;
        temp:=ShallowCopy(lts);
        SortParallel(lts,G,LtNP);
        GBNP.SortParallelLOT(temp,GLOT,LtNP);
    else
        for i in [1..Length(G)] do
            G[i]:=GBNP.ReduceCancellation(G[i]);
        od;
        lts:=LMonsNP(G);
        SortParallel(lts,G,LtNP);
        GLOT:=GBNP.CreateOccurTreePTSLR(lts,GBNP.CalculatePGlts(lts),true);
    fi;
    lans:=Length(lts);
    ind:=[1..lans];

    while ind <> [] do
    i:=ind[1];
        RemoveSet(ind,i);
        j:=i+1;
        while j <= lans do
            if #IsSubsetBlist(Gset[j],Gset[i]) and
                ( GBNP.Occur(G[i][1][1],G[j][1][1]) <> 0 ) then
                # XXX can this occur be removed
                new:=GBNP.StrongNormalForm2TS(G,j,GLOT);
                if new = [[],[]] then
                    GBNP.RemoveMonFromTreePTSLR(G[j][1][1],j,GLOT,true);
                    RemoveElmList(G,j);
                    RemoveSet(ind,lans);
                    lans:=lans-1;
                else
                    newind:=PositionSorted(G,new,
                        function(x,y) return LtNP(x[1][1], y[1][1]); end);
                    GBNP.RemoveMonFromTreePTSLR(G[j][1][1],j,GLOT,true);
                    RemoveElmList(G,j);
                    GBNP.AddMonToTreePTSLR(new[1][1],newind,GLOT,true);
                    InsertElmList(G,newind,MkMonicNP(new));
                    RemoveSet(ind,j);

                    for h in [1..Length(ind)] do
                        if ind[h] in [newind..j-1] then ind[h]:=ind[h]+1; fi;
                    od;
                    if i in [newind..j-1] then i:=i+1; fi;
                    AddSet(ind,newind);
                    j:=j+1;
                fi;
            else
                j:=j+1;
            fi;
        od;
    od;
    return GLOT;
end;;

##################
### GBNP.ReducePol
### New function to clean the input
###
### Arguments:
### G        - list of non-commutative polynomials
###
### Returns:
### G        - Cleaned, reduced, ordered list of non-trivial S-polynomials.
###
### #GBNP.ReducePol uses: CleanNP GBNP.ReducePol2 MkMonicNP#
### #GBNP.ReducePol is used in: GBNP.SGrobnerTrunc GBNP.SGrobnerTruncLevel Grobner SGrobner#
###

GBNP.ReducePol:=function(B)
    local G,i,done,one,count;
    G:=List(B,x -> MkMonicNP(CleanNP(x)));
         G:=Filtered(G, x -> x <> [[],[]]);
    ## Extra loop added October 2023 to fix issue #15
    ## this tests to find two polynomials with the same leading monomial
    ## and, when found, replaces the second with their difference.
    ## Note that this includes the case when a polynomial is repeated.
    count:=0;
    done := false;
    while not done do
        count:=count+1;
        for i in [1..Length(G)] do
            G[i]:=GBNP.ReduceCancellation(G[i]);
        od;
        Sort(G,function(u,v) return LtNP(u[1][1],v[1][1]);end);
        done := true;
        for i in Reversed( [1..Length(G)-1] ) do
             if ( G[i][1][1] = G[i+1][1][1] ) then
                 done := false;
                 one:=One(G[i][2][1]);
                 G[i+1] := MkMonicNP(CleanNP(AddNP(G[i+1],G[i],one,-one)));
             fi;
        od;
        if not done then
            ## need to resort G
            G := Filtered( G, L -> L <> [ [ ], [ ] ] );
            Sort(G,function(u,v) return LtNP(u[1][1],v[1][1]);end);
        fi;
    od;
    GBNP.ReducePol2(G);
    return G;
end;;

###################
### GBNP.AllObs ###
###################
### - Computing all obstructions w.r.t. set G polynomials
### (first part of the algorithm).
### (name is misleading, a part of a basic set is constructed; known
### reducible obstructions are not part of the returned list)
### NOTE: returned polynomials are brought in normal form w.r.t. G and sorted
### - OT-trees are not returned
###
### Assumptions:
### - Central obstructions are already done, so only self, left and right.
###
### Optimalizations:
### - A self obstruction should be non-reducible from both the left and the
###   right.
###
### Algorithm:
### - calculate left obstructions (including self)
### - calculate right obstructions (including self)
### - keep the self obstruction if it occurs in both the left and right
###   obstructions
### - (is this needed ?) sorting and reducing within obstructions
### - (should this be added) reducing with G
###
### Arguments:
### G        - list of non-commutative polynomials
###
### Returns:
### todo    - list of non trivial S-polynomials.
###
## #GBNP.AllObs uses: GBNP.AddMonToTreePTSLR GBNP.CreateOccurTreePTSLR GBNP.GetOptions GBNP.ObsTall GBNP.StrongNormalFormTall LMonsNP#
### #GBNP.AllObs is used in: GBNP.IsGrobnerBasisTest Grobner IsGrobnerPair MakeGrobnerPair SGrobner#
###

GBNP.AllObs:=function(G, funcs)
    local k,ans,temp,GLOT,ansLOT,pGLOT,pGROT,from;
    # a trivial Gröbner basis has no obstructions.
    if (G=[]) or (G=[ [ [ [  ] ], [ 1 ] ] ]) then
        return [];
    fi;
    ans := [];
    ansLOT := GBNP.CreateOccurTreePTSLR( [], funcs.pg, true );;
    GLOT := GBNP.CreateOccurTreePTSLR( LMonsNP(G), funcs.pg, true );
    pGLOT := GBNP.CreateOccurTreePTSLR( [], funcs.pg, true );
    pGROT := GBNP.CreateOccurTreePTSLR( [], funcs.pg, false );

    if IsBound( GBNP.GetOptions().lenGB ) then
        from := GBNP.GetOptions().lenGB;
    else
        from := 1;
    fi;
    for k in [ from .. Length(G) ] do
        GBNP.AddMonToTreePTSLR( G[k][1][1], k, pGLOT, true);
        GBNP.AddMonToTreePTSLR( G[k][1][1], k, pGROT, false);
        GBNP.ObsTall( k, G, ans, rec( GL:=GLOT, pGL:=pGLOT, pGR:=pGROT,
            todoL:=ansLOT ), funcs); # change this in a new AllObsall
    od;

    # only reduce with G, do not reduce with itself yet
    # GBNP.ReducePol2( ans );
    for k in [1 .. Length(ans)] do
        ans[k]:=GBNP.StrongNormalFormTall(ans[k],G,GLOT,funcs);
    od;
    temp := LMonsNP( ans );
    SortParallel( temp, ans, LtNP );
    return( ans );
end;;

##################
### Grobner
### <#GAPDoc Label="Grobner">
### <ManSection>
### <Func Name="Grobner" Comm="Buchberger's algorithm with normalform"
### Arg="Lnp [, D] [, max]" />
###
### <Returns>
### If the algorithm terminates, a Gröbner Basis or a record
### if <A>max</A> is specified (see description).
### </Returns>
###
### <Description>
### For a list <A>Lnp</A>  of polynomials in NP format this function will use
### Buchberger's algorithm with normal form to find a Gröbner Basis
### (if possible, the general problem is unsolvable).
### <P/>
### When called with the optional argument <A>max</A>, which should be a
### positive integer, the calculation will
### be interrupted if it has not ended after <A>max</A> iterations. The
### return value will be a record containing lists <C>G</C> and
### <C>todo</C> of polynomials in NP format, a boolean <C>completed</C>,
### and an integer <C>iterations</C>.
### Here <C>G</C> and <C>todo</C> form a Gröbner pair
### (see <Cite Key="CohenGijsbersEtAl2007"/>). The number of performed
### iterations will be placed in <C>iterations</C>. If the algorithm
### has terminated, then <C>todo</C> will be the empty list and
### <C>completed</C> will be equal to
### <C>true</C>. If the algorithm has not terminated, then <C>todo</C> will be
### a non-empty list of polynomials in NP format and
### <C>completed</C> will be <C>false</C>.
### <P/>
### By use of the optional argument <A>D</A>, it is possible to resume a
### previously interrupted calculation.
### <P/>
### <#Include Label="example-Grobner">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Buchberger's algorithm with normal form
###
### Input: List of polynomials. shape a^2-b  = [[[1,1],[2]],[1,-1]]
###
### Output: Grobner Basis
###
### Invariants of list G=[g_1,...,g_s]
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
### #Grobner uses: GBNP.AllObs GBNP.CalculatePG GBNP.ReducePol GBNP.SGrobnerLoops#
### #Grobner is used in:#
###

InstallGlobalFunction( Grobner, function(arg)
    local tt,todo,G, funcs,KI,loop, withpair;

    # set the default options
    funcs:=ShallowCopy(GBNP.GrobnerLoopRec);

    # the number of arguments should be 1 or 2 (KI [, max])
    if Length(arg)<1 then
        return fail;
    else
        KI:=arg[1];
    fi;

    tt:=Runtime();

    if Length(arg)>=2 and IsInt(arg[Length(arg)]) then
        funcs.maxiterations := arg[Length(arg)];
    fi;

    if Length(arg)>=2 and IsList(arg[2]) then
        withpair:=true;
    else
        withpair:=false;
    fi;

# phase I, start-up, building G
# - Clean the list and make all polynomials monic
# - Sort each polynomial so that its leading term is in front
# - Order the list of polynomials such that
#      the one with smallest leading term comes first
# - Compute internal NormalForm

     Info(InfoGBNP,1,"number of entered polynomials is ",Length(KI));
     if (withpair) then
         # no cleaning should be needed when continuing
         G:= ShallowCopy(KI);
     else
         G:= GBNP.ReducePol(KI);
     fi;

     # only call GBNP.CalculatePG after reduction
     funcs.pg:=GBNP.CalculatePG(G);

     Info(InfoGBNP,1,"number of polynomials after reduction is ",Length(G));
     Info(InfoGBNP,1,"End of phase I");


# phase II, initialization, making todo
# - Compute all possible obstructions
# - Compute their S-polynomials
# - Make a list of the non-trivial NormalForms

    if withpair then
        todo:=arg[2];
    else
        todo:=GBNP.AllObs(G, funcs);
    fi;
    Info(InfoGBNP,1,"End of phase II");

 # phase III, The loop

    loop := GBNP.SGrobnerLoops(G,todo,funcs);

    if loop.completed <> true  then
        Info(InfoGBNP,1,"Calculation interrupted after ",
             funcs.maxiterations," iterations");
    else
        Info(InfoGBNP,1,"End of phase III");
    fi;

# End of the algorithm

     Info(InfoGBNPTime,1,"The computation took ",Runtime()-tt," msecs.");

     if IsBound(funcs.maxiterations) then
         return loop;
     else
         return loop.G;
     fi;
end);

##################
### <#GAPDoc Label="SGrobner"
### <ManSection>
### <Func Name="SGrobner" Comm="Buchberger's algorithm with strong normalform"
### Arg="Lnp [, todo ] [, max]" />
###
###
### <Returns>
### If the algorithm terminates, a Gröbner Basis or a record
### if <A>max</A> is specified (see description).
### </Returns>
###
### <Description>
### For a list <A>Lnp</A>  of polynomials in NP format this function will use
### Buchberger's algorithm with strong normal form
### (see <Cite Key="CohenGijsbersEtAl2007"/>) to find a Gröbner Basis
### (if possible, the general problem is unsolvable).
### <P/>
### When called with the optional argument <A>max</A>, which should be a
### positive integer, the calculation will
### be interrupted if it has not ended after <A>max</A> iterations. The
### return value will be a record containing lists <C>G</C> and
### <C>todo</C> of polynomials in NP format, a boolean <C>completed</C>,
### and an integer <C>iterations</C>.
### Here <C>G</C> and <C>todo</C> form a Gröbner pair
### (see <Cite Key="CohenGijsbersEtAl2007"/>). The number of performed
### iterations will be placed in <C>iterations</C>. If the algorithm
### has terminated, then <C>todo</C> will be the empty list and
### <C>completed</C> will be equal to
### <C>true</C>. If the algorithm has not terminated, then <C>todo</C> will be
### a non-empty list of polynomials in NP format and
### <C>completed</C> will be <C>false</C>.
### <P/>
### By use of the optional argument <A>D</A>, it is possible to resume a
### previously interrupted calculation.
### <P/>
### <#Include Label="example-SGrobner">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### - Buchberger's algorithm with strong normal form
###
### Arguments:
### KI           - list of non-commutative polynomials.
### max          - (optional) maximum number of iterations
###
### Returns:
### G            - a Grobner Basis (if found...the general problem is unsolvable)###
### Invariants of list G=[g_1,...,g_s]
### - G is basis of ideal
### - all g_i are monic
### - for all S-polynomials S(i,j) with g_i and g_j in G holds
###  S(i,j) has a weak grobner representation (defined by MORA)
###                     or !
###  S(i,j) is an element of todo.
###
### Thm 5.1 (MORA) A basis G of an ideal I is a Grobner basis of I if and only if
### - all elements of G are monic
### - all S-polynomials have a weak Grobner representation
###
### Observation: if todo is empty then G is a Grobner basis
###
### #SGrobner uses: GBNP.AllObs GBNP.CalculatePG GBNP.ReducePol GBNP.ReducePol2 GBNP.ReducePolTails GBNP.SGrobnerLoops#
### #SGrobner is used in: SGrobnerModule#
###

InstallGlobalFunction( SGrobner, function(arg)
    local tt,todo,G,GLOT,funcs,KI,loop,withpair;

    # set the default options
    funcs:=ShallowCopy(GBNP.SGrobnerLoopRec);

    if Length(arg)<1 then
        return fail;
    else
        KI:=arg[1];
    fi;
    tt:=Runtime();

    if Length(arg)>=2 and IsInt(arg[Length(arg)]) then
        funcs.maxiterations := arg[Length(arg)];
    fi;

    if Length(arg)>=2 and IsList(arg[2]) then
        withpair:=true;
    else
        withpair:=false;
    fi;

# phase I, start-up, building G
# - Clean the list and make all polynomials monic
# - Sort each polynomial so that its leading term is in front
# - Order the list of polynomials such that
#      the one with smallest leading term comes first
# - Compute internal StrongNormalForm

     Info(InfoGBNP,1,"number of entered polynomials is ",Length(KI));

     if (withpair) then
         # no cleaning should be needed when continuing
         G:= ShallowCopy(KI);
     else
         G:= GBNP.ReducePol(KI);
     fi;

     # only call GBNP.CalculatePG after reduction
     funcs.pg:=GBNP.CalculatePG(G);

     Info(InfoGBNP,1,"number of polynomials after reduction is ",Length(G));
     Info(InfoGBNP,1,"End of phase I");

# phase II, initialization, making todo
# - Compute all possible obstructions
# - Compute their S-polynomials
# - Make a list of the non-trivial StrongNormalForms

    if withpair then
        todo:=arg[2];
    else
        todo:=GBNP.AllObs(G, funcs);
    fi;
    Info(InfoGBNP,1,"End of phase II");

 # phase III, The loop

    loop := GBNP.SGrobnerLoops(G,todo,funcs);
    if loop.completed <> true then
        Info(InfoGBNP,1,"Calculation interrupted after ",
             funcs.maxiterations," iterations");
    else
        Info(InfoGBNP,1,"End of phase III");
    fi;

# phase IV, Make the result reduced

    GLOT:=GBNP.ReducePol2(G);
    GBNP.ReducePolTails(G,[],GLOT); # reduce the tails of the polynomials
    Info(InfoGBNP,1,"End of phase IV");

# End of the algorithm

    Info(InfoGBNPTime,1,"The computation took ",Runtime()-tt," msecs.");
    if IsBound(funcs.maxiterations) then
        return loop;
    else
        return loop.G;
    fi;
end);

######################################################
### GBNP.NondivMons
###
### Arguments:
### lts         - list of leading terms
### t        - number of elements in the alphabet
### maxno    - maximum number of monomials to be found
###
### Returns:
### ans        - List of nondiv. monomials
###
### uses:    - GBNP.RightOccurInLst
### used in:    - DimQA, BaseQA

# new version in occurtree3.gi

######################################################
### BaseQA
###
### <#GAPDoc Label="BaseQA">
### <ManSection>
### <Func Name="BaseQA" Comm="Find a basis of the quotient algebra"
### Arg="G, t, maxno" />
### <Returns>A list of terms forming a basis of the quotient
### algebra of the (non-commutative) polynomial algebra
### in <A>t</A> variables by the 2-sided ideal generated by
### <A>G</A>
### </Returns>
### <Description>
### When called with a Gröbner basis <A>G</A>, the number  <A>t</A>
### of generators of
### the algebra, and a maximum number of terms to be found
### <A>maxno</A>, BaseQA will return a (partial) base of the quotient algebra.
### If this function is invoked with <A>maxno</A> equal to 0, then a full basis
### will be given. If the dimension of this quotient algebra is infinite and
### <A>maxno</A> is set to 0, then
### the algorithm behind this function will not terminate.
### <P/>
### <#Include Label="example-BaseQA">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### returns a basis of terms
### Arguments:
### G         - a Grobner basis
### t        - number of elements in the alphabet
### maxno    - maximum number of terms to be found
###
### Returns:
### ans        - List of terms forming a basis of QA = NP algebra mod G
###
### uses:    - GBNP.NondivMons, LMonsNP
### #BaseQA uses: GBNP.NondivMons LMonsNP#
### #BaseQA is used in:#
###

InstallGlobalFunction( BaseQA, function(G,t,maxno)
    local ans, hlst, i, h, GF,one;
    # estimate the number of generators
    if t = 0 then
        t := NumAlgGensNPList(G);
    fi;

    GF:=Filtered(G,x->x<>[[],[]]);
    if Length(GF)>0 then
         one:=One(GF[1][2][1]);
    else
         one:=1;
    fi;
    hlst := GBNP.NondivMons(LMonsNP(G),t,maxno);
    ans := [];
    for i in [1..Length(hlst)] do
        for h in hlst[i] do
            Add(ans,[[h],[one]]);
        od;
    od;
    return ans;
end);;

######################################################
### DimQA
### <#GAPDoc Label="DimQA">
### <ManSection>
### <Func Name="DimQA" Comm="Calculates the dimension of the quotient algebra"
### Arg="G, t" />
### <Returns>The dimension of the quotient algebra
### </Returns>
### <Description>
### When called with a Gröbner basis <A>G</A> and a number
### of variables <A>t</A>, the function <C>DimQA</C>
### will return the dimension of the quotient
### algebra of the free algebra generated by <A>t</A> variables
### by the ideal generated by <A>G</A> if it is finite.
### It will not terminate if the dimension is
### infinite.
### <P/> If <A>t</A>=0, the function will compute the minimal
### value of <C>t</C> such that the polynomials in <A>G</A>
### belong to the free algebra on  <C>t</C> generators.
### <P/>
### To check whether the dimension of the quotient
### algebra is finite and to determine the type
### of growth if it is infinite, see
### also the functions <Ref Func="FinCheckQA" Style="Text"/> and <Ref
### Func="DetermineGrowthQA" Style="Text"/>
### in Section <Ref Sect="finiteness"/>.
### <P/>
### <#Include Label="example-DimQA">
### </Description>
### </ManSection>
### <#/GAPDoc>
### Arguments:
### G         - a Grobner basis
### n           - the number of variables
###
### Returns:
### s        - the dimension of the quotient algebra
###
### #DimQA uses: GBNP.NondivMonsPTSenum LMonsNP#
### #DimQA is used in:#
###

InstallGlobalFunction( DimQA, function(G,n)
    local s,t0;

    if n = 0 then
        n := NumAlgGensNPList(G);
    fi;
    t0 := Runtime();
    if Length(G) = 0 then
        Error("dim is infinite as ideal is trivial.\n");
    fi;
    s := GBNP.NondivMonsPTSenum([],LMonsNP(G),n,0,0);
    Info(InfoGBNPTime,2,"The computation took ",Runtime()-t0," msecs.");
    return s;
end);;

####################################################
### MulQA  multiplication in the quotient algebra
### <#GAPDoc Label="MulQA">
### <ManSection>
### <Func Name="MulQA" Comm="Multiply two elements in the quotient algebra"
### Arg="p1, p2, G" />
### <Returns>The strong normal form of the product
### <A>p1</A><M>*</M><A>p2</A> with respect to <A>G</A>
### </Returns>
### <Description>
### When called with two polynomials in NP form, <A>p1</A> and <A>p2</A>, and a
### Gröbner basis <A>G</A>, this function will return the product in the
### quotient algebra.
### <P/>
### <#Include Label="example-MulQA">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### Arguments:
### G         - a Grobner basis
### p1, p2      - two polynomials
###
### Returns:
### ans        - the strong normal form of the product p1*p2 with
###               respect to G
###
### #MulQA uses: MulNP StrongNormalFormNP#
### #MulQA is used in: MatrixQA#
###

InstallGlobalFunction( MulQA, function(p1,p2,G)
    return StrongNormalFormNP(MulNP(p1,p2),G);
end);;

###################
### GBNP.StrongNormalForm2TS
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
### f         - a non-commutative polynomial
### G        - list of non-commutative polynomials
### G2        - list of non-commutative polynomials
### Gset    - list of the leading term-sets
### G2set    - list of the leading term-sets
###
### Returns:
### pol        - strong normalform of f w.r.t. G
###
### #GBNP.StrongNormalForm2TS uses: AddNP BimulNP GBNP.LookUpOccurTreeAllLstPTSLR#
### #GBNP.StrongNormalForm2TS is used in: GBNP.ReducePol2 GBNP.ReducePolTails#
###

GBNP.StrongNormalForm2TS:=function(G,j,GLOT)
    local g,h,il,i1,l,dr,ga,tt,lth,iid;
    h:=StructuralCopy(G[j]);
    iid := 1;
    while iid <= Length(h[1]) do
        lth:=h[1][iid];
        il:=GBNP.LookUpOccurTreeAllLstPTSLR(lth,GLOT,true);
        il:=Filtered(il,x->x[1]<>j);
        while il<>[] do
            i1:=il[1];
            g:=G[i1[1]];
            ga:=lth{[1..i1[2]-1]};
            dr:=lth{[i1[2]+Length(g[1][1])..Length(lth)]};
            h:=AddNP(h,BimulNP(ga,g,dr),One(g[2][1]),-h[2][iid]/g[2][1]);
            if h=[[],[]] then
                return h;
            fi;
            if iid <= Length(h[1]) then
                lth := h[1][iid];
                il:=GBNP.LookUpOccurTreeAllLstPTSLR(lth,GLOT,true);
                il:=Filtered(il,x->x[1]<>j);
            else
                return(h);
            fi;
        od;
        iid := iid+1;
    od;
    return(h);
end;;

###################
### GBNP.NormalForm2T
### - Computes the normal form of a non-commutative polynomial
###   using two lists of polynomials with respect to which it rewrites
### - set variant
###
### Assumptions:
### -  polynomials in G union G2 are monic and clean.
### -  polynomial f is clean.
### -  polynomial f is not empty. (= [[],[]])
###
### Arguments:
### f         - a non-commutative polynomial
### G        - list of non-commutative polynomials
### G2        - list of non-commutative polynomials
###
### Returns:
### pol        - normal form of f w.r.t. G union G2
###
### #GBNP.NormalForm2T uses: AddNP BimulNP GBNP.OccurInLstT#
### #GBNP.NormalForm2T is used in:#
###

GBNP.NormalForm2T:=function(f,G,G2,GLOT,G2LOT)
    local g,h,i,i2,j,l,dr,ga,tt,lth;
    tt:=Runtime();
    h:=StructuralCopy(f);
    lth:=h[1][1];
    i:=GBNP.OccurInLstT(lth,GLOT);
    i2:=GBNP.OccurInLstT(lth,G2LOT);
    while i[1]>0 or i2[1]>0  do
        if i[1]>0 then
            g:=G[i[1]];
            ga:=lth{[1..i[2]-1]};
            dr:=lth{[i[2]+Length(g[1][1])..Length(lth)]};
            h:=AddNP(h,BimulNP(ga,g,dr),One(h[2][1]),-h[2][1]/g[2][1]);
            if h=[[],[]] then
                Info(InfoGBNPTime,3,"computation time of the NormalForm = ",Runtime()-tt);
                return(h);
            fi;
            lth:=h[1][1];
            i:=GBNP.OccurInLstT(lth,GLOT);
            i2:=GBNP.OccurInLstT(lth,G2LOT);
        else
            g:=G2[i2[1]];
            ga:=lth{[1..i2[2]-1]};
            dr:=lth{[i2[2]+Length(g[1][1])..Length(lth)]};
            h:=AddNP(h,BimulNP(ga,g,dr),One(h[2][1]),-h[2][1]/g[2][1]);
            if h=[[],[]] then
                Info(InfoGBNPTime,3,"computation time of the NormalForm = ",Runtime()-tt);
                return(h);
            fi;
            lth:=h[1][1];
            i:=GBNP.OccurInLstT(lth,GLOT);
            i2:=GBNP.OccurInLstT(lth,G2LOT);
        fi;
    od;
    Info(InfoGBNPTime,3,"computation time of the NormalForm = ",Runtime()-tt);
    return(h);
end;;

##################
### GBNP.CentralT
### - Finding all central obstructions of u, leading term of G[j],
###   w.r.t. the list of leading terms of G.
### - uses lterm-sets
###
### Arguments:
### j         - index of a non-commutative polynomial in G
### G        - list of non-commutative polynomials
### lst        - list of S-polynomials (todo)
### Gset
### lstset
###
### Returns:
### todo    - new list of S-polynomials. S-polynomials with G[j] added
###
### #GBNP.CentralT uses: GBNP.AddMonToTreePTSLR GBNP.Occur GBNP.Spoly GBNP.StrongNormalForm2Tall LMonsNP MkMonicNP#
### #GBNP.CentralT is used in:#
###

GBNP.CentralT:=function(j,G,todo,OT,funcs)
    local R,ob,temp,a,i,o,u,v,lu,lv,all;
    R := LMonsNP(G);
    u:=R[j];
    lu:=Length(u);
    #all:=GBNP.LookUpOccurTreeAllLstPTSLR(u,OT.GL,true);
    #all:=Filtered(all,x->x[1]<j-1);
    for i in [1..j-1] do
        v:=R[i];
        lv:=Length(v);
        o:=GBNP.Occur(u,v);
        if o > 1 and o+lu<=lv then
            temp:=GBNP.Spoly([v{[1..o-1]},j,v{[o+lu..lv]},[],i,[]],G);
            if temp <> [[],[]] then
                temp:=GBNP.StrongNormalForm2Tall(temp,G,todo,OT,funcs);
                if temp <> [[],[]] then
                    Add(todo,MkMonicNP(temp));
                    if not IsTHeapOT(todo) then
                        # heap -> added to tree already
                        GBNP.AddMonToTreePTSLR(temp[1][1],-1,OT.todoL,true);
                        # jwk - add to the tree too
                    fi;
                fi;
            fi;
        fi;
    od;
end;;

#################
### GBNP.LeftObsT
### - Searches "left" obstructions of a monomial u w.r.t. monomials in R.
### Because "left" and "right" obstructions are symmetric,
### we only search for i<j.
### All redundant obstructions are removed. For efficiency reasons, the
### self obstruction of R[j] (if present) is taken into account.
###
### Arguments:
### j         - index of the monomial for which we search left-obs.
### R        - set of leading terms (monomials)
### sob        - 'smallest' self-obstruction of R[j]
###
### Returns:
### ans        - List of found left-obstructions
###
### #GBNP.LeftObsT uses: GBNP.AddMonToTreePTSLR GBNP.CreateOccurTreePTSLR GBNP.LookUpOccurTreeForObsPTSLR GBNP.LookUpOccurTreePTSLRPos LtNP#
### #GBNP.LeftObsT is used in: GBNP.ObsTall#
###

# XXX remove these comments
# right k characters of u (k as large as possible) are start of v
# (left occur tree)
# possible with GLOT tree lookups kindof
# zo toevoegen dat er geen overbodige gevallen zijn volgens 2.4
# -> eerste deelobstruction per element uit R (dus langste)
# + deelobstructies prefix reductie (sort,tree)

GBNP.LeftObsT:=function(j,R,GLOT)
    local i,k,u,v,l,dr,ga,lo,lu,lv,mi,ans,len,ansLOT,sob;
    ans:=[];
    u:=R[j];
    lu:=Length(u);
    lo:=GBNP.LookUpOccurTreeForObsPTSLR(u,j,GLOT,true);
    for l in lo do
        i:=l[1];
        v:=R[i];
        lv:=Length(v);
        mi:=Minimum([lu,lv]);
        k:=lu+1-l[2];
        # if u{[lu-k+1..lu]}=v{[1..k]} # holds by lookup
        ga:=u{[1..lu-k]};
        dr:=v{[k+1..lv]};
        Add(ans,[[],j,dr,ga,i,[]]);
    od;

    Sort(ans,function(u,v) return LtNP(u[3],v[3]);end);

    ansLOT:=GBNP.CreateOccurTreePTSLR([],GLOT.pg,true);

    i:=1;
    len:=Length(ans);
    sob:=0;
    while i<=len do
        if GBNP.LookUpOccurTreePTSLRPos(ans[i][3],ansLOT,true,1) = 0 then
            if ans[i][5]=j then #selfobs
                sob:=i;
            fi;
            GBNP.AddMonToTreePTSLR(ans[i][3],i,ansLOT,true);
            i:=i+1;
        else
            RemoveElmList(ans,i);
            len:=len-1;
        fi;
    od;

    return(rec(obs:=ans,sobnr:=sob));
end;;

#################
### GBNP.RightObsT
### - Searches "right" obstructions  of monomial u w.r.t. monomials in R.
### Because "left" and "right" obstructions are symmetric,
### we only search for i<j.
### All redundant obstructions are removed. For efficiency, the
### self obstruction of R[j] (written as a right obstruction) is taken
### into account (if it exists).
###
### Arguments:
### j         - index of the monomial for which we search left-obs.
### R        - set of leading terms (monomials)
### GROT    - set of leading terms (monomials)
###
### Returns:
### ans        - List of found left-obstructions
###
### #GBNP.RightObsT uses: GBNP.AddMonToTreePTSLR GBNP.CreateOccurTreePTSLR GBNP.LookUpOccurTreeForObsPTSLR GBNP.LookUpOccurTreePTSLRPos LtNP#
### #GBNP.RightObsT is used in: GBNP.ObsTall#
###

# left k characters of u (k as large as possible) are end of v
# (right occur tree)
# possible with GROT tree lookups kindof
# zo toevoegen dat er geen overbodige gevallen zijn volgens 2.4
# -> eerste deelobstruction per element uit R (dus langste)
# + deelobstructies prefix reductie (sort,tree)

GBNP.RightObsT:=function(j,R,GROT)
    local i,k,u,v,l,dr,ga,lo,lu,lv,mi,ans,len,ansROT,sob;
    ans:=[];
    u:=R[j];
    lu:=Length(u);
    lo:=GBNP.LookUpOccurTreeForObsPTSLR(u,j,GROT,false);
    for l in lo do
        i:=l[1];
        v:=R[i];
        lv:=Length(v);
        mi:=Minimum([lu,lv]);
        k:=lu+1-l[2];
        # if u{[lu-k+1..lu]}=v{[1..k]} # holds by lookup
        ga:=v{[1..lv-k]};
        dr:=u{[k+1..lu]};
        Add(ans,[ga,j,[],[],i,dr]);
    od;

    Sort(ans,function(u,v) return LtNP(u[1],v[1]);end);

    ansROT:=GBNP.CreateOccurTreePTSLR([],GROT.pg,false);

    if (ansROT.pg<> GROT.pg) then
        Print(R,"\n");
    fi;

    i:=1;
    len:=Length(ans);
    sob:=0;
    while i<=len do
        if GBNP.LookUpOccurTreePTSLRPos(ans[i][1],ansROT,false,1) = 0 then
            if ans[i][5]=j then #selfobs
                sob:=i;
            fi;
            GBNP.AddMonToTreePTSLR(ans[i][1],i,ansROT,false);
            i:=i+1;
        else
            RemoveElmList(ans,i);
            len:=len-1;
        fi;
    od;

    return(rec(obs:=ans,sobnr:=sob));
end;;

############################
### IsStrongGrobnerBasis ###
############################
###
### <#GAPDoc Label="IsStrongGrobnerBasis">
### <ManSection>
### <Func Name="IsStrongGrobnerBasis" Comm="Test if a list of NP polynomials is a strong Gröbner basis" Arg="G" />
### <Returns>
### <C>true</C> if <A>G</A> is a strong Gröbner basis
### and <C>false</C>
### otherwise
### </Returns>
### <Description>
### When invoked with a list <A>G</A> of polynomials in NP format
### (see Section <Ref Sect="NP"/>), this function will check whether the
### polynomials in this list form a strong Gröbner basis
### (see <Cite Key="CohenGijsbersEtAl2007"/>).
### <P/>
### Polynomials representing zero are allowed in <A>G</A>.
### <P/>
### <#Include Label="example-IsStrongGrobnerBasis">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### Check whether a set of polynomials in NP form is a Strong Gröbner basis.
### Zero polynomials are allowed.
###
### Arguments:
### - G        the list of polynomials in NP form to check
###
### #IsStrongGrobnerBasis uses: GBNP.IsGrobnerBasisTest#
### #IsStrongGrobnerBasis used in:#

InstallGlobalFunction( IsStrongGrobnerBasis, function(G)
    return GBNP.IsGrobnerBasisTest(G,true);
end);

######################
### IsGrobnerBasis ###
######################
###
### <#GAPDoc Label="IsGrobnerBasis">
### <ManSection>
### <Func Name="IsGrobnerBasis" Comm="Test if a list of NP polynomials is a Gröbner basis" Arg="G" />
### <Returns>
### <C>true</C> if <A>G</A> is a Gröbner basis and <C>false</C> otherwise
### </Returns>
### <Description>
### When invoked with a list <A>G</A> of polynomials in NP format
### (see Section <Ref Sect="NP"/>), this function will check whether the
### list is a Gröbner basis.
### The check is based on Theorem 1.4 from <Cite Key="CohenGijsbersEtAl2007"/>.
### <P/>
### Polynomials representing zero are allowed in <A>G</A>.
### <P/>
### <#Include Label="example-IsGrobnerBasis">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### Check whether a set of polynomials in NP form is a Gröbner basis.
###
### Arguments:
### - G        the list of polynomials in NP form to check
###
### #IsGrobnerBasis uses: GBNP.IsGrobnerBasisTest#
### #IsGrobnerBasis used in:#

InstallGlobalFunction( IsGrobnerBasis, function(G)
    return GBNP.IsGrobnerBasisTest(G,false);
end);

###############################
### GBNP.IsGrobnerBasisTest ###
###############################
###
### Check whether a set of polynomials in NP form is a (Strong) Gröbner basis.
### A set of polynomials G is a Gröbner basis for an ideal I if G is a basis of
### I and if the leading monomial of each non-zero element of I is a multiple
### of the leading monomial of an element of G. (Definition 3,
### CohenGijsbersEtAl2007).
###
### G is a Gröbner basis if and only if each S-polynomial of G is weak with
### respect to G. (Theorem 1.4, CohenGijsbersEtAl2007)
###
### Remark: if g_i,g_j in G, i<>j and LT(g_i)=LT(g_j) then it is sufficient to
### look at all s-polynomials of g_i and for h_i to look at the spolynomial
### (1,i,1;1,j,1).
###
### variants:
### - G is a *reduced* Gröbner basis if the polynomials in G are monic, sorted,
###   and the leading terms of polynomials cannot be reduced by other
###   polynomials in G.
###   XXX require the <list> to be sorted, guess -> NO
###
### - G is a *strong reduced* Gröbner basis if the polynomials in G are monic,
###   sorted, and the polynomials cannot be reduced by other polynomials in G.
###   To prove G is a *strong reduced* Gröbner basis, one can check if G is a
###   *reduced* Gröbner basis, and check if the polynomials in G cannot be
###   reduced by other polynomials in G.
###
### Arguments:
### - G        the list of polynomials in NP form to check
### - strong    boolean that indicates whether the test is for a "normal",
###         ("reduced") or "reduced strong" Gröbner basis
###
### Returns:
###
### #GBNP.IsGrobnerBasisTest uses: AddNP CleanNP GBNP.AddMonToTreePTSLR GBNP.AllObs GBNP.CalculatePG GBNP.CreateOccurTreePTSLR GBNP.StrongNormalFormTall LMonsNP LtNP MkMonicNP#
### #GBNP.IsGrobnerBasisTest used in:#
###

# TODO check special cases 0 [[],[]] (might be allowed if strong=false), 1
# [[[]],[1]] (should be only one if strong=true, if strong=false the result is
# true if 1 occurs)
GBNP.IsGrobnerBasisTest:=function(G,strong)
    local i,          # counter
          Gclean,     # G cleaned
          Gdouble,    # polynomials of G with leading term the same as a
                      # leading term in Gdouble
          Gsingle,    # polynomials of G with all different leading terms
          GsLOT,      # occur tree for Gsingle
          doubleObs,  # obstructions from double terms
          lt,         # leading terms of Gclean
          np,         # polynomial of G in np form
          one,        # one of the field
          pg,         # number of prefix generators
          pol,
          f,
          singleObs;  # obstructions from double terms

    # make sure all polynomials in G are cleaned and non-zero
    Gclean:=[];
    for i in [1..Length(G)] do
        np:=CleanNP(G[i]);
        if np<>[[],[]] then
            Add(Gclean, MkMonicNP(np));
        fi;
    od;

    if Length(Gclean)=0 then
        # an empty set is a (trivial) Gröbner basis
        return true;
    fi;

    # set the one of the field
    one:=One(Gclean[1][2][1]);

    # sort the cleaned G
    Sort(Gclean, function(x,y) LtNP(x[1][1],y[1][1]); end);
    # set the number of prefix generators
    pg:=GBNP.CalculatePG(Gclean);
    if pg > 0 then
        pg:=0; # no prefix generators
    else    # pg < 0 : prefix generators (correct for negative index)
        pg:=-pg;
    fi;

    # store the list of leading terms in lt
    lt:=LMonsNP(Gclean);

    # check if G can reduce itself
    if strong then
        GsLOT:=GBNP.CreateOccurTreePTSLR([],pg,true);
        for i in [1..Length(Gclean)] do
            pol:=Gclean[i];
            if AddNP(pol,GBNP.StrongNormalFormTall(pol,Gclean,GsLOT,
                     rec(pg:=pg, strong:=true) ), 1, -1 ) <> [[],[]] then
                return false;
            fi;
            GBNP.AddMonToTreePTSLR(pol[1][1],i,GsLOT,true);
        od;

        # TODO
    else
        # create a tree structure for fast strong normal form
        # calculation
        GsLOT:=GBNP.CreateOccurTreePTSLR([],pg,true);

    fi;

    doubleObs:=[];
    Gsingle:=[Gclean[1]];
    Gdouble:=[];
    for i in [2..Length(Gclean)] do
        if lt[i]<>lt[i-1] then
            # different leading term -> add to Gsingle
            Add(Gsingle, Gclean[i]);
        else    # same leading term -> add to Gdouble
            Add(Gdouble, Gclean[i]);
            Add(doubleObs, AddNP(Gclean[i-1],Gclean[i],one,-one));
        fi;
    od;

    # calculate all obstructions from Gsingle
    singleObs:=GBNP.AllObs(Gsingle, rec(pg:=pg));

    for pol in Concatenation(singleObs,doubleObs) do
        # check if the obstruction reduces to zero
        if GBNP.StrongNormalFormTall(pol,G,GsLOT,rec(pg:=pg)) <> [[],[]] then
            # does not reduce to zero -> not a Gröbner basis
            return false;
        fi;
    od;

    return true;
end;

# special cases to check :
# - D contains multiple polynomials with the same lt

#####################
### IsGrobnerPair ###
#####################
###
### <#GAPDoc Label="IsGrobnerPair">
### <ManSection>
### <Func Name="IsGrobnerPair" Comm="Tests if a pair of lists forms a Gröbner Pair." Arg="G, D" />
### <Returns>
### A boolean, which has the value <C>true</C> if the input forms a Gröbner
### pair
### </Returns>
### <Description>
### When called with two lists of polynomials in NP format,
### this function returns
### true if they form a Gröbner pair. Testing whether <A>D</A> is a basic set
### for <A>G</A> might involve computing the Gröbner basis. Instead of this
### only some simple computations are done to see if it can easily be proven
### that <A>D</A> is a basic set for <A>G</A>. If this cannot be proven easily,
### then <C>false</C> is returned, even though <M>G, D</M> might still be a
### Gröbner pair.
### <P/>
### <#Include Label="example-IsGrobnerPair">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### Arguments:
### - G
### - D
### (G,D) is the Gröbner pair to be tested.
###
### Returns:
### - true if it can be proved that (G,D) is a Gröbner pair.
###

InstallGlobalFunction( IsGrobnerPair, function(G,D)
    local pol,    # NP polynomial, counter
          pol2,   # NP polynomial
          GLOT,   # Left Occur Tree of G
          DLOT,   # Left Occur Tree of D
          pg,     # number of prefix generators
          obs,    # the set of obstructions
          i,      # counter
          nonred; # number of polynomials which can not be proven to be  reducible;

    # definition 10 from CohenGijsbersEtAl2007
    # 1) all polynomials are monic
    # NOTE: what happens with zero polynomials ?

    for pol in Concatenation(G,D) do
        if not (pol=MkMonicNP(CleanNP(pol))) then
            # pol is not monic -> return false
            Info(InfoGBNP, 1, "Condition 1 is not satisfied.");
            Info(InfoGBNP, 2, "Not all polynomials are monic.");
            return false;
        elif (pol=[[],[]]) then
            # zero polynomial is not monic either
            Info(InfoGBNP, 1, "Condition 1 is not satisfied.");
            Info(InfoGBNP, 2, "Not all polynomials are monic: zero polynomial found.");
            return false;
        fi;
    od;
    # NOTE: fixable by replacing a non monic polynomial by a monic one

    # 2) assume G \cup D is a basis for I (instead of just G)

    # 3) i every element of D belongs to I (because of modified 2)
    #      hard to do otherwise (without calculating a GB from G)
    #    ii check if every element of D is in reduced form wrt G (note: not
    #    strong reduced)

    pg:=GBNP.CalculatePG(G);
    GLOT:=GBNP.CreateOccurTreePTSLR( LMonsNP(G), pg, true);

    for i in [1.. Length(D)] do
        pol:=D[i];

        # zero polynomials are in already normal form
        if (pol <> [[],[]]) then
        # just check leading terms:
            if GBNP.OccurInLstPTSLR(pol[1][1], GLOT, true)[1]<>0
            then
                Info(InfoGBNP, 1, "Condition 3 is not satisfied.");
                Info(InfoGBNP, 2, "Not all polynomials in D are in normal form with respect to G (index: ",i,")");
                # pol is not in normal form -> return false
                Info(InfoGBNP, 3, 1/0);
                return false;
            fi;
        fi;
    od;
    # NOTE: fixable by replacing each element by its normal form

    # 4) the set of D is basic for G
    #    for each non-weak obstruction of G, check that it is reducible by
    #        G \cup D
    obs := GBNP.AllObs(G,rec(pg:=pg, strong:=true));
    for i in [1..Length(obs)] do
        obs[i] := GBNP.StrongNormalFormTall(obs[i], G, GLOT,
                      rec(pg:=pg, strong:=true) );
    od;
    DLOT:=GBNP.CreateOccurTreePTSLR( LMonsNP(D), pg, true);

    nonred:=0;
    for pol in obs do
        if GBNP.StrongNormalForm2Tall(pol,G,D, rec(GL:=GLOT,
                todoL:=DLOT), rec(pg:=pg, strong:=true) ) <> [[],[]] then
            # pol is not in normal form -> return false
            nonred:=nonred+1;
        fi;
    od;
    if (nonred>0) then
        Info(InfoGBNP, 1, "Condition 4 is not satisfied.");
        Info(InfoGBNP, 2, "D is not basic for G for ",nonred,"/",
                          Length(D), " polynomials");
        return false;
    fi;

    # NOTE: fixable by adding the new normal form to D

    return true;
end);

# function to check if monimials are monic and clean and/or make them so
GBNP.MakeGrobnerPairMakeMonic:=function(G)
    local i,      # counter
          pol,    # polynomial being checked
          pol2,   # monic version of pol
          monic,  # true if all polynomials (so far) were already monic
          newG;   # G made monic

    monic:=true;
    newG := ShallowCopy(G);
    for i in [1..Length(newG)] do
        pol := newG[i];
        pol2 := MkMonicNP(CleanNP(pol));
        if not (pol = pol2) then
            # update newG[i]
            monic:=false;
            newG[i]:=pol2;
        elif pol = [[],[]] then
            # zero NP polynomial
            monic:=false;
        fi;
    od;
    if (not monic) then
        Info(InfoGBNP, 2, "Condition 1 was not satisfied (fixed).");
        Info(InfoGBNP, 3, "Not all polynomials were monic.");
    fi;
    return Filtered(newG,x -> x <> [[],[]]);
end;

#######################
### MakeGrobnerPair ###
#######################
###
### <#GAPDoc Label="MakeGrobnerPair">
### <ManSection>
### <Func Name="MakeGrobnerPair" Comm="Construct a Gröbner pair from a pair of lists of polynomials in NP format." Arg="G, D" />
### <Returns>
### A record containing a new Grobner pair
### </Returns>
### <Description>
### When called with as arguments a pair <M>G, D</M>, this function cleans
### <A>G</A> and <A>D</A> and adds some obstructions to <A>D</A> till it is
### easily provable that <A>D</A> is a basic set  for <A>G</A>
### (see <Cite Key="CohenGijsbersEtAl2007"/>). The result is a record
### containing the fields
### <C>G</C> and <C>todo</C> representing the Gröbner pair.
### <P/>
### <#Include Label="example-MakeGrobnerPair">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### Arguments:
### - G
### - D
### - (G,D) the pair to make a Gröbner pair of
###
### Returns:
### - A record containing the new G, todo
###

InstallGlobalFunction( MakeGrobnerPair, function(G,D)
    local pol,   # NP polynomial, counter
          pol2,  # NP polynomial
          GLOT,  # Left Occur Tree of G
          DLOT,  # Left Occur Tree of D
          newG,
          newD,
          pg,    # number of prefix generators
          obs,   # the set of obstructions
          i,     # counter
          fixed; # number of polynomials which has been fixed

    # definition 10 from CohenGijsbersEtAl2007
    # 1) all polynomials are monic
    # NOTE: what happens with zero polynomials ?
    # NOTE: it is ok to consider them monic (but MkMonic might need
    #   adjustment)

    newG:=GBNP.MakeGrobnerPairMakeMonic(G);
    newD:=GBNP.MakeGrobnerPairMakeMonic(D);

    # NOTE: fixable by replacing a non monic polynomial by a monic one

    # 2) assume G \cup D is a basis for I (instead of just G)

    # 3) i every element of D belongs to I (because of modified 2)
    #      hard to do otherwise (without calculating a GB from G)
    #    ii check if every element of D is in reduced form wrt G (note: not
    #    strong reduced)

    pg:=GBNP.CalculatePG(newG);
    GLOT:=GBNP.CreateOccurTreePTSLR( LMonsNP(newG), pg, true);
    fixed:=0;

    for i in [1.. Length(newD)] do
        pol:=newD[i];

        # zero polynomials are in already normal form
        if (pol <> [[],[]]) then
        # just check leading terms:
            if GBNP.OccurInLstPTSLR(pol[1][1], GLOT, true)[1]<>0
            then
                fixed:=fixed+1;
                newD[i]:=GBNP.StrongNormalFormTall(
                    newD[i], newG, GLOT,
                    rec(pg:=pg, strong:=true)
                );
            fi;
        fi;
    od;

    if (fixed >0) then
        Info(InfoGBNP, 2, "Condition 3 was not satisfied (fixed).");
        Info(InfoGBNP, 3, "Not all polynomials in D were in normal form with respect to G.");
    fi;
    # NOTE: fixable by replacing each element by its normal form

    # 4) the set of D is basic for G
    #    for each non-weak obstruction of G, check that it is reducible by
    #        G \cup D
    obs := GBNP.AllObs(newG,rec(pg:=pg, strong:=true));
    for i in [1..Length(obs)] do
        obs[i] := GBNP.StrongNormalFormTall(obs[i], newG, GLOT,
            rec(pg:=pg, strong:=true)
        );

    od;
    DLOT:=GBNP.CreateOccurTreePTSLR( LMonsNP(newD), pg, true);

    fixed:=0;
    for i in [1..Length(obs)] do
        pol:=obs[i];
        pol2:=GBNP.StrongNormalForm2Tall(pol,newG,newD, rec(GL:=GLOT,
                todoL:=DLOT), rec(pg:=pg, strong:=true));

        if pol2<>[[],[]] then
            # pol is not in normal form -> add false
            fixed:=fixed+1;
            Add(newD,pol2);
            GBNP.AddMonToTreePTSLR(pol2[1][1],-1,DLOT,true);
        fi;
    od;
    if (fixed>0) then
        Info(InfoGBNP, 1, "Condition 4 was not satisfied. ","(fixed)");
        Info(InfoGBNP, 2, "D was not basic for G for ",fixed,
                          "/", Length(newD), " polynomials");
    fi;

    # NOTE: fixable by adding the new normal form to D

    return rec(G:=newG,todo:=newD);
end);

###########################
### StrongNormalFormNPM ###
###########################
### <#GAPDoc Label="StrongNormalFormNPM">
### <ManSection>
### <Func Name="StrongNormalFormNPM" Comm="Reduce a polynomial in NP format with respect to a Gröbner basis record." Arg="f, GBR" />
### <Returns>
### The strong normal form of a polynomial in NP format with respect to
### <A>GBR</A>
### </Returns>
### <Description>
### When invoked with a polynomial in NP format (see Section <Ref
### Sect="NP"/>) and a Gröbner basis record <A>GBR</A>
### (see Section <Ref Sect="GBR"/>),
### this function will return the strong normal form (the polynomial reduced by
### the prefix and two-sided relations of the Gröbner basis combination).
### <P/>
### This function assumes that <A>GBR.p</A> and <A>GBR.ts</A> are
### ordered (with the ordering <Ref
### Func="LtNP" Style="Text"/>), that the polynomials in <A>GBR.ts</A> are
### monic and clean (see <Ref Func="MkMonicNP" Style="Text"/> and <Ref
### Func="CleanNP" Style="Text"/>), and that the
### polynomial <A>f</A> is clean. Note that a
### Gröbner basis record as returned by a function like
### <Ref Func="SGrobnerModule" Style="Text"/> is in the required form.
### <P/>
### <#Include Label="example-StrongNormalFormNPM">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Computes the strong normal form of a non-commutative polynomial
###
### Assumptions:
###
### -  polynomials in G are ordered. (lowest degree first) ***really***
### -  polynomials in G are monic and clean.
### -  polynomial f is clean.
###
### Arguments:
### f         - a non-commutative polynomial
### G        - list of non-commutative polynomials
###
### Returns:
### pol        - strong normalform of f w.r.t. G
###
### #StrongNormalFormNPM uses: GBNP.StrongNormalForm2#
### #StrongNormalFormNPM is used in: MulQM#
###

InstallGlobalFunction( StrongNormalFormNPM, function(v,GR)
    if v=[[],[]] then
        return v;
    else
        # GBNP.StrongNormalForm2 can be used for this
        return GBNP.StrongNormalForm2(v,GR.p,GR.ts);
    fi;
end);

######################
### SGrobnerModule ###
######################
### <#GAPDoc Label="SGrobnerModule">
### <ManSection>
### <Func Name="SGrobnerModule" Comm="Buchberger's algorithm with strong
###  normalform for the combination variant" Arg="Lnpm, Lnp" />
###
### <Returns>
### A record <C>GBR</C> containing a Gröbner basis (if found...the general
### problem is unsolvable) for modules;
### <C>GBR.p</C> will contain the prefix rules and
### <C>GBR.ts</C> will contain the two-sided rules, and <C>GBR.pg</C> will be
### the smallest rank of the free module to which all prefix relations belong
### </Returns>
###
### <Description>
### For a list <A>Lnpm</A> of vectors in NPM format
### (see Section <Ref Sect="NP"/>),
### and a list <A>Lnp</A>
### of polynomials in  NP format, this
### function will use Buchberger's algorithm with strong normal form
### applied to the union of <A>Lnpm</A>,
### <A>Lnp</A>, the set of polynomials <M>x*e-x</M> and <M>x*m[i]</M>
### for <M>x</M> a standard indeterminate, a module generator <M>m[j]</M> or
### the dummy indeterminate <M>e</M>, and the
### set of all  <M>e*x -x</M> for <M>x</M> a standard indeterminate,
### to find
### a Gröbner Basis record <C>GBR</C> (if possible; the general problem is
### unsolvable).  This record will have a  Gröbner Basis <C>GBR.ts</C>
### for the two-sided ideal generated by <A>Lnp</A> and
### an intersection with the module <C>GBR.p</C> representing
### the module relations needed to find representative vectors in the module
### uniquely by means of a strong normal form computation modding out
### <C>GBR.p</C> and, for the scalars, <C>GBR.ts</C>.
### <P/>
### <#Include Label="example-SGrobnerModule">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### - Buchberger's algorithm with strong normal form
###
### Arguments:
### KI_p          - list of noncommutative polynomials.
### KI_ts         - list of noncommutative polynomials.
###
### Returns:
### GBR           - a Grobner Basis (if found...the general problem is unsolvable)
### slightly adjusted: G=GBR.p union GBR.ts (prefix and two-sided rules) - jwk
###
### Invariants of list G=[g_1,...,g_s]
### - G is basis of ideal
### - all g_i are monic
### - for all S-polynomials S(i,j) with g_i and g_j in G holds
###  S(i,j) has a weak grobner representation (defined by MORA)
###                     or !
###  S(i,j) is an element of todo.
###
### Thm 5.1 (MORA) A basis G of an ideal I is a Grobner basis of I if and only if
### - all elements of G are monic
### - all S-polynomials have a weak Grobner representation
###
### -XXX assumed is that KI_ts is non-empty (is this needed here ?)
### Observation: if todo is empty then G is a Grobner basis
###
### #SGrobnerModule uses: GBNP.CalculatePG GBNP.GetOptions GBNP.SetOption MulNP SGrobner#
### #SGrobnerModule is used in:#
###

InstallGlobalFunction( SGrobnerModule, function(KI_p,KI_ts)
    local tt,todo,G,GB_ts,temp;
    # XXX check for module generators

    G:=Filtered(KI_p,x->x<>[[],[]]);

    if Length(G)>0 and ((not IsBound(G[1][1][1][1])) or G[1][1][1][1]>0) then
        G:=List(G,x->MulNP([[[-1]],[One(G[1][2][1])]], x));
    fi;

    # XXX should be calculated with pg=0
    # setting pg after SGrobner is a workaround when calling this function
    # the first time, real solution should be verifying if the calculated pg
    # of KI_ts is zero and storing the old pg value temporarily

    if GBNP.GetOptions().pg=0 then
        GBNP.SetOption("pg",GBNP.CalculatePG(G));
    fi;

    # store pg value temporarily in the temp variable
    temp:=GBNP.GetOptions().pg;
    GBNP.SetOption("pg",0);

    # first create two-sided GB
    # possible assertion GBNP.CalculatePG(KI_ts) should be 0
    GB_ts:=SGrobner(KI_ts);

    GBNP.SetOption("pg",temp);

    #GBNP.SetOption("lenGB",Length(GB_ts));
    # XXX reason to leave this commented out is that it becomes impossible to
    # run other SGrobner calculations without this option. (possible solution,
    # change it in allobs ?)

    G:=SGrobner(Concatenation(G,GB_ts));

    #split GB into ts GB and prefix GB and return rec(ts,p)
    return rec(ts:=Filtered(G,x->not IsBound(x[1][1][1]) or x[1][1][1]>0),p:=Filtered(G,x->IsBound(x[1][1][1]) and x[1][1][1]<0),pg:=GBNP.GetOptions().pg);
    #XXX get pg some other way (from the input ??)
end);;

#############
### MulQM ###
#############
### multiplication in the quotient algebra
### <#GAPDoc Label="MulQM">
### <ManSection>
### <Func Name="MulQM" Comm="Multiply an element in the module by an
### element of the quotient algebra"
### Arg="p1, p2, GBR" />
### <Returns>The strong normal form of the product
### <A>p1</A><M>*</M><A>p2</A> with respect to <A>GBR</A>
### </Returns>
### <Description>
### When called with three arguments, the first of which,
### <A>p1</A>, is a module element in NPM format, the second of which,
### <A>p2</A>,
### is a polynomial in NP format representing an element of
### the quotient algebra,
### and the third of which is  a Gröbner basis record <A>GBR</A>,
### this function will return the product
### <C>p1*p2</C> in the module.
### <P/>
### <#Include Label="example-MulQM">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### Arguments:
### GBR         - a Grobner basis
### p1, p2      - two polynomials
###
### Returns:
### ans        - the strong normal form of the product p1*p2 with
###               respect to GBR
###
### uses:    - MulNP, StrongNormalFormNPM
### #MulQM uses: MulNP StrongNormalFormNPM#
### #MulQM is used in: MatrixQA#
###

InstallGlobalFunction( MulQM, function(p1,p2,GBR)

    if (Length(p2[1])=0) then
        # the second argument is zero
        return [[],[]];
    elif ((Length(p2[1][1])>0) and (p2[1][1][1]<0)) then
        # the second argument is a module element (which is invalid)
        Print("ERROR: Right multiplication should be with an element from the algebra.\n");
        return fail;
    else
        return StrongNormalFormNPM(MulNP(p1,p2),GBR);
    fi;
end);;

#################
### BaseQM ###
#################
###
### <#GAPDoc Label="BaseQM">
### <ManSection>
### <Func Name="BaseQM" Comm="Find a basis of the module"
### Arg="GBR, t, mt, maxno" />
### <Returns>A basis of the module obtained from the
### free module of rank <A>mt</A> over the free algebra on <A>t</A> generators
### by factoring out the submodule generated by the elements of <A>GBR</A>
### </Returns>
### <Description>
### When called with a Gröbner basis record <A>GBR</A> (see Section
### <Ref Sect="GBR"/>),
### the number of variables <A>t</A>, the number of module
### generators <A>mt</A>, and a maximum number of terms to be found,
### <A>maxno</A>, the function <C>BaseQM</C>
### will return a (partial) base of the quotient
### module of <M>A^{mt}</M> over the free algebra on <M>A</M> on
### <C>t</C> generators
### by the right sub <M>A</M>-module generated by the elements of <A>GBR</A>.
### Note that the record <A>GBR</A> consists of two fields:
### the list <A>GBR.p</A> of vectors in NPM format representing
### elements of the free module <M>A^{mt}</M>, and the list
### <A>GBR.ts</A> of polynomials in NP format
### representing elements of <M>A</M>. The submodule generated by
### <A>GBR</A> is considered to be the right submodule of
### <M>A^{mt}</M> generated by <A>GBR.p</A> and all
### elements of the form <M>v\cdot np</M> with <M>np</M>
### in the two-sided ideal of <M>A</M> generated by <A>GBR.ts</A>
### and <M>v</M> in <M>A^{mt}</M>.
### If this function is invoked with <A>maxno</A> equal to 0, then a
### full basis will be given.
### <P/>
### If <A>t</A><M>=0</M>, then <C>t</C> will be set to
### the minimal value such that all polynomials of <A>GBR.ts</A>
### and all polynomials occurring in <A>GBR.p</A> have at most <C>t</C> variables.
### <P/>
### If <A>mt</A><M>=0</M>, then <C>mt</C> will be set to
### the minimal value such that all vectors of <A>GBR.p</A> belong to
### <M>A^{mt}</M>.
### <P/>
### If the module is cyclic (that is, has a single generator),
### it is possible to use the Gröbner basis of the ideal
### in the algebra instead of the Gröbner basis record.
### This can be done by entering 0 for the number
### <A>mt</A> of module generators.
### <P/>
### <#Include Label="example-BaseQM">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### returns a basis of terms
### Arguments:
### GBR         - a Grobner basis
### t        - number of elements in the alphabet
### mt        - number of generators of the module
### maxno    - maximum number of terms to be found
###
### Returns:
### ans        - List of terms forming a basis of QA = NP algebra mod G
###
### #BaseQM uses: GBNP.NondivMonsPTS LMonsNP#
### #BaseQM is used in:#
###

InstallGlobalFunction( BaseQM, function(GBR,t,mt,maxno)
    local ans, hlst, i, h, one, mn;
   if t = 0 then
       t := Maximum(NumAlgGensNPList(GBR.ts), NumAlgGensNPList(GBR.p));
   fi;

   if mt = 0 then
        mn := GBR.pg;
   else
        mn := mt;
   fi;

   if Length(GBR.p)>0 then
       if Length(GBR.p[1][2])=0 then
           return [];
       fi;
       one:=One(GBR.p[1][2][1]);
   elif Length(GBR.ts)>0 then
       if Length(GBR.ts[1][2])=0 then
           return [];
       fi;
       one:=One(GBR.ts[1][2][1]);
   elif t>0 then
       # trivial infinite basis
       return "infinite";
   fi;

# amc probeert met 4 args te werken:
# oude versie:
#  hlst := GBNP.NondivMonsPTS(LMonsNP(GBR.p),LMonsNP(GBR.ts),t,GBR.pg,maxno);
# nieuwe versie:
    hlst := GBNP.NondivMonsPTS(LMonsNP(GBR.p),LMonsNP(GBR.ts),t,mn,maxno);
    ans := [];
    for i in [1..Length(hlst)] do
        for h in hlst[i] do
            Add(ans,[[h],[one]]);
        od;
    od;
    return ans;
end);;

################
### DimQM ###
################
### <#GAPDoc Label="DimQM">
### <ManSection>
### <Func Name="DimQM" Comm="Calculates the dimension of the quotient algebra"
### Arg="GBR, t, mt" />
### <Returns>The dimension of the quotient module
### </Returns>
### <Description>
### When called with a Gröbner basis record <A>GBR</A> (see
### Section <Ref Sect="GBR"/>),
### a number
### of variables <A>t</A> at least equal to the number of generators
### involved in the polynomials of <A>GBR.p</A> and <A>GBR.ts</A>,
### and a number of generators <A>mt</A>
### of a free module containing the prefix relations
### in <A>GBR.p</A>, the function <C>DimQM</C>
### will return the dimension over the coefficient field of the
### quotient module of the free right module <M>A^{mt}</M>
### of rank <A>mt</A> over the free algebra
### <M>A</M> on <C>t</C> generators
### by the right sub <M>A</M>-module generated by the elements of <A>GBR</A>,
### if this dimension is finite. Otherwise, the computation invoked by
### the function will not terminate.
### <P/>
### If <A>t</A><M>=0</M>, then <C>t</C> will be set to
### the minimal value such that all polynomials of <A>GBR.ts</A>
### and all polynomials occurring in <A>GBR.p</A> belong to
### <M>A^{mt}</M>.
### <P/>
### If <A>mt</A><M>=0</M>, then <C>mt</C> will be set to
### the minimal value such that all vectors of <A>GBR.p</A> belong to
### <M>A^{mt}</M>.
### <#Include Label="example-DimQM">
### </Description>
### </ManSection>
### <#/GAPDoc>
### Arguments:
### GBR         - a Grobner basis record
### n           - the number of variables
### mn          - the number of elements in the module alphabet
###
### Returns:
### s        - the dimension of the quotient algebra
###
### #DimQM uses: GBNP.NondivMonsPTSenum LMonsNP#
### #DimQM is used in:#
###

InstallGlobalFunction( DimQM, function(GBR,n,mt)
    local s,t0, mn;
    t0 := Runtime();
    if n = 0 then
        n := Maximum(NumAlgGensNPList(GBR.ts), NumAlgGensNPList(GBR.p));
    fi;
    if mt = 0 then
        mn := GBR.pg;
        Info(InfoGBNP,2,"number of prefix generators set to ",mn);
    else
        mn := mt;
    fi;
    if Length(GBR.ts) = 0 and Length(GBR.p)=0 then
        Error("dim is infinite as ideal is trivial.\n");
    fi;
    s := GBNP.NondivMonsPTSenum(LMonsNP(GBR.p),LMonsNP(GBR.ts),n,mn,0);
    Info(InfoGBNPTime,2,"The computation took ",Runtime()-t0," msecs.");
    return s;
end);;
