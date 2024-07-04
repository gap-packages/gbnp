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

### filename = "nparith.gi"
### vs 0.9
### (04/09/23) added LMonNP, LTermNP and LTermsNP
### (21/09/23) added FactorOutGcdNP

### THIS IS PART OF A GAP PACKAGE FOR COMPUTING WITH NON-COMMUTATIVE POLYNOMIALS

#AddNP:=function(u,v,c,d) local ans,hlp; -> now in nparith3.gi
#LtNP:=function(u,v)
#GtNP:=function(u,v)
#LMonNP:=function(pol)
#LMonsNP:=function(lst)
#LTermNP:=function(pol)
#LTermsNP:=function(lst)
#CleanNP:=function(pol) local i,h,l,v,mons,polh,coeffs,ansmons,anscoeffs;
#MkMonicNP:=function(pol)
#FactorOutGcdNP:=function(pol)
#BimulNP:=function(ga,u,dr) local i,ans;
#MulNP:=function(u,v) local ans,i,j;
#GBNP.LTermsTrace:=function(pol) local i;
#GBNP.MkMonicNPTrace:=function(pol) local i,ans,lc;
#GBNP.AddTrace:=function(trace,le,new,ri,scal) local ans,k,j;
#GBNP.TraceNP:=function(trace,G) local i,l,ans,temp;
#GBNP.Traced:=function(G) local ans,pol,i,n;
#GBNP.IsNPMNotZero:=function(np)
#NumAlgGensNP:=function(np)
#NumAlgGensNPList:=function(Lnp)
#NumModGensNP:=function(npm)
#NumModGensNPList:=function(Lnpm)

##################
### AddNP
### <#GAPDoc Label="AddNP">
### <ManSection>
### <Func Name="AddNP" Comm="" Arg="u, v, c, d" />
### <Returns>
### <A>c</A><M>*</M><A>u</A><M>+</M><A>d</A><M>*</M><A>v</A>
### </Returns>
### <Description>
### Computes <A>c</A><M>*</M><A>u</A><M>+</M><A>d</A><M>*</M><A>v</A>
### where <A>u</A> and <A>v</A> are polynomials in NP format
### and <A>c</A> and <A>d</A> are scalars.
### <P/>
### <#Include Label="example-AddNP">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Computes c*u+d*v where u,v are non-commutative Polynomials
### and c and d are scalars
###
### Arguments:
### u,v         - two non-commutative polynomial
### c,d         - two scalars
###
### Returns:
### pol         - the non-commutative polynomial c*u+d*v
###
### #AddNP uses: LtNP#
### #AddNP is used in: EvalTrace GBNP.GP2NPM GBNP.IsGrobnerBasisTest GBNP.NormalForm2 GBNP.NormalForm2T GBNP.Spoly GBNP.SpolyTrace GBNP.StrongNormalForm2 GBNP.StrongNormalForm2TS GBNP.StrongNormalForm2TSPTS GBNP.StrongNormalForm2Tall GBNP.StrongNormalForm3Dall GBNP.StrongNormalFormTrace2 GBNP.TraceNP StrongNormalFormTraceDiff#
###

InstallGlobalFunction( AddNP, function(u,v,c,d)
    local lans,ans,posu,posv,posans,ulen,vlen,co;
        ans:=[[],[]];
        # don't add the polynomial if the coefficient is zero
        if IsZero(c) then
                u:=[[],[]];
        fi;
        if IsZero(d) then
                v:=[[],[]];
        fi;

        lans:=Length(u[1])+Length(v[1]);

        posu:=1;
        posv:=1;
        posans:=1;
        ulen:=Length(u[1]);
        vlen:=Length(v[1]);
        while posans<=lans do
                if posu>ulen then
                        ans[1][posans]:=v[1][posv];
                        ans[2][posans]:=v[2][posv]*d;
                        posv:=posv+1;
                elif posv>vlen then
                        ans[1][posans]:=u[1][posu];
                        ans[2][posans]:=u[2][posu]*c;
                        posu:=posu+1;
                elif LtNP(u[1][posu],v[1][posv]) then
                        ans[1][posans]:=v[1][posv];
                        ans[2][posans]:=v[2][posv]*d;
                        posv:=posv+1;
                elif u[1][posu]=v[1][posv] then
                        co:=u[2][posu]*c+v[2][posv]*d;
                        if not IsZero(co) then
                                ans[1][posans]:=v[1][posv];
                                ans[2][posans]:=co;
                                lans:=lans-1;
                        else
                                lans:=lans-2;
                                posans:=posans-1; #stay the same...
                        fi;
                        posu:=posu+1;
                        posv:=posv+1;
                else # u[1][posu] greater than v[1][posv]
                        ans[1][posans]:=u[1][posu];
                        ans[2][posans]:=u[2][posu]*c;
                        posu:=posu+1;
                fi;
                posans:=posans+1;
        od;
        return [ans[1]{[1..lans]},ans[2]{[1..lans]}];
end);

