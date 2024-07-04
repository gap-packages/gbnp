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

### filename = "trunc.gi"
### authors Cohen & Gijsbers

### THIS IS PART OF A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES

### Last change: Sep 23, 2008 amc
### still todo: check if lists start right (0 or 1 for degrees)
### still todo: check if lists end right (at d or d-1 for truncation at d)
### still todo: verify output
### still todo: test GB containing the identity
### Last change: August 13, 2003.
### jwk - split into .gd/.gi and added GAPDoc comments
### Last change: Sep 11, 2001.
### dahg
### Last change: Sep 5, 2001.
### dahg

#functions defined in this file:
#GBNP.ObsTrunc:=function(j,G,lst)
#GBNP.AllObsTrunc:=function(G)
#GBNP.SGrobnerTruncLoop := function(G,todo)
#SGrobnerTrunc:=function(KI,deg,wtv)
#DimsQATrunc:=function(KI,deg,wtv)
#FreqsQATrunc:=function(KI,deg,wtv)
#BaseQATrunc:=function(KI,deg,wtv)
#GBNP.SGrobnerTrunc:=function(KI,deg,wtv,out)
#GBNP.NondivMonsByLevel := function(low,lts,wtv,deg)
#GBNP.WeightedDegreeMon:=function(mon,lst)
#GBNP.WeightedDegreeList:=function(GB,lst)
#GBNP.SGrobnerTruncLevel:=function(KI,wtv,k)
#GBNP.NewLevel:=function(all,wtv,deg)
#GBNP.CheckHom:=function(G,wtv)
#CheckHomogeneousNPs := function(K,wtv);
#GBNP.MakeArgumentLevel:=function(mons,n)



##################
### GBNP.WeightedDegreeMon
### - Computes the weighted degree of a monomial
###
### Arguments:
### mon         - monomial
### lst         - list of weights
###
### Returns:
### ans         - weighted degree of the monomial
###
### #GBNP.WeightedDegreeMon uses:#
### #GBNP.WeightedDegreeMon is used in: GBNP.NewLevel GBNP.ObsTall GBNP.ObsTrunc GBNP.WeightedDegreeList#
###

GBNP.WeightedDegreeMon:=function(mon,lst) local i,ans;
  ans:=0;
  for i in mon do
    ans:=ans+lst[i];
  od;
  return(ans);
end;;


##################
### GBNP.WeightedDegreeList
### - Computes the weighted degrees of a list of monomials
###
### Arguments:
### mon         - set of monomials
### lst         - list of weights
###
### Returns:
### ans         - weighted degree of the monomial
###
### #GBNP.WeightedDegreeList uses: GBNP.WeightedDegreeMon#
### #GBNP.WeightedDegreeList is used in: GBNP.CheckHom#
###

GBNP.WeightedDegreeList:=function(GB,lst) local i,mon,pol,h,ans;
        ans:=[];
        for pol in GB do
          Add(ans,GBNP.WeightedDegreeMon(pol,lst));
        od;
        return(ans);
      end;;



###################################################
### GBNP.NondivMonsByLevel,
### - Computes nondiv. monomials of some degree
###
### Input:
### low - all monomials of degree '< deg'
### lts - leading terms of degree 'deg'
### wtv - weight vector: each variable gets a weight
### deg - degree for which we try to find monomials
###
### Output:
### ans - list of found monomials
###
### #GBNP.NondivMonsByLevel uses: GBNP.OccurInLst#
### #GBNP.NondivMonsByLevel is used in: GBNP.SGrobnerTrunc#
###

GBNP.NondivMonsByLevel:=function(low,lts,wtv,deg)
    local ct, lev, ans, hlp, hlpi, i, t;
