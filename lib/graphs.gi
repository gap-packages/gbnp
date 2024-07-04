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

### filename = "graphs.gi"
### author: Chris Krook
### This is an add-on for the GBNP package, since version 0.8.3

# This file contains some auxiliary functions used by the file fincheck.g
# for the purpose of Hilbert Series calculations. Moreover it contains
# functions for the creation of some graphs that are closely related to
# monomial algebras.
# 1. GraphOfNormalWords(M,n)
# 2. GraphOfChains(M,n)
# (see preprint "The dimensionality of quotient algebras")
# NB Since the Hilbert Series computation is based on the construction of
# the Graph of Chains; knowledge of this graph makes Hilbert Series
# computation faster. One can use the function HilbertSeriesG to calculate
# partial Hilbert Series if the Graph Of Chains is given.
# Without knowledge of this graph we use the function HilbertSeriesQA from
# the file fincheck.g


# functions that are defined in this file:
# GBNP.ConstantRow      :=function(l,c)
# GBNP.IncidenceMatrix  :=function(EdgeSet,n)
# GBNP.FormalSum        :=function(CList,d)
# GraphOfNormalWords    :=function(O,n)
# GBNP.ReduceMatrix     :=function(M,l,i,cycle)
# GBNP.DetermineGrowthQA        :=function(M)
# DetermineGrowthObs    :=function(O,n)
# GraphOfChains         :=function(O,n)
# HilbertSeriesG        :=function(ESet,VSet,n,d)
#   HilbertSeriesG (G=graph) starts from a complete graph of chains.


######################################
### function GBNP.ConstantRow
### - Produces constant list [c,c,...,c] of length l
###
### #GBNP.ConstantRow uses: GBNP.ConstantRow#
### #GBNP.ConstantRow is used in: GBNP.ConstantRow GBNP.DetermineGrowthQA GBNP.IncidenceMatrix#
###

GBNP.ConstantRow:=function(l,c)
        if l<>0 then return(Concatenation(GBNP.ConstantRow(l-1,c),[c]));
        else return([]);
        fi;
end;


######################################
### function GBNP.IncidenceMatrix
### - Computes the incidencematrix for a set of edges and a number of
###   vertices n.
###
### Arguments:
### EdgeSet             - set of edges [i,j] denoting i->j
### n                   - number of vertices. Should be >= than
###                       biggest number appearing in Edgeset
###
### Returns:
### IncidenceMatrix to the edgeset where M(i,j) denotes number of
### edges from i->j.
###
### #GBNP.IncidenceMatrix uses: GBNP.ConstantRow#
### #GBNP.IncidenceMatrix is used in: DetermineGrowthObs#
###

GBNP.IncidenceMatrix:=function(EdgeSet,n) local i,M;
        M:=[];
        for i in [1..n] do
        M[i]:=GBNP.ConstantRow(n,0);
        od;
        for i in EdgeSet do
          M[i[1]][i[2]]:=M[i[1]][i[2]]+1;
        od;
        return(M);
end;


#####################################
### function GBNP.FormalSum
### - Returns part of the formal sum (pol)^-1 where pol is a
###   polynomial, up to given degree.
###
### Arguments:
### CList:              - a coefficientlist [a_0,...,a_p]
###                       corresponding to a polynomial
###                       a_0+a_1*t+a_2*t^2+...+a_p*t^p.
###                       NB a_0 <> 0 must hold!!!
### d                   - the desired degree of the formal sum.
###
### Returns:
### [b_0,...,b_d]       - the coefficientlist of the formal sum up to
###                       degree d.
###
### #GBNP.FormalSum uses:#
### #GBNP.FormalSum is used in: HilbertSeriesG HilbertSeriesQA#
###