##################
### LtNP
### <#GAPDoc Label="LtNP">
### <ManSection>
### <Func Name="LtNP" Comm="less than" Arg="u, v" />
### <Returns>
### <C>true</C> if <M>u &lt; v</M> and <C>false</C> if <M>u \geq v</M>
### </Returns>
### <Description>
### Less than function for NP monomials, tests whether
### <A>u</A><M>&lt;</M><A>v</A>. The ordering is done by degree and then
### lexicographically.
### <P/>
### <#Include Label="example-LtNP">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - 'Less than' function
###
### Arguments:
### u,v         - two monomials
###
### Returns:
### true        - if u < v
### false       - if u >= v
###
### #LtNP uses:#
### #LtNP is used in: AddNP GBNP.IsGrobnerBasisTest GBNP.LeftObsT GBNP.LeftOccur GBNP.Occur GBNP.ReducePol2 GBNP.ReducePolTrace2 GBNP.RightObsT GBNP.RightOccur GBNP.THeapOTBalanceDown GBNP.THeapOTBalanceUp GBNP.THeapOTCheck THeapOT#
###

InstallGlobalFunction(
LtNP,function(u,v)
    if Length(u)<Length(v) then
           return(true);
    elif Length(u)=Length(v) then
               return(u<v);
    else return(false);
    fi;
end);;



##################
### GtNP
### <#GAPDoc Label="GtNP">
### <ManSection>
### <Func Name="GtNP" Comm="greater than" Arg="u, v" />
### <Returns>
### <C>true</C> if <M>u &gt; v</M> and <C>false</C> if <M>u \leq v</M>
### </Returns>
### <Description>
### Greater than function for monomials <A>u</A> and <A>v</A> represented as in Section
### <Ref Sect="NP"/>. It tests whether
### <A>u</A><M>&gt;</M><A>v</A>. The ordering is done by degree and then
### lexicographically.
### <P/>
### <#Include Label="example-GtNP">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - 'Greater than' function
###
### Arguments:
### u,v         - two monomials
###
### Returns:
### true        - if u > v
### false       - if u <= v
###
### used in:    - CleanNP
### #GtNP uses:#
### #GtNP is used in:#
###

InstallGlobalFunction( GtNP, function(u,v)
    if Length(u)>Length(v) then
           return(true);
    elif Length(u)=Length(v) then
               return(u>v);
    else
        return(false);
    fi;
end);;