### amc: 22 Oct 2008  outcommented because needed for empty input list
### in SGrobnerTrunc
### if Length(lts) = 0 then return "error: empty input list"; fi;

    # if one is in the Grobner basis, then all monomials can be reduced,
    # so return the empty list
    if GBNP.OccurInLst([],lts)[1] > 0 then return []; fi;

    # note : if lts is empty, then all monomials are returned.

    t:=Length(wtv);
    ans := [];
    for i in [1..t] do
       lev:=deg-wtv[i]+1;
       if lev > 0 then
       for hlp in low[lev] do
             hlpi := StructuralCopy(hlp);
             Append(hlpi,[i]);
             if GBNP.OccurInLst(hlpi,lts)[1] = 0 then
                Add(ans,hlpi);
             fi;
       od;
       fi;
    od;
    return(ans);
end;


##################
### GBNP.ObsTrunc
### - Finding all self, left and right obstructions of u, leading term of G[j],
### w.r.t. the list of leading terms of G and of degree k!
###
### Assumptions:
### - Central obstructions are already done, so only self, left and right.
###
### Arguments:
### j           - index of an NP polynomial in G
### G           - list of NP polynomials
### wtv         - weight vector
### k           - the weight level at which we search for obstructions
###
### Returns:
### todo        - new list of S-polynomials. S-polynomials with G[j] added
###
### #GBNP.ObsTrunc uses: GBNP.LeftObs GBNP.RightObs GBNP.SelfObs GBNP.Spoly GBNP.StrongNormalForm2 GBNP.WeightedDegreeMon LMonsNP MkMonicNP#
### #GBNP.ObsTrunc is used in: GBNP.AllObsTrunc#
###

GBNP.ObsTrunc:=function(j,G,todo,wtv,k) local R,sob,ob,obs,spo,nfspo,temp;
   R:=LMonsNP(G);
   sob:=GBNP.SelfObs(j,R);
   obs:=GBNP.LeftObs(j,R,sob);
   Append(obs,GBNP.RightObs(j,R,sob));
   for ob in obs do
     # temp: calculate the total degree of the S polynomial corresponding to ob
     temp := GBNP.WeightedDegreeMon(ob[1],wtv);
     temp := temp + GBNP.WeightedDegreeMon(R[ob[2]],wtv);
     temp := temp + GBNP.WeightedDegreeMon(ob[3],wtv);
# temp:=GBNP.WeightedDegreeMon(Concatenation(ob[1],R[ob[2]],ob[3]),wtv);
     if temp=k then
       spo:=GBNP.Spoly(ob,G);
       if spo <> [[],[]] then
          spo:=GBNP.StrongNormalForm2(spo,G,todo);
          if spo <> [[],[]] then Add(todo,MkMonicNP(spo)); fi;
       fi;
     fi;
   od;
   # temp: calculate the leadin terms of todo, for sorting
   temp:=LMonsNP(todo);
   SortParallel(temp,todo,LtNP);
end;;

##################
### GBNP.AllObsTrunc
### - Computing all obstructions of degree k w.r.t. basis at that time
### (first part of the algorithm).
###
### Assumptions:
### - Central obstructions are already done, so only self, left and right.
###
### Arguments:
### G           - list of NP polynomials
### wtv         - weight vector
### k           - weight level at which we search obstructions
###
### Returns:
### todo        - list of non trivial S-polynomials of (weighted) degree k.
###
### #GBNP.AllObsTrunc uses: GBNP.ObsTrunc GBNP.ReducePol2 LMonsNP#
### #GBNP.AllObsTrunc is used in: GBNP.SGrobnerTruncLevel#
###

GBNP.AllObsTrunc:=function(G,wtv,k) local j,ans,temp;
    ans:=[];
    for j in [1..Length(G)] do
        GBNP.ObsTrunc(j,G,ans,wtv,k);
    od;
    GBNP.ReducePol2(ans);
    temp:=LMonsNP(ans);
    SortParallel(temp,ans,LtNP);
    return(ans);
end;;