GBNP.FormalSum:=function(CList,d) local RList,a0,i,j,k;

        k:=Minimum(d+1,Length(CList));
        if k=1 then return([One(CList[1])/CList[1]]); fi;

        for i in [1..Length(CList)] do
          if not IsBound(CList[i]) then CList[i]:=Zero(CList[1]); fi;
        od;

        # Divide polynomial by -a_{0} and remember a_{0}.
        a0:=1/CList[1];
        CList:=-CList/a0;

        # Initialize list of the Formal sum (=list of remainders).
        RList:=[1];
        for i in [2..k] do
          RList[i]:=CList[i];
        od;

        # Compute the first d terms of the formal sum
        for i in [2..d] do
          for j in [1..Length(CList)-2] do
            if i+j<=d+1 then
                RList[i+j]:=RList[i+j]+RList[i]*CList[j+1];
            fi;
          od;
          if i+Length(CList)-1<=d+1 then
            RList[i+Length(CList)-1]:=RList[i]*CList[Length(CList)];
          fi;
        od;
        d:=Length(RList);
        while RList[d]=0 do
          Unbind(RList[d]);
          d:=d-1;
        od;
        return(a0*RList);
end;

##########################################
### function GraphOfNormalWords
### <#GAPDoc Label="GraphOfNormalWords">
### <ManSection>
### <Func Name="GraphOfNormalWords" Comm="" Arg="O, n" />
### <Returns>
### <C>Edgeset</C>, the set of edges of the graph of normal words.
### </Returns>
### <Description>
### Given some set of `obstructions' <A>O</A> and an alphabet size <A>n</A>
### this function computes the graph of normalwords as defined in
### <Q>On the Use of Graphs for Computing a Basis Growth, and Hilbert
### Series of Associative Algebras</Q> by V. Ufnarovski <Cite
### Key="MR91d:16053"/>.
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Given some set of obstructions and an alphabet size
### this function computes the graph of normalwords as defined in
### "On the Use of Graphs for Computing a Basis Growth and Hilbert
### Series of Associative Algebra's" by "V. Ufnarovski"
###
### Arguments:
### O                   - a set of obstructions
### n                   - alphabet size
###
### Returns:
### Edgeset             - The set of edges of the graph of normal
###                               words
###
### Uses:
###                     - GBNP.OccurInLstPTSLR
###                     - GBNP.CreateOccurTreeLR
###                     - GBNP.SuffixOfTree     (tree.g)
###
### #GraphOfNormalWords uses: GBNP.CreateOccurTreeLR GBNP.OccurInLstPTSLR GBNP.SuffixOfTree#
### #GraphOfNormalWords is used in: DetermineGrowthObs#
###

InstallGlobalFunction(
GraphOfNormalWords,function(O,n)
local V, EdgeSet, i, j, k, obs, l, pos, w, T;

        # Initializing
        V:=[];

        EdgeSet:=[];
        T:=GBNP.CreateOccurTreeLR(O,false);

        # Add new elements to V
        # 1. The generators
        for i in [1..n] do
          Add(V,[i]);
        od;
        # 2. The proper suffices of obstructions
        for i in [1..Length(O)] do
          obs:=O[i];
          l:=Length(obs);
          for j in [0..l-2] do
            AddSet(V,obs{[l-j..l]});
          od;
        od;

        # Determine the directed edges
        for i in [1..Length(V)] do
          for j in [1..Length(V)] do
            w:=Concatenation(V[i],V[j]);
            l:=Length(w);
            if GBNP.OccurInLstPTSLR(w,T,false)=[0,0] then
                k:=Length(V[i])+1;
                while k<=l and not GBNP.SuffixOfTree(w,k,T.tree) do
                    k:=k+1;
                od;
                if k=l+1 then
                  AddSet(EdgeSet,[i,j]);
                fi;
            fi;
          od;
        od;

        return(EdgeSet);;
end);


########################
### function GBNP.ReduceMatrix
### - Consider a matrix M and a rownumber i. Find a way to reduce
###   matrix in the process of calculating growth by looking for
###   cycles, preterminal vertices or loops.
###
### Arguments:
### M                   - a square Matrix
### i                   - a rownumber (i<=l)
### l                   - Length(M)
### cycle               - the rows of M already considered up to now,
###                       while trying to find reduce-option.
###
### Returns:
### false               - M[i] is the all-zero row
### ["pt",i]            - M[i] is a preterminal row
### [i1,i2,..,in]       - a cycle is encountered
###                       special case: Length=1: Loop
###
### #GBNP.ReduceMatrix uses: GBNP.ReduceMatrix#
### #GBNP.ReduceMatrix is used in: GBNP.DetermineGrowthQA GBNP.ReduceMatrix#
###

