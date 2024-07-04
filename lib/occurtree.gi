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


# createtree
# special case GB 1
# different definition.
# integer in place 1 of the array or in place pg+1 of the PTS array

### things to search for (first line a monomial, second the list represented by
### the tree):
###
### -----===-----       ===       -----===
###      ===       -----===-----       ===-----
###     type 1         type 2         type 3
###

### Functions:
###
### - tree manipulation:
### GBNP.CreateOccurTreeLR
### GBNP.CreateOccurTreePTSLR
### GBNP.CreateOccurTreePTSLRimpl
### GBNP.AddMonToTreePTSLR
### GBNP.RemoveMonFromTreePTSLR
### GBNP.SortParallelOT
### - lookup helpfuncions               type    LR      extra
### GBNP.LookUpOccurTreeAllPTSLRPos     1       LR      all
### GBNP.LookUpOccurTreePTSLRPos        1       LR      -
### GBNP.LookUpOccurTreeForObsPTSLRPos  3       LR      all
###
### - lookup functions                  type    LR
### GBNP.OccurInLstT                    1       L       -
### GBNP.OccurInLstPTSLR                1       LR      -
### GBNP.OccurLeftInLstT                1       L       from start
### GBNP.LookUpOccurTreeAllLstPTSLR     1       LR      all
### GBNP.LookUpOccurTreeForObsPTSLR     3       LR      all

#####################################
### GBNP.CreateOccurTreePTSLRimpl ###
#####################################
### Creates an occurtree, possibly with module generators
###
### impl -> the actual implementation; no changes on pg (like in the PTSLR
### variant)
###
### Arguments:
###
### - L         list of monomials
### - pg        number of monomial generators
### - left      boolean, true means non-reversed
###
### Returns:
### - the occurtree formed
###
### #GBNP.CreateOccurTreePTSLRimpl uses: GBNP.AddMonToTreePTSLR#
### #GBNP.CreateOccurTreePTSLRimpl is used in: GBNP.CreateOccurTreeLR GBNP.CreateOccurTreePTSLR#
###

GBNP.CreateOccurTreePTSLRimpl:=function(L,pg,left)
local i,OT;
        OT:=rec(tree:=[],tree2arr:=[],arr2tree:=[],nextnum:=1,pg:=pg);
        for i in [1..Length(L)] do
                GBNP.AddMonToTreePTSLR(L[i],i,OT,left);
        od;
        return OT;
end;

##############################
### GBNP.CreateOccurTreeLR ###
##############################
### Creates an occurtree, without module generators
###
### Arguments:
### - L         list of monomials
### - left      boolean, true means non-reversed
###
### Returns:
### - the occurtree formed
###
### #GBNP.CreateOccurTreeLR uses: GBNP.CreateOccurTreePTSLRimpl#
### #GBNP.CreateOccurTreeLR is used in: DetermineGrowthQA FinCheckQA GBNP.RedAddToTree GraphOfChains GraphOfNormalWords HilbertSeriesQA#
###

GBNP.CreateOccurTreeLR:=function(L,left)
        return GBNP.CreateOccurTreePTSLRimpl(L,0,left);
end;

#################################
### GBNP.CreateOccurTreePTSLR ###
#################################
### Creates an occurtree, possibly with module generators
###
### Arguments:
###
### - L         list of monomials
### - pg        number of monomial generators
### - left      boolean, true means non-reversed
###
### Returns:
### - the occurtree formed
###
### #GBNP.CreateOccurTreePTSLR uses: GBNP.CreateOccurTreePTSLRimpl GBNP.GetOptions#
### #GBNP.CreateOccurTreePTSLR is used in: GBNP.AllObs GBNP.IsGrobnerBasisTest GBNP.LeftObsT GBNP.NondivMonsPTS GBNP.NondivMonsPTSenum GBNP.ReducePol2 GBNP.RightObsT GBNP.SGrobnerLoops GBNP.StrongNormalFormTall IsGrobnerPair MakeGrobnerPair#
###