##################
### GBNP.SGrobnerTruncLevel
### Buchberger's algorithm (TRUNCATED) with strong normalform
###
### Input: List of polynomials, of degree <= k
###            shape a^2-b  = [[[1,1],[2]],[1,-1]]
### Input: The degree k
###
### Output: Grobner Basis of degree <= k
###
### For level k-1 this is a truncated grobner basis
###
### #GBNP.SGrobnerTruncLevel uses: GBNP.AllObsTrunc GBNP.ReducePol GBNP.ReducePol2 GBNP.SGrobnerTruncLoop#
### #GBNP.SGrobnerTruncLevel is used in: GBNP.SGrobnerTrunc#
###

GBNP.SGrobnerTruncLevel:=function(K,wtv,k) local tt,todo,G;

        tt:=Runtime();

# phase I, start-up, building G

#       Print("number of entered polynomials is ",Length(K),"\n");
        G := GBNP.ReducePol(K);

#       Print("number of polynomials after reduction is ",Length(G),"\n");
        Info(InfoGBNP,2,"End of phase I");

# phase II, initialization, making todo

        todo:=GBNP.AllObsTrunc(G,wtv,k);
        Info(InfoGBNP,2,"End of phase II");

# phase III, The loop

        GBNP.SGrobnerTruncLoop(G,todo,wtv,k);
        Info(InfoGBNP,2,"End of phase III");


# phase IV, make the result reduced

        GBNP.ReducePol2(G);

#    Print("Current number of obstructions is ",Length(OBS),"\n");
#    Print("Current set of spolynomials is ",todo,"\n");
#    Print("Current number of spolynomials is ",Length(todo),"\n");
#    Print("Current set of base polynomials is ",G,"\n");
#    Print("Current number of base leading terms is ",Length(G),"\n");
     Info(InfoGBNPTime,2,"The elapsed time for computing this level of the grobner basis is ",Runtime()-tt," msecs.");
     return(G);
   end;;



##################
### GBNP.NewLevel
### - Returns all (homogeneous) polynomials of degree 'deg'
### contained in 'all'
###
### Arguments:
### all         - set of polynomials
### wtv         - weight vector
### deg         - degree
###
### Returns:
###
### #GBNP.NewLevel uses: GBNP.WeightedDegreeMon#
### #GBNP.NewLevel is used in: GBNP.SGrobnerTrunc#
###

GBNP.NewLevel:=function(all,wtv,deg) local i,ans,l,lev;
        ans:=[];
        for i in all do
          lev:=GBNP.WeightedDegreeMon(i[1][1],wtv);
          if lev = deg then
            Add(ans,i);
          fi;
        od;
        return(ans);
end;;

##################
### GBNP.CheckHom
### - Checks if all polynomials in G are homogeneous.
### (checks for each polynomial of the list if
###  the lengths of all terms of the polynomial are equal
###  and if so, the list of weights of the polynomials)
###
### Arguments:
### G           - set of polynomials
### wtv         - weights of the letters of the alphabet
###
### Returns:
### ans         - list of weights of the pols or false
###
### #GBNP.CheckHom uses: GBNP.WeightedDegreeList LMonsNP#
### #GBNP.CheckHom is used in: CheckHomogeneousNPs GBNP.SGrobnerTrunc#
###

GBNP.CheckHom:=function(G,wtv) local i,j,k,l,mon,h1,h2,ans;
        mon:=LMonsNP(G);
        ans:=GBNP.WeightedDegreeList(mon,wtv);
        for i in [1..Length(G)] do
          h1:=ans[i];
          l:=Length(G[i][1]);
          for j in [2..l] do
            mon:=G[i][1][j];
            h2:=0;
            for k in [1..Length(mon)] do
              h2:=h2+wtv[mon[k]];
            od;
            if h2<>h1 then return(false); fi;
          od;
        od;
        Info(InfoGBNP,1,"Input is homogeneous");
        return(ans);
end;



