######################### BEGIN COPYRIGHT MESSAGE #########################
# GBNP - computing Gröbner bases of noncommutative polynomials
# Copyright 2001-2009 by Arjeh M. Cohen, Dié A.H. Gijsbers, Jan Willem
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

### filename = "fincheck.gi"
### author: Chris Krook
### This is an add on for the GBNP package, since version 0.8.3

# This files contains some functions to investigate the growth of a
# monomial algebra. (The growth of the quotient algebra by an ideal with
# Grobner basis GB is equal to the growth of the quotient algebra by an ideal
# of the basis GB' where GB' contains the leading terms of B.)
# Let M be a set of monomials, no monomial of which divides another one
# (this is trivially satisfied for leading terms of a Grobner basis. As an
# input one can just use LMonsNP(GB) from the Grobner Basis computation)
# which determine the algebra. Let n be the alphabet size.
#
# One can:
# 1. determine whether a monomial algebra is finite or infinite dimensional
#    USE: FinCheckQA(M,n);
# 2. determine the growth of a monomial algebra (finite, [d_min,d_max]:polynomial
#    growth of degree d s.t. d_min<=d<=d_max, exponential growth)
#    USE: DetermineGrowthQA(M,n);
# 3. compute partial Hilbert Series
#    USE: HilbertSeriesQA(M,n);
# NB The steps 1 and 2 allow preprocessing which can give faster results.
#    USE: PreprocessAnalysisQA(M,n,k);
#         where k is the number of recursion steps (0 is maximal recursion)
# See the explanation in the preprint "The dimensionality of quotient algebras"
# and examples 13-17 for more information

# functions that are defined in this file:
# GBNP.Incr                     :=function(u,l,n)
# GBNP.IncrT                    :=function(u,l,n,Tree,lnorm)
# PreprocessAnalysisQA                  :=function(ulist,alphabetsize,nrecs);
# FinCheckQA                    :=function(F,n)
# DetermineGrowthQA             :=function(F,n)
# HilbertSeriesQA                       :=function(O,n,d)
#   HilbertSeriesQA starts from a set of obstructions.

##################
### GBNP.Incr
### - Increments a monomial u[1..l].
###   i.e. computes the smallest monomial
###   v s.t. v>u and length(v)<=length(u).
###
### Arguments:
### u                   - monomial
### l                   - length of u
### n                   - alphabet size
###
### Assumption:
###  u is non-empty and is not maximal in the sense described above
###
### Returns:
###  incremented u.
###
### #GBNP.Incr uses:#
### #GBNP.Incr is used in: DetermineGrowthQA#
###

GBNP.Incr:=function(u,l,n);
        while u[l]=n do
        Unbind(u[l]);
          l:=l-1;
        od;
        u[l]:=u[l]+1;
        return(l);
end;

##################
### GBNP.IncrT
### - Increments a monomial u[1..l], simultaneously adding words to
### the tree that we should not consider anymore. This is the
### improvement suggested in the paper.
###
### Arguments:
### u                   - monomial
### l                   - length of u
### n                   - alphabet size
### Tree                - a tree of reversed obstructions
### lnorm               - -1+ the length of the largest monomial in our
###                       obstructional set
### Assumption:
###  u is non-empty and is not maximal in the sense described above
###
### Returns:
###  incremented u. As a side-effect it might alter the tree T
###
### uses:               - GBNP.RedAddToTree     (tree.g)
###
### #GBNP.IncrT uses: GBNP.RedAddToTree#
### #GBNP.IncrT is used in: FinCheckQA#
###

GBNP.IncrT:=function(u,l,n,Tree,lnorm);
        while u[l]=n and l-lnorm>1 do
          GBNP.RedAddToTree(u{[l-lnorm..l-1]},Tree.tree,n);
          Unbind(u[l]);
          l:=l-1;
        od;
        while u[l]=n do
          Unbind(u[l]);
          l:=l-1;
        od;
        u[l]:=u[l]+1;
        return(l);
end;

