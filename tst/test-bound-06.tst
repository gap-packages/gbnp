gap> START_TEST("GBNP test-bound-06");
gap> ######################### BEGIN COPYRIGHT MESSAGE #########################
gap> # GBNP - computing Gröbner bases of noncommutative polynomials
gap> # Copyright 2001-2010 by Arjeh M. Cohen, Dié A.H. Gijsbers, Jan Willem
gap> # Knopper, Chris Krook. Address: Discrete Algebra and Geometry (DAM) group
gap> # at the Department of Mathematics and Computer Science of Eindhoven
gap> # University of Technology.
gap> #
gap> # For acknowledgements see the manual. The manual can be found in several
gap> # formats in the doc subdirectory of the GBNP distribution. The
gap> # acknowledgements formatted as text can be found in the file chap0.txt.
gap> #
gap> # GBNP is free software; you can redistribute it and/or modify it under
gap> # the terms of the Lesser GNU General Public License as published by the
gap> # Free Software Foundation (FSF); either version 2.1 of the License, or
gap> # (at your option) any later version. For details, see the file 'LGPL' in
gap> # the doc subdirectory of the GBNP distribution or see the FSF's own site:
gap> # https://www.gnu.org/licenses/lgpl.html
gap> ########################## END COPYRIGHT MESSAGE ##########################
gap> 
gap> LoadPackage("gbnp", false);
true
gap> 
gap> check:=function (l, i)
>   # exact answer matches
>   if IsInt(l) and l=i then
>       return true;
>   fi;
>   # no exact answer, but correct answer is in interval
>   if IsList(l) and l[1]<=i and i<=l[2] then
>       return true;
>   fi;
>   # not a correct answer
>   return false;
> end;
function( l, i ) ... end
gap> 
gap> # DetermineGrowthQA
gap> DetermineGrowthQA([],2,true)="exponential growth";
true
gap> DetermineGrowthQA([[1]],2,true)=1;
true
gap> DetermineGrowthQA([[1,2]],2,true)=2;
true
gap> DetermineGrowthQA([[2,1]],2,true)=2;
true
gap> DetermineGrowthQA([[1,2,1],[2,2,1]],2,true)=2; # correct
true
gap> DetermineGrowthQA([[1],[2]],2,true)=0; # correct
true
gap> 
gap> DetermineGrowthQA([],2,false)="exponential growth";
true
gap> DetermineGrowthQA([[1]],2,false)=1;
true
gap> check(DetermineGrowthQA([[1,2]],2,false),2);
true
gap> DetermineGrowthQA([[2,1]],2,false)=2;
true
gap> DetermineGrowthQA([[1,2,1],[2,2,1]],2,false)=2; # correct
true
gap> DetermineGrowthQA([[1],[2]],2,false)=0; # correct
true
gap> 
gap> # FinCheckQA
gap> FinCheckQA([],2)=false;
true
gap> FinCheckQA([[]],2);
true
gap> FinCheckQA([[1],[2]],2);
true
gap> FinCheckQA([[1],[2]],2);
true
gap> FinCheckQA([[2]],2)=false;
true
gap> 
gap> # HilbertSeriesQA
gap> HilbertSeriesQA([],2,10)=[1,2,4,8,16,32,64,128,256,512,1024];
true
gap> HilbertSeriesQA([[]],2,10)=[];
true
gap> HilbertSeriesQA([[1,2]],2,10)=[1,2,3,4,5,6,7,8,9,10,11];
true
gap> HilbertSeriesQA([[2,1]],2,10)=[1,2,3,4,5,6,7,8,9,10,11];
true
gap> HilbertSeriesQA([[1]],2,10)=[1,1,1,1,1,1,1,1,1,1,1];
true
gap> HilbertSeriesQA([[1,2,1],[2,2,1]],2,10)=[ 1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20 ];
true
gap> 
gap> # PreprocessAnalysisQA
gap> 
gap> PreprocessAnalysisQA([],2,10)=[];
true
gap> PreprocessAnalysisQA([[]],2,10)=[[]];
true
gap> 
gap> # now for some not completely trivial ones, that tested true when I wrote them
gap> PreprocessAnalysisQA([[1,2],[1,1],[2,2]],2,1)=[[1,1],[2]];
true
gap> PreprocessAnalysisQA([[1,2],[1,1],[2,2]],2,2)=[[1],[2]];
true
gap> 
gap> STOP_TEST("test-bound-06.g",10000);