##################
### CheckHomogeneousNPs
### <#GAPDoc Label="CheckHomogeneousNPs">
### <ManSection>
### <Func Name="CheckHomogeneousNPs" Arg="Lnp, wtv" />
### <Returns>
### A list of weighted degrees of the polynomials if these are homogeneous
### with respect to <A>wtv</A>, and <C>false</C> otherwise.
### </Returns>
### <Description>
### When invoked with a list of NP polynomials <A>Lnp</A> and
### a weight vector <A>wtv</A> (whose entries should be positive integers),
### this function
### returns the list of weighted degrees of the polynomials in
### <A>Lnp</A> if these are all homogeneous and nonzero,
### and <C>false</C> otherwise.
### Here, a polynomial is (weighted) homogeneous with respect to
### a weight vector <M>w</M> if there is constant <M>d</M> such that,
### for each monomial <M>[t_1,...,t_r]</M> of the
### polynomial the sum of all <M>w[t_i]</M> for <M>i</M> in
### <M>[1..r]</M> is equal to  <M>d</M>. The natural number
### <M>d</M> is then called the weighted degree of the polynomial.
### <P/>
### <#Include Label="example-CheckHomogeneousNPs">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Checks if all polynomials in <C>K</C> are homogeneous wrt <C>wtv</C>.
###
### Arguments:
### K           - set of list of NP polynomials
### wtv                 - weight vector
###
### Returns:
### ans         - list of weighted degrees of the pols or false
###
### #CheckHomogeneousNPs uses: CleanNP GBNP.CheckHom#
### #CheckHomogeneousNPs is used in:#
###

InstallGlobalFunction(
CheckHomogeneousNPs, function(K,wtv) local x, hlp, KClean;
      KClean := [];
      for x in K do
        hlp := CleanNP(x);
        if hlp = [[],[]] then
           return(false);
        else Add(KClean,hlp);
        fi;
      od;
      return  GBNP.CheckHom(K,wtv);
end);


############################
### GBNP.SGrobnerTrunc
###
### August 27, 2001
### written by dahg
### Sep 23 2008 redirected by amc
### Oct 22 2008 empty case handled by amc
###
###
### Truncated Grobner Basis
###
### Input:
### K  - basis of the ideal
### deg - max. weight level for the computations
### wtv  - weight vector: a list of length the number of variables
###                      with positive integer entries
###
### out - specify the output as follows:
### (input argument) out = 1  -> output is the grobner basis <= max. degree
### (input argument) out = 2  -> output is list of monomials <= max. degree
### (input argument) out = 3  -> output is list of dimensions <= max. degree
###                             list by degree
### (input argument) out = 0  -> output is list of all above <= max. degree
###
###
### #GBNP.SGrobnerTrunc uses: GBNP.CheckHom GBNP.NewLevel GBNP.NondivMonsByLevel GBNP.ReducePol GBNP.SGrobnerTruncLevel LMonsNP#
### #GBNP.SGrobnerTrunc is used in: BaseQATrunc DimsQATrunc FreqsQATrunc SGrobnerTrunc#
###

GBNP.SGrobnerTrunc :=
 function(K,deg,wtv,out) local t0,G,GB,lts,deg0,dd,dims,pollev,tot,split,arg,deglst,weights,i,temp,ans;

        t0 := Runtime();