##################
### PreprocessAnalysisQA
### <#GAPDoc Label="PreprocessAnalysisQA">
### <ManSection>
### <Func Name="PreprocessAnalysisQA" Comm="computes the left-reduced set for some monomial obstructional set" Arg="Lm, t, iterations" />
### <Returns>
### The left-reduced list of `obstructions',
### obtained by applying left-reduction
### recursively
### </Returns>
### <Description>
### This preprocessing of the list <A>Lm</A>
### of monomials can be applied to the set of
### leading terms of a Gröbner basis before calling the functions
### <Ref Func="FinCheckQA" Style="Text"/> or <Ref Func="DetermineGrowthQA"
### Style="Text"/>, in order
### to speed up calculations using these
### functions. As the name suggests,
### <A>t</A> should be the size of the alphabet.
### The parameter <A>iterations</A> gives the maximum number of recursion
### steps in the preprocessing (<A>0</A> means no restriction).
### For more information about this function see <Cite Key="Krook2003"/>.
### <P/>
### <#Include Label="example-PreprocessAnalysisQA">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - computes the left-reduced set for some monomial obstructional
###   set.
###
### Arguments:
### ulist               - a list of obstructions
### alphabetsize        - the alphabet size
### nrecs               - the number of reductions you want maximally
###                       k=0 -> no restraint
###
### Returns:
### - the left-reduced list of obstructions, obtained by applying
###   left-reduction recursively.
###
### #PreprocessAnalysisQA uses: GBNP.RedAddToTree GBNP.TreeToList#
### #PreprocessAnalysisQA is used in:#
###

InstallGlobalFunction(
PreprocessAnalysisQA,function(ulist,alphabetsize,nrecs) local Tree,u,v,L;
      # special case: 1 already in list of monomials, discard the rest
      if [] in ulist then
        return [[]];
      fi;

        Tree:=[];
        # Add the obstructions to the tree
        for u in ulist do
          GBNP.RedAddToTree(u,Tree,alphabetsize);
        od;

        # Perform recursively steps of left-reduction
      repeat

          # Keep track of number of recursions
          nrecs:=nrecs-1;

          # Look for branches u,v s.t. u[2..|u|]=v[2..|v|] in order
          # to (hopefully) create full subtrees.
          L:=ShallowCopy(ulist);
          for u in ulist do
            for v in ulist do
                if Length(u)<Length(v) then
                  if u{[2..Length(u)]}=v{[2..Length(u)]} then
                    GBNP.RedAddToTree(Concatenation(u,v{[Length(u)+1..Length(v)]}),Tree,alphabetsize);
                  fi;
                fi;
            od;
          od;

          # Compute the new obstructional set.
        ulist:=GBNP.TreeToList(Tree,[],[]);
#         Print("recursionstep ",nrecs,": ",Length(ulist)," \n");

        # Terminate when we have performed nrecs recursions or ulist
        # is left-reduced.
        until nrecs=0 or Length(ulist)=Length(L) and ulist=L;
        return(ulist);
end);;


##################
### FinCheckQA
###
### <#GAPDoc Label="FinCheckQA">
### <ManSection>
### <Func Name="FinCheckQA" Comm="determine whether a monomial algebra is finite or infinite dimensional" Arg="Lm, t" />
### <Returns>
### <Code>true</Code>, if the quotient algebra is finite dimensional and<Code>
### false</Code> otherwise
### </Returns>
### <Description>
### Given a list <A>Lm</A> of  leading monomials such that
### none of these divides another,
### and the number <A>t</A> of generators of a free algebra
### in which they are embedded,
### this function checks whether the quotient algebra
### of the free algebra
### by the ideal generated by <A>Lm</A> is finite dimensional.
### <P/>
### When given a Gröbner basis <M>G</M>,
### the dimension of the quotient algebra of the free algebra by
### the ideal generated by <M>G</M> coincides with the
### the dimension of the quotient algebra of the free algebra by
### the ideal generated by the leading terms of elements of <M>G</M>.
### These can be obtained from <M>G</M>
### with the function <Ref Func="LMonsNP" Style="Text"/>.
### <P/>
### The function <C>FinCheckQA</C>
### allows for preprocessing
### with the function <Ref Func="PreprocessAnalysisQA" Style="Text"/>.
### This may speed up the computation.
### <P/>
### <#Include Label="example-FinCheckQA">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### - Checks if the factor algebra obtained by a GB F
### of some set of relations is finite dimensional.
###
### Arguments:
### F                   - Leading monomials of some Grobner basis
### n                   - alphabet size
###
### Assumption:
### -a monomial in F is of the form [1,2,3] denoting xyz where x<y<z.
### -F doesn't contain letters that are not in the alphabet.
###
### Returns:
### true                - if factor algebra is finite dimensional
### false               - else.
###
### #FinCheckQA uses: GBNP.CreateOccurTreeLR GBNP.IncrT GBNP.LookUpOccurTreePTSLRPos GBNP.Occur#
### #FinCheckQA is used in:#

