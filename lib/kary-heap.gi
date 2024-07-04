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

# Add, Remove, ELM_LIST, Minimum,
# todo List, Set

InstallGlobalFunction(
THeapOT,function(todo, OT)
local   H,
        temp,temp2,sorted,i;

        temp:=LMonsNP(todo);
        sorted:=true;
        i:=1;
        while (i<Length(temp)) and (sorted) do
                sorted:=LtNP(temp[i],temp[i+1]);
                i:=i+1;
        od;
        if sorted=false then
                temp2:=StructuralCopy(temp);
                SortParallel(temp,todo,LtNP);
                GBNP.SortParallelOT(temp2,OT,LtNP);
        fi;

        H:=Objectify(THeapOTType, rec(list:=todo, OT:=OT));
        return H;
end);

InstallMethod(Add,
        "for 3-ary heaps with Tries",
        [ IsTHeapOT, IsObject ],
        function( heap, obj )
                #Print("add\n");
                #GBNP.THeapOTCheck(heap);
                Add(heap!.list, obj);
                GBNP.AddMonToTreePTSLR(obj[1][1],-1, heap!.OT, true);
                GBNP.THeapOTBalanceUp(heap, Length(heap!.list));
                #GBNP.THeapOTCheck(heap);
        end
);

InstallMethod(ELM_LIST,
        "for 3-ary heaps with Tries",
        [ IsTHeapOT, IsInt ],
        function( heap, pos )
                #Print("elm_list\n");
                #GBNP.THeapOTCheck(heap);
                return heap!.list[pos];
        end
);

InstallMethod(Length,
        "for 3-ary heaps with Tries",
        [ IsTHeapOT ],
        function( heap )
                return Length(heap!.list);
        end
);

InstallMethod(Remove,
        "for 3-ary heaps with Tries",
        [ IsTHeapOT, IsInt ],
        function( heap, pos)
        local   parent;
                #Print("remove\n");
                #GBNP.THeapOTCheck(heap);
                GBNP.THeapOTSwap(heap, pos, Length(heap!.list));
                GBNP.RemoveMonFromTreePTSLR(heap!.list[Length(heap!.list)][1][1],Length(heap!.list),heap!.OT,true);
                Remove(heap!.list); # remove last element
                parent:=GBNP.THeapOTGetParentIndex(pos);
                if (pos<=Length(heap)) then
                        if (pos>1) and (LtNP(heap!.list[pos][1][1],heap!.list[parent][1][1]))
                        then
                                GBNP.THeapOTBalanceUp(heap, pos);
                        else
                                GBNP.THeapOTBalanceDown(heap, pos);
                        fi;
                fi;
                #GBNP.THeapOTCheck(heap);
        end
);

InstallMethod(Replace,
        "for 3-ary heaps with Tries",
        [ IsTHeapOT, IsInt, IsObject ],
        function( heap, pos, obj)
        local   parent;
                #Print("replace\n");
                #GBNP.THeapOTCheck(heap);
                GBNP.RemoveMonFromTreePTSLR(heap!.list[pos][1][1],pos,heap!.OT,true);
                GBNP.AddMonToTreePTSLR(obj[1][1],pos,heap!.OT,true);
                heap!.list[pos]:=obj;

                parent:=GBNP.THeapOTGetParentIndex(pos);
                if (pos>1) and
                        LtNP(heap!.list[pos][1][1],heap!.list[parent][1][1])
                then
                        GBNP.THeapOTBalanceUp(heap, pos);
                else
                        GBNP.THeapOTBalanceDown(heap, pos);
                fi;
                #GBNP.THeapOTCheck(heap);
        end
);

InstallMethod(HeapMin,
        "for 3-ary heaps with Tries",
        [IsTHeapOT],
        function( heap )
                #Print("heapmin\n");
                #GBNP.THeapOTCheck(heap);
                return heap!.list[1];
        end
);

InstallMethod(IsTHeapOTEmpty,
        "for 3-ary heaps with Tries",
        [IsTHeapOT],
        function( heap )
                #Print("isempty\n");
                #GBNP.THeapOTCheck(heap);
                return Length(heap)=0;
        end
);