# phase I, start-up, building G

        Info(InfoGBNP,1,"number of entered polynomials is ",Length(K));
        G := GBNP.ReducePol(K);

        Info(InfoGBNP,1,"number of polynomials after reduction is ",Length(G));
        Info(InfoGBNP,1,"End of phase I");

        deglst:=GBNP.CheckHom(G,wtv);
        if deglst <> false then
          if deglst = [] then deg0 := deg+1;
          else  deg0:=deglst[1];
          fi;
          if deg0 = 0 then
             if out=1 then
                return([[[[]],[1]]]);
             fi;
             if out=2 then
                # 1 in GB, return [] for degree in 0 .. deg
                return(List([0..deg],dd->[]));
             fi;
             if out=3 then
                # 1 in GB, return 0 for degree in 0 .. deg
                return(List([0..deg],dd->0));
             fi;
             if out=0 then
                return([ [[[]],[1]], List([0..deg],dd->[]), List([0..deg],dd->0)]);
             fi;
          fi;
          dims := [1];
          tot := [1];
          Info(InfoGBNP,2,"Current level is 0");
          Info(InfoGBNP,2,"Number of polynomials of this degree = 1");
          Info(InfoGBNP,2,"Total number of polynomials found sofar = 1");
          ans:=[[[]]];
          dd:=1;
          GB:=GBNP.NewLevel(G,wtv,deg0);
          Info(InfoGBNP,2,"GB na NewLevel ", GB);
          lts:=LMonsNP(GB);
          if deg0 > deg+1 then deg0 := deg+1; fi;
          while dd <= deg do
                Info(InfoGBNP,2,"Current level is ",dd);
                if dd >= deg0 then
                        GB:=GBNP.SGrobnerTruncLevel(GB,wtv,dd);
                        lts:=LMonsNP(GB);
                        Append(GB,GBNP.NewLevel(G,wtv,dd+1));
                        Info(InfoGBNP,2,"GB after append newlevel ", GB);
                fi;
                pollev:=GBNP.NondivMonsByLevel(ans,lts,wtv,dd);
                Add(ans,pollev);
                Add(dims,Length(pollev));
                Info(InfoGBNP,2,"Number of monomials of this degree = ",dims[dd+1]);
                Add(tot,tot[dd]+dims[dd+1]);
                Info(InfoGBNP,2,"Total number of monomials found so far = ",tot[dd+1]);
                dd:=dd+1;
                Info(InfoGBNP,2,"GB at the end of the while loop: ", GB);
          od;
        Info(InfoGBNP,1,"Reached level ",deg);
        Info(InfoGBNP,1,"end of the algorithm");

        else
          Info(InfoGBNP,1,"Input is not homogeneous");
          return(false);
        fi;
        Info(InfoGBNPTime,1,"The computation took ",Runtime()-t0," msecs.");
        if out = 1 then return(GB); fi;
        if out = 2 then return(ans); fi;
        if out = 3 then return(dims); fi;
        if out = 0 then return([GB,ans,dims]); fi;
end;



##################
### GBNP.MakeArgumentLevel
### - Is used for computing the frequencies and multiplicities
### of the quotient algebra
### for a set of monomials occurring in a truncated standard basis
###
### Arguments:
### mons                - set of monomials
### n                   - number of variables
###
### Returns:
### ans         - list of pairs of frequencies of the quotient algebra
###               ***check validity***
###
### #GBNP.MakeArgumentLevel uses: GBNP.OccurInLst#
### #GBNP.MakeArgumentLevel is used in: FreqsQATrunc#
###

GBNP.MakeArgumentLevel:=function(mons,n) local i,hlp,mon,ans,arg;
        if mons=[[]] then return([[[],1]]); fi;
        if mons=[] then return(mons); fi;
        ans:=[];
        for mon in mons do
           arg:=List([1..n],x->0);
           for i in mon do
             arg[i]:=arg[i]+1;
           od;
           hlp:=GBNP.OccurInLst(arg,List(ans,x->x[1]));
           if hlp[1] <> 0 then
              ans[hlp[1]][2]:=ans[hlp[1]][2]+1;
           else
              Add(ans,[arg,1]);
           fi;
        od;
        arg:=List(ans,x->x[1]);
        SortParallel(arg,ans,GtNP);
        return(ans);
   end;