GBNP.CreateOccurTreePTSLR:=function(L,pg,left)
        if (pg <> GBNP.GetOptions().pg) then
                Info(InfoGBNP,2,"Warning: CreateOccurTreePTSLR: pg argument (",pg,") is not the same as pg option (",GBNP.GetOptions().pg,")\n");
        fi;

        # also take into account options for safety (warn if these are
        # different)
        pg:=Maximum(GBNP.GetOptions().pg,pg);

        return GBNP.CreateOccurTreePTSLRimpl(L, pg, left);
end;

#######################################
### GBNP.LookUpOccurTreeAllPTSLRPos ###
#######################################
###
### Looks up all monomials in the tree that occur in the monomial mon from
### position startpos.
###
### Arguments:
### - mon               monomial to check
### - OT                occurtree to use for lookup
### - left              true: non-reversed
### - startpos          position of mon to start checking
###
### Returns:
### - the array indices of all matching monomials
###
### #GBNP.LookUpOccurTreeAllPTSLRPos uses:#
### #GBNP.LookUpOccurTreeAllPTSLRPos is used in: GBNP.LookUpOccurTreeAllLstPTSLR#
###

GBNP.LookUpOccurTreeAllPTSLRPos:=function(mon,OT,left,startpos)
local   pos,    # index of mon
        r,      # part of the tree
        pi,     # add to index
        ans,    # all indices found sofar
        len,    # length of the monomial
        pos2;   # pos corrected for left/right

                # arrays go from 1..
                # first pg entries are prefix gens, the next one is skipped
                # and the rest is for two-sided generators

        pi:=OT.pg+1;
        ans:=[];

        r:=OT.tree;len:=Length(mon);
        pos:=startpos; # 1 is a usual start

        #follow OT as far as possible
        while (pos<=len) do
                if left then
                        pos2:=pos;
                else
                        pos2:=len-pos+1;
                fi;

                if IsBound(r[pi]) then
                        # found the answer early
                        Add(ans,OT.tree2arr[r[pi]]);
                fi;

                if IsBound(r[mon[pos2]+pi]) then
                        r:=r[mon[pos2]+pi];
                else    # nothing more can be found
                        return ans;
                fi;
                pos:=pos+1;
        od;

        # nothing left to check

        if IsBound(r[pi]) then
                Add(ans,OT.tree2arr[r[pi]]);
        fi;
        return ans; # note that ans is sorted (smallest ones found first)
end;

####################################
### GBNP.LookUpOccurTreePTSLRPos ###
####################################
###
### Looks for a monomial occurring in mon from position startpos.
###
###   startpos          (image for left=true case)
###      |
### -----====-----      type 1
###      ====
###
### Arguments:
###
### - mon               monomial to check
### - OT                occurtree used
### - left      true: non-reversed
### - startpos  position of mon to start checking
###
### Returns:
### - the array index of a monomial or 0 if no monomials can be found
###
### #GBNP.LookUpOccurTreePTSLRPos uses:#
### #GBNP.LookUpOccurTreePTSLRPos is used in: DetermineGrowthQA FinCheckQA GBNP.LeftObsT GBNP.NondivMonsPTS GBNP.OccurInLstPTSLR GBNP.OccurLeftInLstT GBNP.RightObsT countfun#
###

GBNP.LookUpOccurTreePTSLRPos:=function(mon,OT,left,startpos)
local   pos,    # index of mon
        r,      # part of the tree
        pi,     # add to index
        len,    # length of the monomial
        pos2;   # pos corrected for left/right

                # arrays go from 1..
                # first pg entries are prefix gens, the next one is skipped
                # and the rest is for two-sided generators

        pi:=OT.pg+1;

        r:=OT.tree;len:=Length(mon);
        pos:=startpos; # 1 is a usual start

        #follow OT as far as possible
        while (pos<=len) do
                if left then
                        pos2:=pos;
                else
                        pos2:=len-pos+1;
                fi;

                if IsBound(r[pi]) then
                        # found the answer early
                        return OT.tree2arr[r[pi]];
                fi;

                if IsBound(r[mon[pos2]+pi]) then
                        r:=r[mon[pos2]+pi];
                else    # nothing can be found
                        return 0;
                fi;
                pos:=pos+1;
        od;

        # nothing left to check

        if IsBound(r[pi]) then
                return OT.tree2arr[r[pi]];
        fi;

        return 0;