InstallGlobalFunction(
FinCheckQA,function(F,n) local  j, word, marker, period,
                                  maxlength, l, lnorm, increment,
                                  FTree, pos, i;
  # INITIALISE

        word:=[1];                      # Start with smallest nonempty
        l:=1;                           # length of the word
        marker:=1;                      # word and put marker on 1st pos.
        period:=1;                      # Contains the length of the word
                                        # w if the marker is on 1. This is
                                        # the period.
        j:=1;                           # Relevancy to the first relation.

        if F=[]
        then
          return(false);
        else
          if F[1]=[] then
            return (true);
          fi;
        fi;

        # lnorm is the length of the normal words our graph will
        # consist of.
        lnorm:=Maximum(List(F,Length))-1;

        # Create the Tree
        FTree:=GBNP.CreateOccurTreeLR(F,false);

        while true do

  # CHECK WORDS
          if not GBNP.LookUpOccurTreePTSLRPos(word,FTree,false,1)=0 then

            # Either finite or increase word.
            if word[1]=n then return(true);
            else
                increment:=true;
            fi;
          else
            if l>=lnorm then
                if not GBNP.Occur(word{[l-lnorm+1..l]},word)=l-lnorm+1 then
                  return(false);
                fi;
            fi;
            increment:=false;
          fi;

 # ADJUST WORDS
          if increment then
            # Find greater monomial of same or smaller length
            # Also update the tree.
            l:=GBNP.IncrT(word,l,n,FTree,lnorm);
            marker:=1;
            period:=ShallowCopy(l);

          else
            # Lengthen word
            l:=l+1;
            word[l]:=word[marker];
            marker:=marker+1;

          fi;
        od;
end);


##################
### DetermineGrowthQA
###
### <#GAPDoc Label="DetermineGrowthQA">
### <ManSection>
### <Func Name="DetermineGrowthQA" Comm=" determine the growth of a monomial
### algebra
### (finite, polynomial growth of degree d, exponential growth)" Arg="Lm, t, exact" />

