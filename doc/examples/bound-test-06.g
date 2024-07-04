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

LoadPackage("gbnp", false);

check:=function (l, i)
        # exact answer matches
        if IsInt(l) and l=i then
                return true;
        fi;
        # no exact answer, but correct answer is in interval
        if IsList(l) and l[1]<=i and i<=l[2] then
                return true;
        fi;
        # not a correct answer
        return false;
end;

# DetermineGrowthQA
DetermineGrowthQA([],2,true)="exponential growth";
DetermineGrowthQA([[1]],2,true)=1;
DetermineGrowthQA([[1,2]],2,true)=2;
DetermineGrowthQA([[2,1]],2,true)=2;
DetermineGrowthQA([[1,2,1],[2,2,1]],2,true)=2; # correct
DetermineGrowthQA([[1],[2]],2,true)=0; # correct

DetermineGrowthQA([],2,false)="exponential growth";
DetermineGrowthQA([[1]],2,false)=1;
check(DetermineGrowthQA([[1,2]],2,false),2);
DetermineGrowthQA([[2,1]],2,false)=2;
DetermineGrowthQA([[1,2,1],[2,2,1]],2,false)=2; # correct
DetermineGrowthQA([[1],[2]],2,false)=0; # correct

# FinCheckQA
FinCheckQA([],2)=false;
FinCheckQA([[]],2);
FinCheckQA([[1],[2]],2);
FinCheckQA([[1],[2]],2);
FinCheckQA([[2]],2)=false;

# HilbertSeriesQA
HilbertSeriesQA([],2,10)=[1,2,4,8,16,32,64,128,256,512,1024];
HilbertSeriesQA([[]],2,10)=[];
HilbertSeriesQA([[1,2]],2,10)=[1,2,3,4,5,6,7,8,9,10,11];
HilbertSeriesQA([[2,1]],2,10)=[1,2,3,4,5,6,7,8,9,10,11];
HilbertSeriesQA([[1]],2,10)=[1,1,1,1,1,1,1,1,1,1,1];
HilbertSeriesQA([[1,2,1],[2,2,1]],2,10)=[ 1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20 ];

# PreprocessAnalysisQA

PreprocessAnalysisQA([],2,10)=[];
PreprocessAnalysisQA([[]],2,10)=[[]];

# now for some not completely trivial ones, that tested true when I wrote them
PreprocessAnalysisQA([[1,2],[1,1],[2,2]],2,1)=[[1,1],[2]];
PreprocessAnalysisQA([[1,2],[1,1],[2,2]],2,2)=[[1],[2]];