end;


########################
### GBNP.OccurInLstT ###
########################
###
### Searches for monomials from the list in <mon>.
###
### Arguments:
### - mon       monomial to check
### - LOT       a left-occur tree
###
### Returns:
### - [nr,i]
###     Where nr = the array number of the monomial found
###     and i = the position from the left (i is as small as possible)
###     if nothing is found then [0,0] is returned.
###
### #GBNP.OccurInLstT uses: GBNP.OccurInLstPTSLR#
### #GBNP.OccurInLstT is used in: GBNP.NormalForm2T GBNP.SGrobnerLoops GBNP.StrongNormalForm2Tall GBNP.StrongNormalForm3Dall GBNP.THeapOTCheck#
###

GBNP.OccurInLstT:=function(mon,LOT)
        return GBNP.OccurInLstPTSLR(mon,LOT,true);
end;

############################
### GBNP.OccurInLstPTSLR ###
############################
###
### Searches for monomials from the list in <mon>.
###
### Arguments:
### - mon       monomial to check
### - LOT       a left-occur tree
### - left      true -> non-reversed
###
### Returns:
### - [nr,i]
###     Where nr = the array number of the monomial found
###     and i = the position from the left (right if left=false) (i is as small
###     as possible) if nothing is found then [0,0] is returned.
###
### #GBNP.OccurInLstPTSLR uses: GBNP.LookUpOccurTreePTSLRPos#
### #GBNP.OccurInLstPTSLR is used in: GBNP.OccurInLstT GraphOfChains GraphOfNormalWords HilbertSeriesQA IsGrobnerPair MakeGrobnerPair#
###

GBNP.OccurInLstPTSLR:=function(mon,LOT,left)
local   i,
        ans;
        for i in [1..Length(mon)] do
                ans:=GBNP.LookUpOccurTreePTSLRPos(mon,LOT,left,i);
                if ans<>0 then
                        return [ans,i];
                fi;
        od;

        return [0,0];
end;

############################
### GBNP.OccurLeftInLstT ###
############################
###
### Searches for monomials from the list occurring at the left in <mon>.
###
### Arguments:
### - mon       monomial to check
### - LOT       occurtree used (left occur tree)
###
### Returns:
### - [nr,i]
###     Where nr = the array number of the monomial found
###     and i = 1 if a monomial is found (compatible with GBNP.OccurInLstT)
###     if nothing is found then [0,0] is returned.
###
### #GBNP.OccurLeftInLstT uses: GBNP.LookUpOccurTreePTSLRPos#
### #GBNP.OccurLeftInLstT is used in:#
###

GBNP.OccurLeftInLstT:=function(mon,LOT)
local ans;
        ans:=GBNP.LookUpOccurTreePTSLRPos(mon,LOT,true,1);
        if ans<>0 then
                return [ans,1];
        fi;
        return [0,0];
end;

#######################################
### GBNP.LookUpOccurTreeAllLstPTSLR ###
#######################################
###
### Looks up all monomials from a list starting with <mon>
###
### Arguments:
### - mon       the monomial to check
### - OT        the occur tree used
### - left      true if not reversed
###
### Returns:
### - A list of matches in the form [nr, i], where nr is the monomial found and
###   i the left-most position where it is found
###
### #GBNP.LookUpOccurTreeAllLstPTSLR uses: GBNP.LookUpOccurTreeAllPTSLRPos#
### #GBNP.LookUpOccurTreeAllLstPTSLR is used in: GBNP.SGrobnerLoops GBNP.StrongNormalForm2TS GBNP.StrongNormalForm2TSPTS GBNP.StrongNormalForm3Dall#
###