###amc global1
##################
### SGrobnerTrunc
### <#GAPDoc Label="SGrobnerTrunc">
### <ManSection>
### <Func Name="SGrobnerTrunc"  Arg="Lnp, deg, wtv" />
### <Returns>
### A list of homogeneous NP polynomials if the first argument
### of the input is a list of homogeneous NP polynomials, and the
### boolean <C>false</C> otherwise.
### </Returns>
### <Description>
### This functions should be
### invoked with a list <A>Lnp</A> of polynomials in NP format,
### a natural number <A>deg</A>, and a weight vector <A>wtv</A>
### of length the number of generators of the free algebra
### <M>A</M> containing the elements of <A>Lnp</A>,
### and with positive integers for entries.
### If the polynomials of <A>Lnp</A> are homogeneous with respect
### to <A>wtv</A>,
### the function will return a Gröbner basis of <A>Lnp</A>
### truncated above <A>deg</A>.
### If the list of polynomials <A>Lnp</A> is not homogeneous with respect
### to <A>wtv</A>,
### it returns <C>false</C>.
### The homogeneity check can be carried out
### by <Ref Func="CheckHomogeneousNPs" Style="Text"/>.
### <P/>
### <#Include Label="example-SGrobnerTrunc">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### Arguments:
### K           - list of homogeneous polynomials with respect to wtv
### deg         - the degree beyond which the polynomials are to be truncated
### wtv         - weight vector
###
### Returns:
### G           - list of homogeneous pols wrt wtv forming a truncated Grobner
###               basis or false
### #SGrobnerTrunc uses: GBNP.SGrobnerTrunc#
### #SGrobnerTrunc is used in:#
###

InstallGlobalFunction(
SGrobnerTrunc, function(K,deg,wtv)
      return  GBNP.SGrobnerTrunc(K,deg,wtv,1);
end);

###amc global2
##################
### BaseQATrunc
### <#GAPDoc Label="BaseQATrunc">
### <ManSection>
### <Func Name="BaseQATrunc" Arg="Lnp, deg, wtv" />
### <Returns>
### A list of monomials if the first argument
### of the input is a list of homogeneous NP polynomials or <C>false</C>.
### </Returns>
### <Description>
### When invoked with a list of polynomials <A>Lnp</A>,
### a natural number <A>deg</A>, and a weight vector <A>wtv</A>
### of length the number of variables and with positive integers for entries,
### such that the polynomials of <A>Lnp</A> are homogeneous with respect
### to <A>wtv</A>,
### it returns a list whose <M>i</M>-th entry
### is a basis of monomials of the homogeneous part of
### degree <M>i-1</M>
### the quotient algebra of the
### free noncommutative algebra by the weighted
### homogeneous ideal generated by <A>Lnp</A>
### truncated above <A>deg</A>.
### If the list of polynomials <A>Lnp</A> is not homogeneous,
### it returns <C>false</C>.
### <P/>
### <#Include Label="example-BaseQATrunc">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### Arguments:
### K           - list of homogeneous polynomials with respect to wtv
### deg         - the degree beyond which the polynomials are to be truncated
### wtv         - weight vector
###
### Returns:
### ans         - list of monomials or false
###
### #BaseQATrunc uses: GBNP.SGrobnerTrunc#
### #BaseQATrunc is used in:#
###

InstallGlobalFunction(
BaseQATrunc, function(K,deg,wtv)
      return  GBNP.SGrobnerTrunc(K,deg,wtv,2);
end);

###amc global3
##################
### DimsQATrunc
### <#GAPDoc Label="DimsQATrunc">
### <ManSection>
### <Func Name="DimsQATrunc" Arg="Lnp, deg, wtv" />
### <Returns>
### A list of monomials if the first argument
### of the input is a list of homogeneous NP polynomials or <C>false</C>.
### </Returns>