GBNP.ReduceMatrix:=function(M,l,i,cycle) local j,result,zero,pos;

        zero:=0;
        result:=false;

        # Check entire row M[i] for cycle or loop;
        # if none encountered then it is either Allzerorow
        # or a preterminal row.
        j:=1;
        while j<=l and (M[i][j]=0 or result=false) do
          if M[i][j]=0 then
            zero:=zero+1;
            j:=j+1;
          else
            pos:=Position(cycle,j);
            if pos<>fail then
                result:=cycle{[pos..Length(cycle)]};
            else
                result:=GBNP.ReduceMatrix(M,l,j,Concatenation(cycle,[j]));
                if result=false then j:=j+1; fi;
            fi;
          fi;
        od;
        if zero=l then
          result:=false;
        elif result=false then
          result:=["pt",i];
        fi;
        return(result);
end;


##############################
### function GBNP.DetermineGrowthQA
### - Determine the growth of a graph, based on its incidence matrix
###
### Arguments:
### M                   - IncidenceMatrix of a graph
###
### Returns:
### 0                   - finite growth
### d   (d>0)           - polynomial growth of degree d
### "exponential"       - exponential growth
###
### #GBNP.DetermineGrowthQA uses: GBNP.ConstantRow GBNP.ReduceMatrix#
### #GBNP.DetermineGrowthQA is used in: DetermineGrowthObs#
###

GBNP.DetermineGrowthQA:=function(M) local l,r,i,j,k,k2,result,max;
        l:=Length(M);

        # Initialize the growth-vector
        r:=[]; for i in [1..l] do r[i]:=0; od;

        # Try to reduce the matrix by looking for reduce-options row by
        # row. Options are Cycle, Loop, Preterminal Row. When the row
        # is all-zero row, the next row is considered.
        i:=1;
        while i<=l do
          result:=GBNP.ReduceMatrix(M,l,i,[i]);
          if result=false then
            # A all-zero row
            i:=i+1;
          elif Length(result)=1 then
            # A loop
            j:=result[1];
            if M[j][j]>1 or r[j]>0 then
                return("exponential growth");
            else
                M[j][j]:=0;
                r[j]:=1;
            fi;
          elif result[1]="pt" then
            # Preterminal row
            j:=result[2];
            max:=0;
            for k in [1..l] do
                if M[j][k]<>0 then
                  if r[k]>max then
                    max:=r[k];
                  fi;
                  M[j][k]:=0;
                fi;
            od;
            r[j]:=r[j]+max;
          else
            # A cycle
            j:=result[1];

            # Sum and replace the rows
            for k in result{[2..Length(result)]} do
                M[j]:=M[j]+M[k];
                M[k]:=GBNP.ConstantRow(l,0);
                r[j]:=r[j]+r[k];
            od;

            # Sum and replace the columns
            for k in result{[2..Length(result)]} do
                for k2 in [1..l] do
                  M[k2][j]:=M[k2][j]+M[k2][k];
                  M[k2][k]:=0;
                od;
            od;

            # Adjust for dubbelcounts
            M[j][j]:=M[j][j]-Length(result)+1;
          fi;
        od;
#       Print("Polynomial of degree: ");
        return(Maximum(r));
end;