##################
### LMonNP and LMonsNP
###
### <#GAPDoc Label="LMonsNP">
### <ManSection>
### <Func Name="LMonNP" Comm="returns the leading monomial of a noncommutative polynomial" Arg="Lnp" />
### <Func Name="LMonsNP" Comm="returns the leading monomials of a list of noncommutative polynomials" Arg="Lnp" />
###
### <Returns>
### The leading monomial or a list of leading monomials.
### </Returns>
###
### <Description>
### These functions return the leading monomial of a polynomial
### (resp. the leading monomials of a list of polynomials) in NP format.
### The polynomials of <A>Lnp</A> are required to be clean;
### see Section <Ref Sect="CleanNP"/>.
### <P/>
### <#Include Label="example-LMonsNP">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### - Returns the leading monomial(s) of a (list of)
### Noncommutative Polynomials.
### The polynomials are ordered such that the leading monomial comes first.
### If the zero polynomial is given as argument then 'fail' is returned.
###
### Arguments:
### pol         - list of Noncommutative Polynomials
###
### Returns:
### - a list of leading monomials
###
### #LMonsNP uses:#
### #LMonsNP is used in: BaseQA BaseQM DimQA DimQM GBNP.AllObs GBNP.AllObsTrunc GBNP.CentralT GBNP.CheckHom GBNP.IsGrobnerBasisTest GBNP.NormalForm2 GBNP.ObsTall GBNP.ObsTrunc GBNP.ReducePol2 GBNP.SGrobnerLoops GBNP.SGrobnerTrunc GBNP.StrongNormalForm2 IsGrobnerPair MakeGrobnerPair THeapOT#
###

InstallGlobalFunction( LMonNP, function(pol)
    if IsZero(pol) then
        return fail;
    else
        return pol[1][1];
    fi;
end);

InstallGlobalFunction(LMonsNP, lst -> List(lst,LMonNP));

##################
### LTermNP and LTermsNP
###
### <#GAPDoc Label="LTermsNP">
### <ManSection>
### <Func Name="LTermNP" Comm="returns the leading term of a noncommutative polynomial" Arg="Lnp" />
### <Func Name="LTermsNP" Comm="returns the leading terms of a list of noncommutative polynomials" Arg="Lnp" />
###
### <Returns>
### The leading term or a list of leading terms.
### </Returns>
###
### <Description>
### These functions return the leading term of a polynomial
### (resp. the leading terms of a list of polynomials) in NP format.
### The polynomials of <A>Lnp</A> are required to be clean;
### see Section <Ref Sect="CleanNP"/>.
### <P/>
### </Description>
### </ManSection>
### <Example>
### gap> p1 := [[[1,1,2],[1]],[6,-7]];;
### gap> p2 := [[[1,2,2],[2]],[8,-9]];;
### gap> Lnp := [p1,p2];;
### gap> LTermNP( p1 );
### [ [ [ 1, 1, 2 ] ], [ 6 ] ]
### gap> LTnp := LTermsNP( Lnp );
### [ [ [ [ 1, 1, 2 ] ], [ 6 ] ], [ [ [ 1, 2, 2 ] ], [ 8 ] ] ]
### gap> PrintNPList( LTnp );
### 6a^2b
### 8ab^2
### </Example>
### <#/GAPDoc>
###
### - Returns the leading term(s) of a (list of)
### Noncommutative Polynomials.
### The polynomials are ordered such that the leading monomial comes first.
### If the zero polynomial is given as argument then 'fail' is returned.
###
### Arguments:
### pol     - list of Noncommutative Polynomials
###
### Returns:
### - a list of leading monomials
###
### #LTermNP uses:#
### #LTermNP is used in:#
###

InstallGlobalFunction( LTermNP, function(pol)
    if IsZero(pol) then
        return fail;
    else
        return [ [ pol[1][1] ], [ pol[2][1] ] ];
    fi;
end);

InstallGlobalFunction(LTermsNP, lst -> List(lst,LTermNP));

##################
### CleanNP
### <#GAPDoc Label="CleanNP">
### <ManSection>
### <Func Name="CleanNP" Comm="clean up for NP" Arg="u" />
### <Returns>
### The cleaned up version of <A>u</A>
### </Returns>
### <Description>
### Given a polynomial in NP format, this function
### collects terms with same monomial, removes trivial monomials,
### and orders the monomials, with biggest one first.
### <P/>
### <#Include Label="example-CleanNP">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Collects terms with same monomial, removes trivial monomials,
###   and orders the monomials, with biggest one first
###
### Arguments:
### pol         - non-commutative polynomial
###
### Returns:
### pol         - the cleaned version of the non-commutative polynomial
###
### #CleanNP uses:#
### #CleanNP is used in: CheckHomogeneousNPs EvalTrace GBNP.GP2NPM GBNP.IsGrobnerBasisTest GBNP.MakeGrobnerPairMakeMonic GBNP.NPArray2NPM GBNP.ReducePol GBNP.ReducePolTrace GP2NP IsGrobnerPair MulNP StrongNormalFormNP#
###