### <Description>
### When invoked with a list of polynomials <A>Lnp</A>,
### a natural number <A>deg</A>, and a weight vector <A>wtv</A>
### of length the number of variables and with positive integers for entries,
### such that the polynomials of <A>Lnp</A> are homogeneous with respect
### to <A>wtv</A>,
### it returns a list of dimensions of the homogeneous parts of
### the quotient algebra of the
### free noncommutative algebra by the ideal generated by <A>Lnp</A>
### truncated above <A>deg</A>. The <M>i</M>-th entry of the list gives
### the dimension of the homogeneous part of degree <M>i-1</M>
### of the quotient algebra.
### If the list of polynomials <A>Lnp</A> is not homogeneous,
### it returns <C>false</C>.
### <P/>
### <#Include Label="example-DimsQATrunc">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### Arguments:
### K           - list of homogeneous polynomials with respect to wtv
### deg         - the degree beyond which the polynomials are to be truncated
### wtv         - weight vector
###
### Returns:
### ans         - list of monomials or false
###
### #DimsQATrunc uses: GBNP.SGrobnerTrunc#
### #DimsQATrunc is used in:#
###

InstallGlobalFunction(
DimsQATrunc,  function(K,deg,wtv)
        return GBNP.SGrobnerTrunc(K,deg,wtv,3);
end);


#***functies moet hoofdletter
#****vars met kleine


###amc global4
##################
### FreqsQATrunc
### <#GAPDoc Label="FreqsQATrunc">
### <ManSection>
### <Func Name="FreqsQATrunc"  Arg="Lnp, deg, wtv" />
### <Returns>
### A list of multiplicities of frequencies of monomials if the first argument
### of the input is a list of homogeneous polynomials in NP format,
### and <C>false</C>
### otherwise.
### </Returns>
### <Description>
### The frequency of a monomial is the list
### of numbers of occurrences of a variable in the monomial
### for each variable; the
### multiplicity of a frequency is the number of monomials in the standard
### basis for a quotient algebra with this frequency.
### When invoked with a list  <A>Lnp</A> of polynomials in NP format
### representing a (truncated) Gröbner basis,
### a natural number <A>deg</A>, and a weight vector <A>wtv</A>
### of length the number of variables and with positive integers for entries,
### such that the polynomials of <A>Lnp</A> are homogeneous with respect
### to <A>wtv</A>,
### it returns a list of frequencies occurring with their multiplicities
### for the quotient algebra of the
### free noncommutative algebra by the ideal generated by <A>Lnp</A>
### truncated above <A>deg</A>.
### The <M>i</M>-th entry of the list gives
### the frequencies of the weight <M>(i-1)</M> basis monomials
### of the quotient algebra.
### If the list of polynomials <A>Lnp</A> is not homogeneous with respect to
### <A>wtv</A>, it returns <C>false</C>.
### <P/>
### <#Include Label="example-FreqsQATrunc">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### Arguments:
### K           - list of homogeneous polynomials with respect to wtv
### deg         - the degree beyond which the polynomials are to be truncated
### wtv         - weight vector
###
### Returns:
### ans         - list of monomials or false
###
### #FreqsQATrunc uses: GBNP.MakeArgumentLevel GBNP.SGrobnerTrunc#
### #FreqsQATrunc is used in:#
###

InstallGlobalFunction(
FreqsQATrunc, function(K,deg,wtv) local i,j,ob,ans, dims, lst, hlp, GBf;
        GBf := GBNP.SGrobnerTrunc(K,deg,wtv,0);
        if GBf = false then return(false); fi;
        lst := GBf[2];
        dims := GBf[3];
#       Print("The number of variables is ",Length(wtv),"\n");
#       Print("The weights of the variables are ",wtv,"\n\n");
        j:=Length(dims);
        i:=0;
        ans := [];
        while i < j do
           Info(InfoGBNP,2,"The dimension of the homogeneous part of the quotient algebra of this degree ", i," is ",dims[i+1]);
           if Length(lst)>0 then
             hlp:=GBNP.MakeArgumentLevel(lst[i+1],Length(wtv));
           else hlp := [];
           fi;
           if hlp = [] then
           Info(InfoGBNP,2,"No monomials of this weighted degree occur\n");
           else
             Add(ans,hlp);
             for ob in hlp do
               Info(InfoGBNP,2,"The frequency ",ob[1]," occurs ",ob[2]," times\n");
             od;
           fi;
#          Print("\n");
           i:=i+1;
        od;
        return(ans);
end);