### <Returns>
### If the quotient algebra is finite dimensional, then
### the integer <Code>0</Code> is
### returned. If the growth is polynomial and the algorithm found a precise
### degree <C>d</C> of the growth polynomial, then <C>d</C> is returned.
### If the growth is polynomial and no precise answer is found,
### an interval <C>[d1,d2]</C> is returned in which the dimension lies.
### If the growth is exponential, the string <C>"exponential growth"</C> is
### returned.
### </Returns>
### <Description>
### Given leading monomials <A>Lm</A> of some Gröbner basis (these can be
### obtained with the function <Ref Func="LMonsNP" Style="Text"/>),
### the number <A>t</A>
### of generators of a free algebra, say <M>A</M>, in which the monomials lie,
### and a boolean <A>exact</A>,
### this function checks whether the quotient algebra of <M>A</M>
### by the ideal generated by <A>Lm</A> is finite
### dimensional. In doing so it constructs a graph of normal words which helps
### with the computations.
### It also checks for exponential or polynomial growth in the infinite case.
### <P/>
### If the precise degree is needed in the polynomial case, the argument
### <A>exact</A> should be set to <C>true</C>.
### <P/>
### The function <C>DetermineGrowthQA</C>
### allows preprocessing, which may speed up the computations.
### This can
### be done with the function <Ref Func="PreprocessAnalysisQA" Style="Text"/>.
### <P/>
### <#Include Label="example-DetermineGrowthQA">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### - Checks if the factor algebra obtained by a GB F
### of some set of relations is finite dimensional.
### In doing so we construct a graph of normal words which
### helps with the computations.
### Also checks for exponential or polynomial growth in the
### infinite case.
###
### Arguments:
### F                   - Leading monomials of some Grobner basis
### n                   - alphabet size
### exact               - a Boolean indicating whether or not the
###                       exact polynomial growth exponent is required
###
### Assumption:
### -a monomial in F is of the form [1,2,3] denoting xyz where x<y<z.
### -F does not contain letters that are not in the alphabet.
###
### Returns:
### true                - if factor algebra is finite dimensional
### false               - else.
###
### #DetermineGrowthQA uses: DetermineGrowthObs GBNP.CreateOccurTreeLR GBNP.Incr GBNP.LookUpOccurTreePTSLRPos GBNP.NumAlgGensNPmonList#
### #DetermineGrowthQA is used in:#
###

InstallGlobalFunction(
DetermineGrowthQA,function(F,t,exact) local  i, j, word, marker, period, maxlength, l, lnorm, graph, suffix,
                                           inf, FTree, cycle, pos, increment,
                                           cl, maxcl, donelist, n, totalcl;

#amc Obs case built in:
 if exact then return DetermineGrowthObs(F,t); fi;

# INITIALISE

        word:=[1];                      # Start with smallest nonempty
        l:=1;                           # length of the word
        marker:=1;                      # word and put marker on 1st pos.
        period:=1;                      # Contains the length of the word
                                        # w if the marker is on 1. This is
                                        # the period.
        j:=1;                           # Relevancy to the first relation.
        graph:=[];                      # Vertexset of the graph of normal
                                        # words starts empty.
        inf:=false;                     # we don't assume infinity immediately
        cycle:=[];                      # we don't have cycles yet
        cl:=0;                          # cl is the number of disjunct cycles;
        maxcl:=0;                       # maxcl is the maximum number of
                                        # disjunct cycles encountered on a
                                        # path so far
        totalcl:=0;                     # totalcl is the total number of
                                        # cycles encountered so far
        donelist:=[];                   # keeps words we need not check again.

        if t>0 then                     # set n: number of generators
          n:=t;                         # use the input value
        else                            # attempt to guess the value from F
          n:=GBNP.NumAlgGensNPmonList(F);
        fi;

        if F=[] then
          if n=1 then
#           Print("infinite: polynomial growth of degree ");
            return(1);
          else
            return ("exponential growth");
          fi;
        else
          if F[1]=[] then
            return (0);
          fi;
        fi;

        # lnorm is the length of the normal words our graph will
        # consist of. if lnorm=0 then we can instantly decide.
        lnorm:=Maximum(List(F,Length))-1;
        if lnorm=0 then
          if Length(F)=n then return(0);
          elif Length(F)=n-1 then
#           Print("infinite: polynomial growth of degree ");
            return(1);
          else
            return ("exponential growth");
          fi;
        fi;

        # Create the Tree
        FTree:=GBNP.CreateOccurTreeLR(F,false);

# CHECK WORDS
        while true do
          if not GBNP.LookUpOccurTreePTSLRPos(word,FTree,false,1)=0 then

            # Either finite/infinite or increment word.
            if word[1]=n then
                if inf then
#                 Print("infinite: polynomial growth of degree ");
                  if maxcl<>totalcl then
                    #Print(totalcl," <= d <= ",Length(donelist),"\n");
                    return([maxcl,totalcl]);
                  else
#                   Print("d = ",maxcl,"\n");
                    return(maxcl);
                  fi;
                else
#                 return(0);
# changed to 0 by amc to accord with DetermineGrowthObs and poly of degree 0.
                  return(0);
                fi;
            else
                increment:=true;
            fi;
          else

            # word is normal, can be lengthened
            if l>=lnorm then
                suffix:=word{[l-lnorm+1..l]};
                if Position(donelist,suffix)=fail then
                  pos:=Position(graph,suffix);
                  if pos=fail then
                    # Add new normalword to the graph-list
                    Add(graph,suffix);
                    increment:=false;
                  else
                    # Check for exponential growth;i.e. cycles intersect:
                    for i in cycle do
                      if pos>=i[1] and pos<=i[2] then
                          return ("exponential growth");
                      fi;
                    od;

                    # Add a cycle
                    Add(cycle,[pos,Length(graph)]);
                    cl:=cl+1;
                    totalcl:=totalcl+1;

                    if word[1]=n then
#                     Print("infinite: polynomial growth of degree ");
                      if maxcl<>totalcl then
#                         Print(maxcl," <= d <= ",Length(donelist),"\n");
                          return([maxcl,totalcl]);
                      else
                          if maxcl=0 then maxcl:=1; fi;
#                         Print("d = ",maxcl,"\n");
                          return(maxcl);
                      fi;
                    fi;
                    increment:=true;
                    inf:=true;
                  fi;
                else
                  if word[1]=n then
#                   Print("infinite: polynomial growth of degree ");
                    if maxcl<>totalcl then
#                       Print(maxcl," <= d <= ",totalcl,"\n");
                        return([maxcl,totalcl]);
                    else
#                       Print("d = ",totalcl,"\n");
                        return(maxcl);
                    fi;
                  fi;
                  increment:=true;
                fi;
            else
                increment:=false;
            fi;
          fi;

# ADJUST THE WORD
          if increment then

            # Find greater monomial of same or smaller length
            l:=GBNP.Incr(word,l,n);
            marker:=1;
            period:=ShallowCopy(l);

            # Adapt the list cycle
            i:=1;
            if maxcl<=cl then maxcl:=cl; fi;
            while i<=cl do
                if cycle[i][1]>l-lnorm then
                  AddSet(donelist,graph[cycle[i][1]]);
                  RemoveElmList(cycle,i);
                  cl:=cl-1;
                else i:=i+1;
                fi;
            od;
            for i in [1..cl] do
                cycle[i][2]:=
                  Minimum(l-lnorm,cycle[i][2]);
            od;
            # Drop the elements from the graphlist that are no longer
            # on the route.
            graph:=graph{[1..l-lnorm]};
          else
            # Lengthen word
            l:=l+1;
            word[l]:=word[marker];
            marker:=marker+1;
          fi;
        od;
end);