InstallGlobalFunction( CleanNP, function(pol)
    local i,h,l,v,mons,polh,coeffs,ansmons,anscoeffs;
    polh:=StructuralCopy(pol);
    SortParallel(polh[1],polh[2],GtNP);
    mons:=polh[1];
    coeffs:=polh[2];
    ansmons:=[];
    anscoeffs:=[];
    l:=Length(pol[1]);
        h:=0;
        while h<l do
          h:=h+1;
          i:=h;
          v:=coeffs[h];
          while i<l and mons[i]=mons[i+1] do
            v:=v+coeffs[i+1];
            i:=i+1;
          od;
          if not IsZero(v) then
            Add(ansmons,mons[h]);
            Add(anscoeffs,v);
          fi;
          h:=i;
        od;
     return([ansmons,anscoeffs]);
end);;

##################
### MkMonicNP
### <#GAPDoc Label="MkMonicNP">
### <ManSection>
### <Func Name="MkMonicNP" Comm="makes an NP monic by multiplying with the right scalar." Arg="np" />
### <Returns>
### <A>np</A> made monic
### </Returns>
### <Description>
### This function returns the scalar multiple of a polynomial
### <A>np</A> in NP format that is monic, i.e., has leading coefficient equal to 1.
### <P/>
### <#Include Label="example-MkMonicNP">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Makes a non-commutative polynomial
###   monic by multiplying with the right scalar
###
### Assumptions:
### - The polynomial is cleaned.
### - The leading term comes first.
###
### Arguments:
### pol         - non-commutative polynomial
###
### Returns:
### pol         - the monic version of the non-commutative polynomial
###
### #MkMonicNP uses:#
### #MkMonicNP is used in: GBNP.CentralT GBNP.IsGrobnerBasisTest GBNP.MakeGrobnerPairMakeMonic GBNP.ObsTall GBNP.ObsTrunc GBNP.ReducePol GBNP.ReducePol2 GBNP.SGrobnerLoops IsGrobnerPair StrongNormalFormNP#
###

InstallGlobalFunction( MkMonicNP, function(pol)
    if pol=[[],[]] then
        return(pol);
    fi;
    if IsOne(pol[2][1]) then
        return(pol);
    fi;
    return([pol[1],pol[2]/pol[2][1]]);
end);;

##################
### FactorOutGcdNP
### <#GAPDoc Label="FactorOutGcdNP">
### <ManSection>
### <Func Name="FactorOutGcdNP"
### Comm="divides an NP polynomial with integer coefficients by
### the Gcd of its coefficients." Arg="np" />
### <Returns>
### <A>np</A> with Gcd(coefficients) factored out
### </Returns>
### <Description>
### This function returns the scalar multiple of a polynomial
### <A>np</A> in NP format with integer coefficients
### such that its coefficients have Gcd equal to 1.
### If the coefficients are not all integers then <C>fail</C> is returned.
### <P/>
### <#Include Label="example-FactorOutGcdNP">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Makes a non-commutative polynomial with integer coeffiecients
###   into one whose coefficients have Gcd equal to 1.
###
### Assumptions:
### - The polynomial is cleaned.
### - The leading term comes first.
###
### Arguments:
### pol         - non-commutative polynomial
###
### Returns:
### pol        - the non-commutative polynomial divided by Gcd(coefficients)
###
### #FactorOutGcdNP uses:#
### #FactorOutGcdNP is used in: #
###

InstallGlobalFunction( FactorOutGcdNP, function(pol)
    local g;
    if pol=[[],[]] then
        return(pol);
    fi;
    if not ForAll( pol[2], c -> IsInt(c) ) then
        return fail;
    fi;
    g := Gcd( pol[2] );
    return([pol[1],pol[2]/g]);
end);;