GBNP.LookUpOccurTreeAllLstPTSLR:=function(mon,OT,left)
local   i,j,    # counter
        allans, # sparse list of answer
        ansind, # indices of ans
        ans;    # what will be returned

        allans:=[];ansind:=[];
        for i in [1..Maximum(1,Length(mon))] do
                for j in GBNP.LookUpOccurTreeAllPTSLRPos(mon,OT,left,i) do
                        if not IsBound(allans[j]) then
                                allans[j]:=i;
                                AddSet(ansind,j);
                        fi;
                od;
        od;
        ans:=[];
        for i in ansind do
                Add(ans,[i,allans[i]]);
        od;
        return ans;# not sorted
end;

##########################################
### GBNP.LookUpOccurTreeForObsPTSLRPos ###
##########################################
###
### function to search for obstructions with occur trees (partial task)
###
### searches for obstructions of the form:
###                 startpos
###                 |
### mon:        ----===         type 3 (picture for left=true)
###                 ===----
###
### Arguments:
### - mon               Monomial to look for obstructions in
### - OT                occur tree
### - left              true -> non-reversed
### - startpos          startposition of YYYY in mon
###
### Returns:
### - A list of indices of monomials from the tree that match.
###
### #GBNP.LookUpOccurTreeForObsPTSLRPos uses:#
### #GBNP.LookUpOccurTreeForObsPTSLRPos is used in: GBNP.LookUpOccurTreeForObsPTSLR#
###

GBNP.LookUpOccurTreeForObsPTSLRPos:=function(mon,OT,left,startpos)
local   pos,    # index of mon
        r,      # part of the tree
        pi,     # add to index
        ans,    # all indices found sofar
        len,    # length of the monomial
        pos2,   # pos corrected for left/right
        f;

                # arrays go from 1..
                # first pg entries are prefix gens, the next one is skipped
                # and the rest is for two-sided generators

        pi:=OT.pg+1;

        r:=OT.tree;len:=Length(mon);
        pos:=startpos; # 1 is a usual start

        #follow OT as far as possible
        while (pos<=len) do
                if left then
                        pos2:=pos;
                else
                        pos2:=len-pos+1;
                fi;

                if IsBound(r[pi]) then
                        # found the answer early
                fi;

                if IsBound(r[mon[pos2]+pi]) then
                        r:=r[mon[pos2]+pi];
                else    # nothing more can be found
                        return [];
                fi;
                pos:=pos+1;
        od;

        # now return things still left in r:

        return List(Flat(r),x->OT.tree2arr[x]);
end;

#######################################
### GBNP.LookUpOccurTreeForObsPTSLR ###
#######################################
###
### function to search for obstructions with occur trees
###
### searches for obstructions of the form:
### mon:        xxxxxYYYYY
###                  YYYYYzzz
### where xxxx is as small as possible
###
### Arguments:
### - mon       monomial to check
### - j         number of the monomial (to filter out itself), can be 0 ->
###                     filter out nothing
### - GOT       Occur tree of G
### - left      true -> non-reversed
###
### Returns:
### - an array of lists [nr,i], where nr is the index in the array and i the
###     position of the first 'Y'
###
### #GBNP.LookUpOccurTreeForObsPTSLR uses: GBNP.LookUpOccurTreeForObsPTSLRPos#
### #GBNP.LookUpOccurTreeForObsPTSLR is used in: GBNP.LeftObsT GBNP.RightObsT GraphOfChains HilbertSeriesQA#
###

GBNP.LookUpOccurTreeForObsPTSLR:=function(mon,j,GOT,left)
local   i,o,
        allans,
        ansind,
        ans;

        ans:=[];
        for i in [1..Length(mon)] do
                for o in GBNP.LookUpOccurTreeForObsPTSLRPos(mon,GOT,left,i)
                do
                        if not (i=1 and o=j) then # why this condition ?
                                Add(ans,[o,i]);
                        fi;
                od;
        od;

        return ans;# not sorted
end;

##############################
### GBNP.AddMonToTreePTSLR ###
##############################
###
### Adds a monomial <mon> to the tree <OT> that does not occur in the tree
### already.
###
### Arguments:
### - mon       the monomial to add
### - i         the index in the corresponding array (assumed to be unique)
###             i=-1 means adding to the end of the array
### - OT        occur tree
### - left      true -> non-reversed
###
### Returns:
###  - nothing returned (but the tree <OT> is updated)
###
### #GBNP.AddMonToTreePTSLR uses:#
### #GBNP.AddMonToTreePTSLR is used in: GBNP.AllObs GBNP.CentralT GBNP.CreateOccurTreePTSLRimpl GBNP.IsGrobnerBasisTest GBNP.LeftObsT GBNP.ObsTall GBNP.ReducePol2 GBNP.RightObsT GBNP.SGrobnerLoops MakeGrobnerPair THeapOT#
###