###################################
### function HilbertSeriesQA
### <#GAPDoc Label="HilbertSeriesQA">
### <ManSection>
### <Func Name="HilbertSeriesQA" Comm="compute partial Hilbert series" Arg="Lm, t, d" />
### <Returns>
### A list of coefficients of the Hilbert series up to degree <A>d</A>
### </Returns>
### <Description>
### Given a set of monomials <A>Lm</A>, none of which divides another,
### and the number  <A>n</A>
### of generators of the free algebra in which they occur,
### this function computes the Hilbert series up to
### a given degree <A>d</A>.
### <P/>
### Internally, it builds (part of) the
### graph of standard words. <!--Advantage over separate use of
### <Ref Func="GraphOfChains" Style="Text"/> and <Ref Func="HilbertSeriesG"/>
### (which are described above)
### is that in case of a big graph, only a part needs to be constructed.-->
### This function will remove zeroes from the end of the list of coefficients.
### <P/>
### <#Include Label="example-HilbertSeriesQA">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Given a set of obstructions, it computes the Hilbert series up to
### a given degree d. While at the same time it builds (part of) the
### graph of normal words. Advantage over separate use of
### GraphOfChains and HilbertSeriesG (which can be found in the file
### graphs.g) is that in case of a big graph, only part needs to be
### constructed.
###
###
### Arguments:
### O                   - Set of obstructions
### n                   - The alphabet size
### d                   - degree up to which you want Hilbert series
###
### Returns:
### - List of coefficients of the Hilbert series up to
###   degree d
###
### #HilbertSeriesQA uses: GBNP.CreateOccurTreeLR GBNP.FormalSum GBNP.LookUpOccurTreeForObsPTSLR GBNP.OccurInLstPTSLR#
### #HilbertSeriesQA is used in:#
###