#################
### BimulNP
### <#GAPDoc Label="BimulNP">
### <ManSection>
### <Func Name="BimulNP" Comm="" Arg="ga, np, dr" />
### <Returns>
###  the polynomial <A>ga</A><M>*</M><A>np</A><M>*</M><A>dr</A> in
###  NP format
### </Returns>
### <Description>
### When called with a polynomial <A>np</A> and two monomials <A>ga</A>,
### <A>dr</A>,
### the function will return <A>ga</A><M>*</M><A>np</A><M>*</M><A>dr</A>.
### Recall from Section <Ref Sect="NP"/> that monomials are represented as lists.
### <P/>
### <#Include Label="example-BimulNP">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Multiplication of a polynomial by two monomials:
### one on the left and one on the right
###
### Arguments:
### u           - a non-commutative polynomial
### ga,dr       - two monomials
###
### Returns:
### pol         - the non-commutative polynomial ga*u*dr
###
### #BimulNP uses:#
### #BimulNP is used in: EvalTrace GBNP.NormalForm2 GBNP.NormalForm2T GBNP.Spoly GBNP.SpolyTrace GBNP.StrongNormalForm2 GBNP.StrongNormalForm2TS GBNP.StrongNormalForm2TSPTS GBNP.StrongNormalForm2Tall GBNP.StrongNormalForm3Dall GBNP.StrongNormalFormTrace2 GBNP.TraceNP#
###

InstallGlobalFunction( BimulNP, function(ga,u,dr)
    local i,ans;
    ans:=[];
    for i in u[1] do
       Add(ans,Concatenation(ga,i,dr));
    od;
    return([ans,u[2]]);
end);;

#################
### MulNP
### <#GAPDoc Label="MulNP">
### <ManSection>
### <Func Name="MulNP" Comm="Multiplication of two polynomials" Arg="np1, np2" />
### <Returns>
### <A>np1</A><M>*</M><A>np2</A>
### </Returns>
### <Description>
### When invoked with two polynomials <A>np1</A> and <A>np2</A> in NP format,
### this function will return the product <A>np1</A><M>*</M><A>np2</A>.
### <P/>
### <#Include Label="example-MulNP">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Multiplication of two non-commutative polynomials
###
### Arguments:
### u, v        - two non-commutative polynomial
###
###
### Returns:
### pol         - the product u*v
###
### #MulNP uses: CleanNP#
### #MulNP is used in: MulQA MulQM SGrobnerModule#
###

InstallGlobalFunction( MulNP, function(u,v)
    local ans,i,j;
    ans:=[[],[]];
    for i in [1..Length(u[1])] do
        for j in [1..Length(v[2])] do
            Add(ans[1],Concatenation(u[1][i],v[1][j]));
            Add(ans[2],u[2][i]*v[2][j]);
        od;
    od;
    return(CleanNP(ans));
end);;

##################
### GBNP.LTermsTrace
### - Returns the leading terms of a traced list of Noncommutative Polynomials.
### The polynomials are not zero and ordered such that
### the leading monomial comes first.
###
### Arguments:
### pol         - traced list of Noncommutative Polynomials.
###
### Returns:
### - a list of leading terms. (monomials)
###
### #GBNP.LTermsTrace uses:#
### #GBNP.LTermsTrace is used in: GBNP.AllObsTrace GBNP.CentralTrace GBNP.ObsTrace GBNP.ReducePolTrace2 GBNP.StrongNormalFormTrace2#
###

GBNP.LTermsTrace:=function(G)
    return(List(G,i->i.pol[1][1]));
end;

##################
### GBNP.MkMonicNPTrace
### - Makes a traced non-commutative polynomial
### monic by multiplying with the right scalar
###
### Assumptions:
### - The polynomial is cleaned
### - The leading term comes first.
###
### Arguments:
### pol         - traced non-commutative polynomial
###
### Returns:
### pol         - the monic version of the traced non-commutative polynomial
###
### #GBNP.MkMonicNPTrace uses:#
### #GBNP.MkMonicNPTrace is used in: GBNP.CentralTrace GBNP.ObsTrace GBNP.ReducePolTrace GBNP.ReducePolTrace2 GBNP.SGrobnerTraceLoop#
###