GBNP.AddMonToTreePTSLR:=function(mon,i,OT,left)
local   pos,    # index of mon
        r,oldr, # part of the tree
        pi,     # addition factor
        pos2,   # pos with left/right correction
        len,    # length of the monomial
        arrnum, # index in arr2tree
        treenum,# index in tree
        j,lat;

        #Info(InfoGBNP,4,"AddMonToTreePTSLR i:",i," mon:",mon);
        pi:=OT.pg+1;

        r:=OT.tree;len:=Length(mon);
        pos:=1;oldr:=OT.tree;
        treenum:=OT.nextnum;

        if IsBound(OT.tree2arr[OT.nextnum]) then
                OT.nextnum:=OT.tree2arr[OT.nextnum];
        else
                OT.nextnum:=OT.nextnum+1; # end of the tree
        fi;

        if (i=-1) then
                arrnum:=Length(OT.arr2tree)+1;
                OT.tree2arr[treenum]:=arrnum;
                Add(OT.arr2tree,treenum);
        else
                arrnum:=i;
                InsertElmList(OT.arr2tree,i,treenum);
                for j in [i..Length(OT.arr2tree)] do
                        OT.tree2arr[OT.arr2tree[j]]:=j;
                od;
        fi;
        #Info(InfoGBNP,5,"AddMonToTreePTSLR arrnum:",arrnum);

        #follow OT as far as possible
        while (pos<=len) do
                if left then
                        pos2:=pos;
                else
                        pos2:=len-pos+1;
                fi;

                #if IsBound(r[pi]) then
                #       # nevermind adding, use the shorter one instead
                #       return;
                # add anyway, easier for proving
                if IsBound(r[mon[pos2]+pi]) then # follow the existing prefix
                        r:=r[mon[pos2]+pi];
                else # add a new prefix
                        r[mon[pos2]+pi]:=[];
                        r:=r[mon[pos2]+pi];
                fi;
                pos:=pos+1;
        od;
        if not IsBound(r[pi]) then
                r[pi]:=treenum;
        fi;
end;

###################################
### GBNP.RemoveMonFromTreePTSLR ###
###################################
###
### Removes a monomial <mon> from the occurtree <OT>
###
### Arguments:
### - mon       the monomial to remove
### - i         the index of the monomial
### - OT        the tree to remove <mon> from
### - left      true -> non-reversed
###
### Returns:
###     nothing, but removes <mon> from <OT>
###
### #GBNP.RemoveMonFromTreePTSLR uses:#
### #GBNP.RemoveMonFromTreePTSLR is used in: GBNP.ReducePol2 GBNP.SGrobnerLoops THeapOT#
###

