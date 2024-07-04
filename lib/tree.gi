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

### filename = "tree.gi"
### author: Chris Krook
### This is an add-on for the GBNP package, version 0.9

# This file contains auxiliary functions that are used by the file
# fincheck.g. All functions in this file are constructors or operators on
# a tree structure, that can be used to store a set of monomials,
# of which none divides another.
#
# Formally:
# Given an alphabet A and a set of monomials M, none of which divides
# another, the tree T is defined to be a list s.t.
# T[m_n +1][m_(n-1) +1]...[m_1 +1]<>0 iff m=m_1 m_2 ... m_n in M.
# T is unbound on all other positions.
# (the actual value in the tree is not used by the functions
# that these functions support, but is used in some other GBNP-functions.
# Therefore we are sloppy with the actual values and the corresponding
# arrays as present in the tree-structure. By doing this some functions
# are more efficient.)
# Example: M={xx,yyx,yyy} -> T=[,[,[1],[,,[1]]],[,,[,,[1]]]]
#          Here T[1+1][2+1][2+1]=[1] and [2,2,1]~yyx is in M


# functions that are defined in this file:
# GBNP.IsFullTree               :=function(Tree,alphabetsize)
# GBNP.RedAddToTree             :=function(u,T,n);
# GBNP.RedAddListToTree         :=function(ulist,Tree,alphabetsize)
# GBNP.SuffixOfTree             :=function(u,l,Tree)
# GBNP.TreeToList               :=function(Tree,[],[])


#######################
### GBNP.IsFullTree ###
#######################
### - Checks whether a given tree consists of precisely n leafs
###   where n is alphabetsize.
###
### Arguments:
### Tree                - a tree
### alphabetsize        - the alphabetsize
###
### Returns:
### true:               - Tree[1]..Tree[n] are leafs
### false:              - Otherwise
###
### #GBNP.IsFullTree uses:#
### #GBNP.IsFullTree is used in: GBNP.RedAddToTree#
###

GBNP.IsFullTree:=function(Tree,alphabetsize) local i;
        i:=1;
        while i<=alphabetsize do
          if not IsBound(Tree[i+1]) or (IsList(Tree[i+1]) and Length(Tree[i+1])>1) then
            return(false);
          else
            i:=i+1;
          fi;
        od;
        return(true);
end;

#########################
### GBNP.RedAddToTree ###
#########################
### - Adds an element u to the tree T, instantly reducing full
###   subtrees to nodes.
###
### Arguments:
### u                   - monomial
### T                   - a tree of reversed relations.
### alphabetsize        - the alphabetsize
###
### Returns:
###                     - nothing. called for its side effect.
###                       Alters Tree as to add u to it.
###
### Uses:
###                     - GBNP.RedAddToTree     (tree.g)
###                     - GBNP.CreateOccurTreeLR
###                     - GBNP.IsFullTree       (tree.g)
###
### #GBNP.RedAddToTree uses: GBNP.CreateOccurTreeLR GBNP.IsFullTree GBNP.RedAddToTree#
### #GBNP.RedAddToTree is used in: GBNP.IncrT GBNP.RedAddListToTree GBNP.RedAddToTree PreprocessAnalysisQA#
###

GBNP.RedAddToTree:=function(u,T,n) local i;
        i:=Length(u);
        if i>1 and IsBound(T[u[i]+1]) then
          if IsList(T[u[i]+1]) and Length(T[u[i]+1])>1 then
            GBNP.RedAddToTree(u{[1..Length(u)-1]},T[u[i]+1],n);
          else
            return;
          fi;
        elif i=1 then
          T[u[i]+1]:=[1];
        else
          T[u[i]+1]:=GBNP.CreateOccurTreeLR([u{[1..Length(u)-1]}],false).tree;
        fi;
        if i>0 and GBNP.IsFullTree(T[u[i]+1],n) then
          T[u[i]+1]:=[1];
        fi;
end;;

### #GBNP.RedAddListToTree uses: GBNP.RedAddToTree#
### #GBNP.RedAddListToTree is used in:#
###

GBNP.RedAddListToTree:=function(ulist,Tree,alphabetsize) local u;
        for u in ulist do
          GBNP.RedAddToTree(u,Tree,alphabetsize);
        od;
end;;


#########################
### GBNP.SuffixOfTree ###
#########################
### - Checks whether some u is a strict suffix of some relation in
###   the tree.
###
### Arguments:
### u                   - monomial (not reversed, just the
###                       original monomial)
### l                   - pointer s.t. u[1..l] is the monomial
### Tree                - a tree of reversed relations.
###
### Returns:
### true                - u is strict suffix of some relation
### false               - otherwise
###
### #GBNP.SuffixOfTree uses:#
### #GBNP.SuffixOfTree is used in: GraphOfNormalWords#
###

GBNP.SuffixOfTree:=function(u,l,Tree) local T;
        if Tree=[] then return(false); fi;
        T:=ShallowCopy(Tree);
        while l>0 do
          if IsBound(T[u[l]+1]) and IsList(T[u[l]+1]) then
            T:=T[u[l]+1];
            l:=l-1;
          else
            return(false);
          fi;
        od;
        if IsList(T) and Length(T)>1 then return(true);
        else return(false);
        fi;
end;;


#######################
### GBNP.TreeToList ###
#######################
### - Gives the relations from the tree
###
###
### Arguments:
### Tree                - a tree of reversed relations.
### Rels, Temp          - should both be [];
###
### Returns:
### a list of the relations
###
### #GBNP.TreeToList uses: GBNP.TreeToList#
### #GBNP.TreeToList is used in: GBNP.TreeToList PreprocessAnalysisQA#
###

GBNP.TreeToList:=function(Tree,Rels,Temp) local i;
        for i in [2..Length(Tree)] do
          if IsBound(Tree[i]) then
            if Length(Tree[i])>1 then
                GBNP.TreeToList(Tree[i],Rels,Concatenation([i-1],Temp));
            else
                Add(Rels, Concatenation([i-1],Temp));
            fi;
          fi;
        od;
        return(Rels);
end;;