GBNP.MkMonicNPTrace:=function(mon) local i,ans,lc;

    if mon.pol=[[],[]] then return(mon); fi;
    if IsOne(mon.pol[2][1]) then return(mon); fi;
    ans:=StructuralCopy(mon);
    lc:=mon.pol[2][1];
    ans.pol[2]:=ans.pol[2]/lc;
        for i in [1..Length(ans.trace)] do
          ans.trace[i][4]:= ans.trace[i][4]/lc;
        od;
    return(ans);
end;;

#################
### GBNP.AddTrace
### - Updates the trace of a non-commutative polynomial h when somethings
###   is added to it, so h + scal * li G(i) re
###
### Arguments:
### trace       - trace of the non-commutative polynomial
### le          - left monomial
### new         - trace of added non-commutative polynomial
### ri          - right monomial
### scal        - scalar used in addition
###
### Returns:
### trace       - new trace of the non-commutative polynomial after addition
###
### #GBNP.AddTrace uses:#
### #GBNP.AddTrace is used in: GBNP.SpolyTrace GBNP.StrongNormalFormTrace2#
###

GBNP.AddTrace:=function(trace,le,new,ri,scal) local ans,k,j;

        ans:=StructuralCopy(new);
        k:=Length(new);
        for j in [1..k] do
          ans[j][1]:=Concatenation(le,ans[j][1]);
          ans[j][3]:=Concatenation(ans[j][3],ri);
          ans[j][4]:=scal*ans[j][4];
        od;
        return(Concatenation(trace,ans));
  end;;



#################
### GBNP.TraceNP
### - Computes non-commutative polynomial from trace
###
### Arguments:
### trace       - trace of a non-commutative polynomial w.r.t. G
### G           - set of non-commutative polynomials
###
### Returns:
### pol         - the non-commutative polynomial
###
### #GBNP.TraceNP uses: AddNP BimulNP GBNP.TraceNP#
### #GBNP.TraceNP is used in: GBNP.TraceNP#
###

GBNP.TraceNP:=function(trace,G) local i,l,ans,temp;
        l:=Length(trace);
        i:=1;
        ans:=[[],[]];
        while i <= l do
                temp:=trace[i];
                if IsInt(temp[2]) then
                        ans:=AddNP(ans,BimulNP(temp[1],
                                G[temp[2]],temp[3]),1,temp[4]);
                else
                        ans:=AddNP(ans,BimulNP(temp[1],GBNP.TraceNP(
                                temp[2].trace,G),temp[3]),1,temp[4]);
                fi;
                i:=i+1;
        od;
        return(ans);
    end;;



#################
### GBNP.Traced
### - Computes and adds the trace of every element of a
###   set of non-commutative polynomials w.r.t. this set.
###
### Arguments:
### G           - set of non-commutative polynomials
###
### Returns:
### G           - set of traced non-commutative polynomials w.r.t. G
###
### #GBNP.Traced uses:#
### #GBNP.Traced is used in: GBNP.ReducePolTrace#
###

GBNP.Traced:=function(G) local ans,pol,i,n;
        i:=0;
        n:=Length(G);
        ans:=[];
        pol:=rec( pol:=[], trace:=[] );
        while i < n do
           i:=i+1;
           pol.pol:=G[i];
           pol.trace:=[[[],i,[],1]];    # jwk - check if this is the right field
           Add(ans,StructuralCopy(pol));
        od;
        return(ans);
end;;

#########################
### GBNP.IsNPMNotZero
### - Checking whether a polynomial is in NPM form or in NP form
###
### Arguments: np - the polynomial to be checked
### Returns: true if np is in NPM form (there is a monomial starting with a
###             negative number) and false otherwise (NP form or np = [[],[]] =
###             zero)
### #GBNP.IsNPMNotZero uses:#
### #GBNP.IsNPMNotZero is used in: GBNP.NPM2NPArray#
###