GBNP.THeapOTBalanceDown:=function(heap, index)
local   ready,
        child, children, minchild, minval;

        #Print("balance down\n");
        ready:=false;
        while not ready do
                ready:=true;
                children:=GBNP.THeapOTGetChildrenIndex(index);
                minchild:=0; minval:=heap!.list[index][1][1];
                for child in children do
                        if IsBound(heap!.list[child]) and LtNP(heap!.list[child][1][1],minval)
                        then
                                minval:=heap!.list[child][1][1];
                                minchild:=child;
                        fi;
                od;
                if minchild<>0 then
                        ready:=false;
                        GBNP.THeapOTSwap(heap, index, minchild);
                        index:=minchild;
                fi;
        od;
        #GBNP.THeapOTCheck(heap);
end;

GBNP.THeapOTBalanceUp:=function(heap, index)
local   ready,
        parent;

        #Print("balance up\n");
        ready:=false;
        while (index>1) and not ready do
                parent:=GBNP.THeapOTGetParentIndex(index);
                if LtNP(heap!.list[index][1][1],heap!.list[parent][1][1]) then
                        GBNP.THeapOTSwap(heap, index, parent);
                        index:=parent;
                else
                        ready:=true;
                fi;
        od;
        #GBNP.THeapOTCheck(heap);
end;

# 2 3 4 <- 1, 5 6 7 <- 2, 8 9 10 <-3
GBNP.THeapOTGetChildrenIndex:=function(index)
        return [3*index-1, 3*index, 3*index+1];
end;

# 2 3 4 -> 1, 5 6 7 -> 2, 8 9 10 ->3
GBNP.THeapOTGetParentIndex:=function(index)
        return (index+1 - ((index+1)mod 3))/3;
end;

GBNP.THeapOTSwap:=function(heap, index1, index2)
local   swap;
        if index1=index2 then
                return;
        fi;

        swap:=heap!.list[index1];
        heap!.list[index1]:=heap!.list[index2];
        heap!.list[index2]:=swap;
        swap:=heap!.OT.arr2tree[index1];
        heap!.OT.arr2tree[index1]:=heap!.OT.arr2tree[index2];
        heap!.OT.arr2tree[index2]:=swap;
        heap!.OT.tree2arr[heap!.OT.arr2tree[index1]]:=index1;
        heap!.OT.tree2arr[heap!.OT.arr2tree[index2]]:=index2;
end;

GBNP.THeapOTCheck:=function(heap)
local   ok,
        i,
        j;

        ok:=true;
        if Length(heap!.list)<>Length(heap!.OT.arr2tree) then
                Print("heap lengths not equal: ", Length(heap!.list), " vs ", Length(heap!.OT.arr2tree), "\n");
                ok:=false;
        fi;
        for i in [1..Length(heap!.OT.arr2tree)] do
                if heap!.OT.tree2arr[heap!.OT.arr2tree[i]]<>i then
                        if ok then
                                Print("arr2tree vs tree2arr link wrong at ",i, "\n");
                                ok:=false;
                        fi;
                fi;
        od;
        for i in [1..Length(heap!.list)] do
                j:=GBNP.OccurInLstT(heap!.list[i][1][1], heap!.OT)[1];
                if j=0 then
                        if ok then
                                Print("OT tree does not contain todo[", i,"]\n");
                                ok:=false;
                        fi;
                else
                        if (i<>j) and (heap!.list[i][1][1]<>heap!.list[j][1][1]) then
                                if ok then
                                        Print("OT tree gives wrong answer for [", i,"]\n");
                                        ok:=false;
                                fi;
                        fi;
                fi;
        od;

        for i in [1..Length(heap!.list)] do
                if LtNP(heap!.list[i][1][1],heap!.list[1][1][1]) then
                        if ok then
                                Print("Warning minimum not correct at position ", i, "\n",1/0);
                                ok:=false;
                        fi;
                fi;
        od;
        return ok;
end;