####################################
### function DetermineGrowthObs
### <#GAPDoc Label="DetermineGrowthObs">
### <ManSection>
### <Func Name="DetermineGrowthObs" Arg="L, n" />
### <Returns>
### If the dimension of the quotient algebra is finite, <M>0</M> is returned.
### If the growth of the quotient algebra is polynomial, the
### degree <C>d</C> of the growth polynomial is returned.
### If the growth is exponential, the string
### <Q>exponential growth</Q> is returned.
### </Returns>
### <Description>
### Given  a list of monomials
### <A>L</A> of which none divides another
### and an alphabet size <A>n</A>, this function
### computes the growth of the quotient of the free algebra over the rationals
### on <A>n</A> generators by the ideal generated by the monomials
### in <A>L</A>.
### This function is much
### slower than the function <Ref Func="DetermineGrowthQA" Style="Text"/>.
### However, in the case of polynomial growth, this function returns the exact
### degree of polynomial growth while <Ref Func="DetermineGrowthQA"
### Style="Text"/> may only return bounds.
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Given obstructions and an alphabet size <A>n</A>, compute the growth
###   of the factor algebra.
###
### Arguments:
### O                   - list of obstructions, none divides another
### n                   - the alphabet size
###
### Returns:
### 0                   - finite growth
### d   (d>0)           - polynomial growth of degree d
### "exponential"       - exponential growth
###
### Uses:
###                     - GraphOfNormalWords    (graphs.g)
###                     - GBNP.IncidenceMatrix  (graphs.g)
###                     - GBNP.DetermineGrowthQA        (graphs.g)
###
### #DetermineGrowthObs uses: GBNP.DetermineGrowthQA GBNP.IncidenceMatrix GBNP.NumAlgGensNPmonList GraphOfNormalWords#
### #DetermineGrowthObs is used in: DetermineGrowthQA#
###

InstallGlobalFunction(
DetermineGrowthObs,function(O,t) local D,n;
        if t=0 then     # set number of algebra generators
          n:=GBNP.NumAlgGensNPmonList(O); # by guessing from O
        else
          n:=t;         # using the input value
        fi;

#       Print("Step 1: computing graph of normal words \n");
        D:=GraphOfNormalWords(O,n);
#       Print("Step 2: building incidencematrix \n");
        if D<>[] then
          D:=GBNP.IncidenceMatrix(D,Maximum(Flat(D)));
        else
          D:=[[0]];
        fi;
#       Print("Step 3: determining growth \n");
        return(GBNP.DetermineGrowthQA(D));
end);


###################################
### function GraphOfChains
### <#GAPDoc Label="GraphOfChains">
### <ManSection>
### <Func Name="GraphOfChains" Comm="computes the graph of chains" Arg="O, n" />
### <Returns>
### A list <C>[ESet,LSet]</C>, where
### <List>
### <Mark><C>ESet</C></Mark><Item>a set of edges, where <C>ESet[i]</C> is a
### list <C>[j1,...,jk]</C> such that <M>i\rightarrow j1</M>,<M>\ldots</M>, <M>i\rightarrow jk</M></Item>
### <Mark>LSet</Mark><Item>Set of lengths, where <C>LSet[i]</C> is the length
### of vertex <C>i</C>.</Item>
### </List>
### </Returns>
### <Description>
### Computes the graph of chains of a given set of `obstructions' <A>O</A> with
### alphabet size <A>n</A>.
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Computes the graph of chains of a given set of obstructions
###
### Arguments:
### O                   - Set of obstructions
### n                   - the alphabet size
###
### Returns:
### - List [ESet,LSet] where
###     ESet            - Set of edges, where ESet[i] is a list
###                       [j1,...,jk] s.t. i->j1,..., i->jk
###     LSet            - Set of lengths, where LSet[i] is the length
###                       of vertex i.
###
### Uses:
###                     - GBNP.CreateOccurTreeLR
###                     - GBNP.LookUpOccurTreeForObsPTSLR
###                     - GBNP.SubOccurInTree (tree.g)
###
### #GraphOfChains uses: GBNP.CreateOccurTreeLR GBNP.LookUpOccurTreeForObsPTSLR GBNP.OccurInLstPTSLR#
### #GraphOfChains is used in:#
###