InstallGlobalFunction(
HilbertSeriesQA,function(O,n,d) local ESet,VSet,LSet,
                                i,j,k,m,ot,pos,C1,C2,CList,
                                alpha,graphcomp,L,T,Tleft,
                                overlap,oldd;

        # special case : O = [[]];
        if O = [[]] then
          # 1 in Gröbner basis
          # -> zero-dimensional quotient algebra
          # -> all entries are zero, and can be removed
          return [];
        fi;

        # Initialize edge set and vertex set and length set;
        ESet:=[];
        VSet:=List([1..n],x->[x]);
        LSet:=List([1..n],x->1);

        # Create tree of obstructions
        T:=GBNP.CreateOccurTreeLR(O,false);

        # Create left-tree of obstructions
        Tleft:=GBNP.CreateOccurTreeLR(O,true);

        # Initialize the 0-chains
        C1:=[]; C2:=[];
        for i in [1..n] do
          C1[i]:=[1];
        od;
        CList:=[1,-n];

        # compute the i-1 chains
        i:=2;   alpha:=1;
    while true do

        graphcomp:=true;
        for j in [1..Length(C1)] do
         if IsBound(C1[j]) then

          if not IsBound(ESet[j]) then

            # First encounter, thus create the graph further.
            graphcomp:=false; # graph was not complete yet
            ESet[j]:=[];

            # Use the left tree to find all the overlaps
            overlap:=GBNP.LookUpOccurTreeForObsPTSLR(VSet[j],0,Tleft,true);
            for k in overlap do
                 ot:=O[k[1]]{[Length(VSet[j])+2-k[2]..Length(O[k[1]])]};
                 if GBNP.OccurInLstPTSLR(Concatenation(VSet[j],ot){[1..LSet[j]+Length(ot)-1]},T,false)=[0,0] then
                  pos:=Position(VSet,ot);
                  if pos=fail then
                    Add(VSet,ot);
                    Add(LSet,Length(ot));
                    pos:=Length(VSet);
                  fi;
                  Add(ESet[j],pos);
                 fi;
            od;
          fi;

          # Graph already exists, compute series further.
          for k in ESet[j] do
            if not IsBound(C2[k]) then C2[k]:=[]; fi;
            for m in C1[j] do
                if m+LSet[k]<=d then
                  Add(C2[k],m+LSet[k]);
                fi;
            od;
            if C2[k]=[] then Unbind(C2[k]); fi;
          od;
         fi;
        od;

          # Update Hilbertseries
          L:=Collected(Flat(C2));
          for j in L do
            if not IsBound(CList[j[1]+1]) then
                CList[j[1]+1]:=alpha*j[2];
            else
                CList[j[1]+1]:=CList[j[1]+1]+alpha*j[2];
            fi;
          od;

          # If degree is reached, return part of Hilbertseries
          # store old max degree in oldd
          oldd:=d;
          if L=[] or L[1][1]>=d then
            while not IsBound(CList[d+1]) or CList[d+1]=0 do
                d:=d-1;
            od;
            while Length(CList)>d+1 do
                Unbind(CList[Length(CList)]);
            od;

#           # Possible output of the graph itself
#           Print("Graph was ");
#           if not graphcomp then Print("not"); fi;
#           Print(" complete in the previous step. \n");
#           Print([VSet,ESet,LSet]);
            return(GBNP.FormalSum(CList,oldd));
          fi;

          # Consider chains of higher length
          C1:=ShallowCopy(C2);
          C2:=[];
          i:=i+1;
          alpha:=-1*alpha;
    od;
end);