GBNP.IsNPMNotZero:=function(np)
        if Length(np[1])=0 or # zero
                Length(np[1][1])=0 or # NP monomial '1'
                np[1][1][1] > 0 then # NP monomial

                return false;
        fi; # else np[1][1][1] < 0, or np[1][1] is an NPM monomial

        return true;
end;

#####################
### GBNP.MaximumZ ###
#####################
###
### Calculate the maximum of a list. If the list is empty, return 0.
###
### Arguments:
### - lst       a list
###
### Returns:
### - the maximum element in lst, or 0 if the list is empty

GBNP.MaximumZ:=function(lst)
  if Length(lst) > 0 then
     return Maximum(lst);
  fi;
  return 0;
end;

####################
### NumAlgGensNP ###
####################
###
### <#GAPDoc Label="NumAlgGensNP">
### <ManSection>
### <Func Name="NumAlgGensNP" Comm="" Arg="np" />
### <Returns>
###  The minimum number <C>t</C> so that <A>np</A> belongs to the free
###  algebra on <C>t</C> generators.
### </Returns>
### <Description>
###   When called with an NP polynomial <A>np</A>, this function returns
###   the minimum number of generators needed for the corresponding algebra to
###   contain the <A>np</A>. If <A>np</A> is a polynomial
###   without generators, that is, equivalent to <M>0</M> or <M>1</M>, then <C>0</C> is
###   returned.
### <P/>
### <#Include Label="example-NumAlgGensNP">
### </Description>
### </ManSection>
### <#/GAPDoc>

### Calculate a minimum of the number of generators of the algebra containing
### np.
###
### Arguments:
### - np        an NP polynomial
###
### Returns:
### - the maximum value occurring in the monomials of np (or 0 if np is <0> or <1>)

InstallGlobalFunction(
NumAlgGensNP,function(np)
  return Maximum([GBNP.MaximumZ(List(np[1], x -> GBNP.MaximumZ(x))),0]);
end);

########################
### NumAlgGensNPList ###
########################
###
### <#GAPDoc Label="NumAlgGensNPList">
### <ManSection>
### <Func Name="NumAlgGensNPList" Comm="" Arg="Lnp" />
### <Returns>
###  The minimum number <C>t</C> so that each polynomial in <A>Lnp</A>
###  belongs to the free
###  algebra on <C>t</C> generators.
### </Returns>
### <Description>
###   When called with a list of NP polynomials <A>Lnp</A>, this function returns
###   the minimum number of generators needed for the corresponding algebra to
###   contain the NP polynomials in <A>Lnp</A>. If <A>Lnp</A> only contains polynomials
###   without generators, that is equivalent to <M>0</M> and <M>1</M>, then <C>0</C> is
###   returned.
### <P/>
### <#Include Label="example-NumAlgGensNPList">
### </Description>
### </ManSection>
### <#/GAPDoc>

### Calculate a minimum of the number of generators of the algebra containing
### the polynomials in Lnp.
###
### Arguments:
### - Lnp       a list of NP polynomials
###
### Returns:
### - the maximum value occurring in the monomials of Lnp (or 0 if only <0> or <1> occur)

InstallGlobalFunction(
NumAlgGensNPList,function(Lnp)
  return GBNP.MaximumZ(List(Lnp, x -> NumAlgGensNP(x)));
end);

############################
### GBNP.NumAlgGensNPmon ###
############################
###
### Calculate the highest algebra generator in an NP monomial
###
### Arguments:
### - np_mon    a NP monomial
###
### Returns:
### - the highest algebra generator occurring in np_mon

GBNP.NumAlgGensNPmon:=function(np_mon)
     return Maximum([GBNP.MaximumZ(np_mon),0]);
end;

################################
### GBNP.NumAlgGensNPmonList ###
################################
###
### Calculate the highest algebra generator in a list of NP monomials
###
### Arguments:
### - Lnp_mon   a list of NP monomials
###
### Returns:
### - the highest algebra generator occurring in Lnp_mon

GBNP.NumAlgGensNPmonList:=function(Lnp_mon)
     return Maximum([GBNP.MaximumZ(List(Lnp_mon, x -> GBNP.NumAlgGensNPMon(x))),0]);