InstallGlobalFunction(
GraphOfChains,function(O,n) local ESet,VSet,LSet,
                                j,k,ot,pos,pos2,T,Tleft,overlap;

        # Initialize edgeset and vertexset and lengthset;
        ESet:=[];
        VSet:=List([1..n],x->[x]);
        LSet:=List([1..n],x->1);

        # Create tree of obstructions
        T:=GBNP.CreateOccurTreeLR(O,false);

        # Create left-tree of obstructions
        Tleft:=GBNP.CreateOccurTreeLR(O,true);

        # Start computing edgeset, lengthset and vertexset
        pos:=0;
        for j in VSet do
          pos:=pos+1;

          # Use the left tree to find all the overlaps
          overlap:=GBNP.LookUpOccurTreeForObsPTSLR(j,0,Tleft,true);
          for k in overlap do
            ot:=O[k[1]]{[Length(j)+2-k[2]..Length(O[k[1]])]};
             if GBNP.OccurInLstPTSLR(Concatenation(j,ot){[1..Length(j)+Length(ot)-1]},T,false)=[0,0] then
                pos2:=Position(VSet,ot);
                if pos2=fail then
                  Add(VSet,ot);
                  Add(LSet,Length(ot));
                  pos2:=Length(VSet);
                fi;
                if not IsBound(ESet[pos]) then
                  ESet[pos]:=[];
                fi;
                Add(ESet[pos],pos2);
             fi;
          od;
        od;

        return([ESet,LSet]);
end);


###################################
### function HilbertSeriesG
### <#GAPDoc Label="HilbertSeriesG">
### <ManSection>
### <Func Name="HilbertSeriesG" Arg="ESet, LSet, n, d" />
### <Returns>
### A list of coefficients of the Hilbert series up to degree <A>d</A>
### </Returns>
### <Description>
### Given a graph of chains (<A>ESet</A> is a set of edges, <C>ESet[i]</C> gives
### the vertices <C>j</C> such that <M>i\rightarrow j</M> is an edge and <A>LSet</A>
### is a set of lengths of the vertices: <C>LSet[i]</C> is the length of
### vertex <C>i</C>), an alphabet size <A>n</A> this function
### computes the Hilbert series up to a given degree <A>d</A>.
### Doesn't remember the graph itself, only the Hilbert series
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Given a graph of chains (Edgeset, lengths of the vertices), it
### computes the Hilbert series up to a given degree <A>d</A>.
### Doesn't remember the graph itself, only the Hilbert series
###
### Arguments:
### ESet                - Set of edges: ESet[i] gives the vertices j,
###                       s.t. i->j is an edge.
### LSet                - Set of lengths of the vertices: LSet[i] is
###                       the length of vertex i.
### n                   - The alphabet size
### d                   - degree up to which you want hilbert series
###
### Returns:
### - List of coefficients of the Hilbert series up to
###   degree d
###
### #HilbertSeriesG uses: GBNP.FormalSum#
### #HilbertSeriesG is used in:#
###

InstallGlobalFunction(
HilbertSeriesG,function(ESet,LSet,n,d) local C1,C2,i,j,k,m,CList,alpha,L;

        # Initialize the 0-chains
        C1:=[]; C2:=[];
        for i in [1..n] do
          C1[i]:=[1];
        od;
        CList:=[1,-n];

        # compute the i-1 chains
        i:=2;   alpha:=1;

        # Termination is obtained since you only want Hilberseries up to
        # given degree and degree must be increased in finite number of
        # steps since number of vertices is finite and each vertex has
        # a length>0.
        while true do
          for j in [1..Length(C1)] do
            if IsBound(C1[j]) and IsBound(ESet[j]) then
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
          if C2=[] or L[1][1]>=d then
            while not IsBound(CList[d+1]) or CList[d+1]=0 do
                d:=d-1;
            od;
            while Length(CList)>d+1 do
                Unbind(CList[Length(CList)]);
            od;
            return(GBNP.FormalSum(CList,d));
          fi;

          # Consider chains of higher length
          C1:=ShallowCopy(C2);
          C2:=[];
          i:=i+1;
          alpha:=-1*alpha;
        od;
end);