GBNP.RemoveMonFromTreePTSLR:=function(mon,i,OT,left)
local   pos,    # index of mon
        r,oldr, # part of the tree
        oldind,
        pi,
        len,    # length of the monomial
        pos2,   # pos corrected for left/right
        j;


        # if a monomial is not in the tree then nothing is deleted
        #Assert(1,i=GBNP.LookUpRightOccurTree(mon,OT),
        #       "Monomial not in tree.");
        #Info(InfoGBNP,4,"RemoveMonFromTreePTSLR i:",i," mon:",mon);

        pi:=OT.pg+1;

        r:=OT.tree;
        len:=Length(mon);pos:=1;

        oldr:=0;

        if len=0 then
                oldind:=pi;
        else
                if left then
                        pos2:=pos;
                else
                        pos2:=len-pos+1;
                fi;

                oldind:=mon[pos2]+pi;
        fi;

        #follow OT as far as possible
        while (pos<=len) do
                if left then
                        pos2:=pos;
                else
                        pos2:=len-pos+1;
                fi;

                #if IsBound(r) then
                #       # not added, so nothing to remove
                #       return OT;
                if IsBound(r[mon[pos2]+pi]) then # follow the existing prefix
                        if Number(r)<>1 then
                                # if number=1 than this could be the tail for
                                # this one
                                oldr:=r;oldind:=mon[pos2]+pi;
                        fi;
                        r:=r[mon[pos2]+pi];
                else # not added, so nothing to remove
                        Info(InfoGBNP,3,"could not remove!");
                        return ;
                fi;
                pos:=pos+1;
        od;

        if IsBound(r[pi]) and OT.tree2arr[r[pi]]=i then # remove
                if Number(r)<>1 then
                        Unbind(r[pi]);
                else
                        if oldr=0 then #clean the whole tree
                                Unbind(OT.tree[oldind]);
                        else
                                # r should now be i
                                Unbind(oldr[oldind]);
                                # remove the tail that is exclusively for
                                # this function
                        fi;
                fi;
        fi;
        OT.tree2arr[OT.arr2tree[i]]:=OT.nextnum;
        OT.nextnum:=OT.arr2tree[i];
        RemoveElmList(OT.arr2tree,i);
        for j in [i..Length(OT.arr2tree)] do
                OT.tree2arr[OT.arr2tree[j]]:=j;
        od;
end;

###########################
### GBNP.SortParallelOT ###
###########################
###
### Use this function when sorting the array corresponding with the indices.
### In case of a parallelsort, the unsorted parallel can be copied beforehand
### and used as argument for this function, which updates the two arrays
### of the occur tree
###
### Arguments:
### - l                 the help list
### - OT                the tree (with arrays arr2tree and tree2arr)
### - searchfun         the search function (usually LtNP)
###
### Returns:
###     nothing, but changes the tree: sorts arr2tree (and updates tree2arr)
###
### #GBNP.SortParallelOT uses:#
### #GBNP.SortParallelOT is used in: GBNP.ObsTall THeapOT#
###

GBNP.SortParallelOT:=function(l,OT,searchfun)
local i;
        SortParallel(l,OT.arr2tree,searchfun);
        for i in [1..Length(OT.arr2tree)]
        do
                OT.tree2arr[OT.arr2tree[i]]:=i;
        od;
end;


#######################
### GBNP.NondivMons ###
#######################
###
### Arguments:
### lts         - list of leading terms
### t           - number of elements in the alphabet
### maxno       - maximum number of monomials to be found
###
### Returns:
### ans         - List of nondiv. monomials
###
### #GBNP.NondivMons uses: GBNP.NondivMonsPTS#
### #GBNP.NondivMons is used in: BaseQA#
###

GBNP.NondivMons := function(lts,t,maxno)
        return GBNP.NondivMonsPTS([],lts,t,0,maxno);
end;

##########################
### GBNP.NondivMonsPTS ###
##########################
###
### Arguments:
### plts        - list of leading terms for prefix rules
### lts         - list of leading terms
### t           - number of elements in the alphabet
### mt          - number of elements in the module-alphabet
### maxno       - maximum number of monomials to be found
###
### Returns:
### ans         - List of nondiv. monomials
###
### #GBNP.NondivMonsPTS uses: GBNP.CreateOccurTreePTSLR GBNP.LookUpOccurTreePTSLRPos GBNP.OccurInLst#
### #GBNP.NondivMonsPTS is used in: BaseQM GBNP.NondivMons#
###

GBNP.NondivMonsPTS := function(plts,lts,t,mt,maxno) local h,i,ct,hi,tt,ans,idf,lvl,cont,ROT,pLOT;