end;

#####################
### GBNP.MinimumZ ###
#####################
###
### returns the smallest element in a list (or 0 in case of an empty list)
###
### Arguments:
### - lst       a list
###
### Returns:
### - the minimum element in the list lst (or 0 if lst was empty)

GBNP.MinimumZ:=function(lst)
  if Length(lst) > 0 then
     return Minimum(lst);
  fi;

  return 0;
end;

####################
### NumModGensNP ###
####################
###
### <#GAPDoc Label="NumModGensNP">
### <ManSection>
### <Func Name="NumModGensNP" Comm="" Arg="npm" />
### <Returns>
###  The minimum number <C>mt</C> so that <A>npm</A> belongs to the free
###  module on <C>mt</C> generators.
### </Returns>
### <Description>
###   When called with a polynomial <A>npm</A> in NPM format, this function returns
###   the minimum number of module generators needed for the corresponding
###   algebra to contain <A>npm</A>. If <A>npm</A> is an NP
###   polynomial that does not contain module generators, then <C>0</C> is
###   returned.
### <P/>
### <#Include Label="example-NumModGensNP">
### </Description>
### </ManSection>
### <#/GAPDoc>

### Calculate the minimum of the number of generators needed in the algebra
### containing npm.
###
### Arguments:
### - npm       an NP polynomial
###
### Returns:
### - the minimum number of module generators needed to contain npm

InstallGlobalFunction(
NumModGensNP,function(npm)
  local ans;

  if Length(npm[1]) = 0 then return 0; fi;
  if Length(npm[1][1]) = 0 then return 0; fi;

  ans := -Minimum([GBNP.MinimumZ(List(npm[1], x -> GBNP.MinimumZ(x))),0]);
  return ans;
end);

########################
### NumModGensNPList ###
########################
### <#GAPDoc Label="NumModGensNPList">
### <ManSection>
### <Func Name="NumModGensNPList" Comm="" Arg="Lnpm" />
### <Returns>
###  The minimum number <C>mt</C> so that each member of <A>npm</A> belongs
###  to the free module on <C>mt</C> generators.
### </Returns>
### <Description>
###   When called with a list of polynomials <A>Lnpm</A> in NPM format, this function returns
###   the minimum number of module generators needed to contain the
###   polynomials in <A>Lnpm</A>. If there are only polynomials in
### <A>Lnpm</A> in NP format, then <C>0</C> is returned.
### <P/>
### <#Include Label="example-NumModGensNPList">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### Calculate a minimum of the number of generators of the algebra containing
### the polynomials in Lnpm.
###
### Arguments:
### - Lnpm      a list of npm polynomials
###
### Returns:
### - the minimum number of module generators needed to contain the
###   polynomials in <A>Lnpm</A>. If there are only polynomials in
###   <A>Lnpm</A> in NP format, then <M>0</M> is returned.

InstallGlobalFunction(
NumModGensNPList,function(Lnpm)
     return GBNP.MaximumZ(List(Lnpm, x -> NumModGensNP(x)));
end);

############################
### GBNP.NumModGensNPmon ###
############################
###
### Calculate the minimum number of module generators of the algebra containing
### an NP monomial.
###
### Arguments:
### - npm_mon   a NP monomial
###
### Returns:
### - the minimum number of module generators in the algebra containing npm_mon

GBNP.NumModGensNPmon:=function(npm_mon)
     return -Minimum([GBNP.MinimumZ(npm_mon),0]);
end;

################################
### GBNP.NumModGensNPmonList ###
################################
###
### Calculate the minimum number of module generators of the algebra containing
### the NP monomials in a list.
###
### Arguments:
### - Lnpm_mon  a list of NP monomials
###
### Returns:
### - the minimum number of module generators in the algebra containing the
###   monomials in Lnpm_mon

GBNP.NumModGensNPmonList:=function(Lnpm_mon)
     return Maximum([GBNP.MaximumZ(List(Lnpm_mon, x -> GBNP.NumModGensNPMon(x))),0]);
end;