#jwk schreef uitzetten op 11 aug 2009
#mt:=GBNP.GetOptions().pg;              # XXX even not longer needed
    if plts<>[] then                    # XXX mt should not be changed here
        lts:=Concatenation(plts,lts);   # XXX
        plts:=[];                       # XXX
    fi;                                 # XXX
    cont := true;

    if maxno = 0 then idf := true; else idf := false; fi;
    if Length(lts) = 0 and maxno = 0 then return "error: empty input and no maximum"; fi;
    if GBNP.OccurInLst([],lts)[1] > 0 then return []; fi;
    if Length(lts)>0 then
        ROT := GBNP.CreateOccurTreePTSLR(lts,mt,false);
    fi;
    #pLOT := GBNP.CreateOccurTreePTSLR(plts,mt,true); # XXX remove plts and this
    ans := [];
    lvl := 1;
    if mt >0 then
        ans[1] := [];
        for i in [-mt,-mt+1..-1] do
                if Length(lts)=0 or GBNP.LookUpOccurTreePTSLRPos([i],ROT,false,1) = 0 then
                        Add(ans[1],[i]);
                fi;
        od;
    else
        ans[1] := [[]];
    fi;
    ct := Length(ans[1]);

    while cont and ((ct <= maxno) or idf) do
         #Info(InfoGBNP,3,"sofar found ",ct," monomials");
         lvl := lvl+ 1;
         tt := [];
         #Info(InfoGBNP,3,"busy with lvl ",lvl);
         cont := false;
         for h in ans[lvl-1] do
            for i in [1..t] do
                hi := StructuralCopy(h);
                Append(hi,[i]);
                if Length(lts)=0 or GBNP.LookUpOccurTreePTSLRPos(hi,ROT,false,1) = 0
                        # XXX and GBNP.LookUpOccurTreePTSLRPos(hi,pLOT,true,1)= 0 #remove plts and this
                then
                   ct := ct+ 1;
                   Append(tt,[hi]);
                   cont := true;
                fi;
            od;
         od;
         ans[lvl] := tt;
    od;
    return(ans);
end;

##############################
### GBNP.NondivMonsPTSenum ###
##############################
###
### depth first version - only counts and therefore uses much less memory and it
### should be faster
###
### Arguments:
### plts        - list of leading terms for prefix rules
### lts         - list of leading terms
### t           - number of elements in the alphabet
### mt          - number of elements in the module-alphabet
### maxno       - maximum number of monomials to be found
###
### Returns:
### ans         - List of nondiv. monomials
###
### #GBNP.NondivMonsPTSenum uses: GBNP.CreateOccurTreePTSLR GBNP.GetOptions GBNP.OccurInLst#
### #GBNP.NondivMonsPTSenum is used in: DimQA DimQM GBNP.SGrobnerLoops#
###

GBNP.NondivMonsPTSenum := function(plts,lts,t,mt,max)
local lvl,ROT, pol, todo, found_new, countfun, count;

    #mt:=GBNP.GetOptions().pg;          # XXX even not longer needed
    if plts<>[] then                    # XXX mt should not be changed here
        lts:=Concatenation(plts,lts);   # XXX
        plts:=[];                       # XXX
    fi;                                 # XXX

    if Length(lts) = 0 then return "error: empty input"; fi;
    if GBNP.OccurInLst([],lts)[1] > 0 then return 0; fi;
    ROT := GBNP.CreateOccurTreePTSLR(lts,mt,false);
    #pLOT := GBNP.CreateOccurTreePTSLR(plts,mt,true); # XXX remove plts and this
    if mt >0 then
        todo := List([-mt,-mt+1..-1],x->[x]);
        lvl := 2;
    else
        todo := [[]];
        lvl := 1;
    fi;

    countfun:=function(pol,lvl)
        local i, count;

        if max>0 and lvl>max then return 1; fi;

        count:=0;
        for i in [1..t]  do
            pol[lvl]:=i;
            if GBNP.LookUpOccurTreePTSLRPos(pol,ROT,false,1) = 0 then
                count:=count+countfun(pol,lvl+1)+1;
                Unbind(pol[lvl+1]);
            fi;
            if max>0 and count>max then
                return count;
            fi;
        od;

        return count;
    end;

    count:=0;
    for pol in todo do
        if GBNP.LookUpOccurTreePTSLRPos(pol,ROT,false,1) = 0 then
            count:=count+countfun(pol,lvl)+1;
            if max>0 and count>max then
                return max;
            fi;
            Unbind(pol[lvl+1]);
        fi;
    od;

    return count;
end;
