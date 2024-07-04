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

### filename = "npformat.gi"
### author Cohen & Gijsbers

# THIS IS PART OF A NON COMMUTATIVE GROBNER BASIS PACKAGE FOR GAP

#functions defined in this file:
#GBNP.Coefs:=function(gp)
#GBNP.Mons:=function(gp)
#GP2NP:=function(gp)
#GP2NPList:=function(Lgp)
#GBNP.AddGP2NPList:=function(Lnp,gp)
#NP2GP:=function(np,A)
#NP2GPList:=function(Lnp,A)
#GBNP.NPArray2NPM:=function(nparr)
#GBNP.NPM2NPArray:=function(arg) (npm [, mt])
#GBNP.GP2NPM:=function(gp)
#GBNP.NPM2GP:=function(np,D)
#GBNP.SplitNP:=function(np,B)
#MatrixQA:=function(i,B,GB)
#MatricesQA:=function(t,B,GB)
#MatrixQAC:=function(i,B,GB)
#MatricesQAC:=function(t,B,GB)

##################
### GBNP.Coefs ###
##################
### - gives the coefficients of a gap polynomial
###
### #GBNP.Coefs  uses:#
### #GBNP.Coefs is used in: GBNP.GP2NPM GP2NP#
###

GBNP.Coefs := function(gp) local ans, i,l, ea;
   ea := ExtRepOfObj(gp)[2];
   ans := [];
   l := Length(ea);
   for i in [1..l/2] do
      Add(ans,ea[2*i]);
   od;
  return(ans);
end;

#################
### GBNP.Mons ###
#################
### - gives the monomials of a gap polynomial
###
### #GBNP.Mons uses:#
### #GBNP.Mons is used in: GBNP.GP2NPM GP2NP
###

GBNP.Mons := function(gp) local ans, i,j,k,l,m, ea, hlp;
   ea := ExtRepOfObj(gp)[2];
   ans := [];
   l := Length(ea);
   for i in [1..l/2] do
      hlp := [];
      m := ea[2*i-1];
#      Print("m is ",m,"\n");
      for j in [1..Length(m)/2] do
         for k in [1..m[2*j]] do
            Add(hlp,m[2*j-1]);
         od;
      od;
      Add(ans,hlp);
   od;
  return(ans);
end;



#############
### GP2NP ###
#############
###
### <#GAPDoc Label="GP2NP">
### <ManSection>
### <Func Name="GP2NP" Comm="Convert polynomials to NP form" Arg="gp"/>
###
### <Returns>If <A>gp</A> is an element of a free algebra,
### then the polynomial in NP format (see
### Section <Ref Sect="NP"/>) corresponding to
### <A>gp</A>; if <A>gp</A> is an element of a free module, then
### the vector in NPM format (see
### Section <Ref Sect="NPM"/>)
### corresponding to <A>gp</A>.
### </Returns>
### <Description>
### This function will convert an element of a free algebra to a
### polynomial in NP format and an element of a free right module
### to a vector in NPM format.
### <P/>
### <#Include Label="example-GP2NP">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - GAP poly to our NP
###
### #GP2NP uses: CleanNP GBNP.Coefs GBNP.GP2NPM GBNP.Mons#
### #GP2NP is used in: GBNP.AddGP2NPList GP2NPList#
###

InstallGlobalFunction(
GP2NP , function(gp)
  if IsList(gp) then
    return GBNP.GP2NPM(gp); # NPM polynomial
  else
    return(CleanNP([GBNP.Mons(gp),GBNP.Coefs(gp)]));
  fi;
end);


#################
### GP2NPList ###
#################
### <#GAPDoc Label="GP2NPList">
### <ManSection>
### <Func Name="GP2NPList" Comm="Convert a list of polynomials to NP format."
### Arg="Lgp"/>
###
### <Returns>The list of polynomials
### in NP or NPM format corresponding to elements
### of a free algebra or module occurring in the list <A>Lgp</A>.
### </Returns>
### <Description>
### This function has the same effect as
### <C>List(Lgp,GBNP)</C>.
### <P/>
### <#Include Label="example-GP2NPList">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - List GAP poly to List our NP
###
### #GP2NPList uses: GP2NP#
### #GP2NPList is used in:#
###

InstallGlobalFunction(
GP2NPList , function(Lgp) local gp,ans;
  ans:=[];
  for gp in Lgp do
   Add(ans,GP2NP(gp));
  od;
  return(ans);
end);

# Max Horn says: get rid of this as you can replace by List(Lgp, GP2NP)

#########################
### GBNP.AddGP2NPList ###
#########################
### - Add GAP poly to List our NP
###
### #GBNP.AddGP2NPList uses: GP2NP#
### #GBNP.AddGP2NPList is used in:#
###

GBNP.AddGP2NPList := function(Lnp, gp) local ans;
  ans:=ShallowCopy(Lnp);
  Add(ans,GP2NP(gp));
  return(ans);
end;


#############
### NP2GP ###
#############
### <#GAPDoc Label="NP2GP">
### <ManSection>
### <Func Name="NP2GP" Comm="Convert polynomials from NP format" Arg="np, A"/>
###
### <Returns>The GAP format of the polynomial <A>np</A> in NP format.</Returns>
### <Description>
### This function will convert a polynomial in NP format to a GAP
### polynomial in the free associative algebra <A>A</A>
### and a vector in NPM format to a GAP vector in the free module <A>A</A>.
### In case of the NP format, the number of variables
### should not exceed the rank of the free algebra
### <A>A</A>.
### In case of the NPM format, the absolute of the negative numbers
### should not exceed the rank of the free module
### <A>A</A>.
### <P/>
### <#Include Label="example-NP2GP">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - our NP to GAP poly
###
### #NP2GP uses: GBNP.NPM2GP#
### #NP2GP is used in: NP2GPList wordfun#
###

InstallGlobalFunction(
NP2GP , function(np, A) local hlp,e,fm, h,i,j,l, eans, staart, g, F;
  # no longer global g,F; - jwk vr aug 22 17:15:13 BST 2003

  if Length(np[1])>0 and (IsBound(np[1][1][1]) and np[1][1][1]<0) then
        return GBNP.NPM2GP(np, A); # np is in NPM format
  fi;

  if IsAlgebraWithOne(A) then
      g:=GeneratorsOfAlgebraWithOne(A);
  else
      g:=GeneratorsOfAlgebra(A);
  fi;
  F:=LeftActingDomain(A); # get the field of the algebra - jwk

  eans := [Zero(F)];
  staart := [];
  for i in [1..Length(np[1])] do
       hlp := [];
       j := 0;
       fm := np[1][i];
       l := Length(fm);
       while j<l do
         j := j+1;
         h := fm[j];
         e := 1;
         while j+e <=l and fm[j+e] = h do
           e := e+1;
         od;
         j:=j+e-1;
         Append(hlp,[h,e]);
       od;
       Add(staart,hlp);  Add(staart,np[2][i]);
  od;
  Add(eans,staart);
  return ObjByExtRep(FamilyObj(g[1]), eans );
end);

#################
### NP2GPList ###
#################
### <#GAPDoc Label="NP2GPList">
### <ManSection>
### <Func Name="NP2GPList" Comm="Convert a list of polynomials from NP format"
### Arg="Lnp, A"/>
###
### <Returns>The list of polynomials corresponding to <A>Lnp</A> in GAP format.
### </Returns>
### <Description>
### This function will convert the list <A>Lnp</A>
### of polynomials in NP format to a
### list of GAP polynomials in the free associative algebra <A>A</A>.
### <P/>
### <#Include Label="example-NP2GPList">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - List our NP poly to List GAP poly
###
### #NP2GPList uses: NP2GP#
### #NP2GPList is used in:#
###

InstallGlobalFunction(
NP2GPList , function(Lnp, A) local np,ans;
  ans:=[];
  for np in Lnp do
   Add(ans,NP2GP(np,A));
  od;
  return(ans);
end);

########################
### GBNP.NPM2NPArray ###
########################
### - converts a polynomial in NPM format to an array of polynomials
### in NP format
### Arguments: (variable)
### - npm               the polynomial to convert
### - mt (optional)     the number of module generators (and the size of the
###                     array that will be returned)
###
### Returns: the array of polynomials in NP format
###
### #GBNP.NPM2NPArray uses: GBNP.IsNPMNotZero#
### #GBNP.NPM2NPArray is used in: GBNP.PrintNPM#
###

GBNP.NPM2NPArray:=function(arg)
local   nparr,  # array of np polynomials to return
        npm,    # arg[1], the npm polynomial
        mt,     # the number of module generators (arg[2] or some lower bound)
        i,      # counter
        lnpm1;  # length of npm[1] (number of monomials in npm)

        if Length(arg)=0 then
                Error("At least one argument expected.");
        elif Length(arg)=1 then
                mt:=0;
        else
                mt:=arg[2];
        fi;
        npm:=arg[1];

        if not GBNP.IsNPMNotZero(npm) then
                if mt=0 then mt:=1; fi; # at least one dimension
                nparr:=List([1..mt],x->[[],[]]);
                nparr[1]:=npm;
                return nparr;
        fi;
        # npm is indeed in NPM format and not zero

        # NOTE: should be necessary only if mt = 0, but prevents errors if
        # NumModGensNP > mt) another option might be to print a warning or just
        # "fail"
        mt:=Maximum(mt,NumModGensNP(npm));

        nparr:=List([1..mt],x->[[],[]]);
        lnpm1:=Length(npm[1]);

        for i in [1..lnpm1] do
                Add(nparr[-npm[1][i][1]][1],npm[1][i]{[2..Length(npm[1][i])]});
                Add(nparr[-npm[1][i][1]][2],npm[2][i]);
        od;

        return nparr;
end;

########################
### GBNP.NPArray2NPM ###
########################
### - converts an array of polynomials in np format
### to a polynomial in NPM format
### Arguments:
### - nparr     the polynomial array to convert
###
### Returns: the cleaned NPM polynomial
###
### #GBNP.NPArray2NPM uses: CleanNP#
### #GBNP.NPArray2NPM is used in:#
###

GBNP.NPArray2NPM:=function(nparr)
local   npm,    # the npm polynomial to return
        mt,     # the number of module generators (size of nparr)
        i;      # counter

        mt:=Length(nparr);
        nparr:=[[],[]];
        for i in [1..mt] do
                Add(npm[1], List(nparr[i][1],x->Concatenation([-i],x)));
                Add(npm[2], nparr[i][2]);
        od;
        return CleanNP(npm);
end;

###################
### GBNP.GP2NPM ###
###################
###
### <#GAPDoc Label="GP2NPM">
### <ManSection>
### <Func Name="GP2NPM" Comm="Convert polynomials to NPM format" Arg="gp"/>
###
### <Returns>The polynomial <A>gp</A> converted to NP module form</Returns>
### <Description>
### This function will convert a polynomial to NPM format.
### </Description>
### </ManSection>
### <#/GAPDoc>
### - GAP poly to our NP
###
### #GBNP.GP2NPM uses: AddNP CleanNP GBNP.Coefs GBNP.GetOptions GBNP.Mons GBNP.SetOption#
### #GBNP.GP2NPM is used in: GP2NP#
###

GBNP.GP2NPM:=function(gp)
local   i,p,one;

        # this is probably not the best place for the option verifying
        if GBNP.GetOptions().pg=0 then
                GBNP.SetOption("pg", Length(gp));
        fi;

        one:=One(ZeroCoefficient(gp[1]));
        p:=[[],[]];
        for i in [1..Length(gp)] do
                p:=AddNP(p,
                        CleanNP([ # is this cleannp useful ? - jwk
                                List(GBNP.Mons(gp[i]),x->Concatenation([-i],x)),
                                GBNP.Coefs(gp[i])
                        ]),
                        one, one
                );
        od;
        CleanNP(p);
  return p;
end;

###################
### GBNP.NPM2GP ###
###################
### <#GAPDoc Label="NPM2GP">
### <ManSection>
### <Func Name="NPM2GP" Comm="Convert polynomials from NPM format" Arg="np, D"/>
###
### <Returns>The polynomial <A>np</A> converted from the NPM format</Returns>
### <Description>
### This function will convert a polynomial in NPM format with module relations to a GAP
### polynomial in the module <A>D</A> over a free associative algebra.
### </Description>
### </ManSection>
### <#/GAPDoc>
### - our NPM to GAP poly
### - this might not be very efficient
###
### #GBNP.NPM2GP uses:#
### #GBNP.NPM2GP is used in: NP2GP#
###

GBNP.NPM2GP:=function(np, D)
local   hlp,    # used in the loop and to calculate the return value
        e,      #
        fm,     #
        h,i,j,l,#
        zerof,  #
        staartarr,      #
        g,      # generators of A
        A,      # algebra of D
        F,      # field of the algebra
        s,      # dimension of D
        gd,     # generators of D
        gparr;  # arrays of polynomials in A (gd will be a sum of these)

  # no longer global g,F; - jwk vr aug 22 17:15:13 BST 2003
  A:=LeftActingDomain(D); # get the algebra of the module
  s:=Dimension(D);        # get the dimension of the module

  if IsAlgebraWithOne(A) then
      g:=GeneratorsOfAlgebraWithOne(A);
  else
      g:=GeneratorsOfAlgebra(A);
  fi;
  F:=LeftActingDomain(A); # get the field of the algebra - jwk

  zerof := Zero(F);
  staartarr := List([1..s],x->[]);
  for i in [1..Length(np[1])] do
       hlp := [];
       j := 1;  # fm[1] should be the module generator
                # so Length(fm) should be >0 and fm[1]<0 (Assert ?)
       fm := np[1][i];
       l := Length(fm);
       while j<l do
         j := j+1;
         h := fm[j];
         e := 1;
         while j+e <=l and fm[j+e] = h do
           e := e+1;
         od;
         j:=j+e-1;
         Append(hlp,[h,e]);
       od;
       Add(staartarr[-fm[1]],hlp);  Add(staartarr[-fm[1]],np[2][i]);
  od;

  hlp:=Zero(D);
  gd:=GeneratorsOfLeftModule(D);
  for i in [1..s] do
        hlp:=hlp+gd[i]*ObjByExtRep(FamilyObj(g[1]), [Zero(F),staartarr[i]]);
  od;

  return hlp;
end;

####################
### GBNP.SplitNP ###
####################
### - Split an np polynomial into a vector
### Arguments:
### - np        reduced np(m) polynomial to split
### - B         corresponding basis of the quotient algebra (should be
###             non-empty)
### Returns:
### - v         np as a vector (np = sum(v[i]*i-th mon from B))
### #GBNP.SplitNP uses:#
### #GBNP.SplitNP is used in: MatrixQA#
###

GBNP.SplitNP:=function(np,B)
local   v,      # return value so far
        i,      # counter
        zero,   # zero of the field
        one,    # one of the field
        pos;    # position of np[1][i] in B

        one:=B[1][2][1];
        zero:=Zero(one);
        v:=List([1..Length(B)],x->zero);

        for i in [1..Length(np[1])]
        do
                pos:=Position(B,[[np[1][i]],[one]]);

                if pos<>fail then
                        # pos=fail can only happen if B is not a basis or np is
                        # not reduced

                        v[pos]:=np[2][i];
                fi;
        od;
        return v;
end;

################
### MatrixQA ###
################
### <#GAPDoc Label="MatrixQA">
### <ManSection>
### <Func Name="MatrixQA" Comm="Creates a matrix representation" Arg="i, B, GB" />
### <Returns>
### The matrix representation for the <A>i</A>-th generator of the algebra for
### right multiplication in the quotient algebra
### </Returns>
### <Description>
### Given a basis <A>B</A> of the quotient algebra,
### a Gröbner basis (record) <A>GB</A>, and a natural number <A>i</A>,
### this function creates a matrix representation for the <A>i</A>-th
### generator of the algebra for right multiplication.
### <P/>
### <#Include Label="example-MatrixQA">
### </Description>
### </ManSection>
### <#/GAPDoc>

### - Given a base B and a Gröbner basis (record) GB, this function
###   will return a matrix representation for the i-th generator of the
###   algebra.
### #MatrixQA uses: GBNP.SplitNP MulQA MulQM#
### #MatrixQA is used in: MatricesQA MatrixQAC#
###

InstallGlobalFunction(
MatrixQA,function(i,B,GB)
local   PTS,    # boolean (true if GB is a record)
        g,      # generator i
        b,      # element of the basis of the QA (for which the row is
                # constructed)
        np,     # the product of b and the i-th generator
        row,    # np as a vector of elements of B
        M;      # the matrix constructed row by row

        g:=[[[i]],[1]];
        PTS:=IsRecord(GB);

        M:=[];

        for b in B do
                if PTS then
                        np:=MulQM(b,g,GB);
                else
                        np:=MulQA(b,g,GB);
                fi;
                row:=GBNP.SplitNP(np,B);
                Add(M,row);
        od;

        return M;
end);

##################
### MatricesQA ###
##################
### <#GAPDoc Label="MatricesQA">
### <ManSection>
### <Func Name="MatricesQA" Comm="Creates the matrix representations"
### Arg="t, B, GB" />
### <Returns>
### The matrix representation for the <A>t</A> generators of the algebra for
### right multiplication in the quotient algebra
### </Returns>
### <Description>
### Given a basis <A>B</A>  of the quotient algebra,
### a Gröbner basis (record) <A>GB</A>,
### and a natural number <A>t</A>,
### this function creates a list of <A>t</A> matrices
### representing the linear transformations of the
### generators of the algebra by right multiplication on the quotient algebra.
### <P/>
### <#Include Label="example-MatricesQA">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Given a base B and a Gröbner basis (record) GB, this function
###   will return matrix representations for all t generators of the
###   algebra.
### #MatricesQA uses: MatrixQA#
### #MatricesQA is used in:#
###

InstallGlobalFunction(
MatricesQA,function(t,B,GB)
        return List([1..t],i->MatrixQA(i,B,GB));
end);

#################
### MatrixQAC ###
#################
### <#GAPDoc Label="MatrixQAC">
### <ManSection>
### <Func Name="MatrixQAC" Comm="Creates a compressed matrix representation"
###  Arg="i, B, GB" />
### <Returns>
### The compressed matrix representation for the <A>i</A>-th generator of the
### algebra for right multiplication in the quotient algebra
### </Returns>
### <Description>
### Given a basis <A>B</A> of the quotient algebra, a Gröbner basis (record)
### <A>GB</A>, and a natural number <A>i</A>,
### this function creates a matrix representation for the <A>i</A>-th
### generator of the algebra for right multiplication in the quotient algebra.
### <P/>
### For this version to do better than <C>MatrixQA</C>,
### the field must be finite and of order at most 256.
### For more information about compression, see <Ref BookName="Reference"
### Label="Row Vectors over Finite Fields"/>.
### <P/>
### <#Include Label="example-MatrixQAC">
### </Description>
### </ManSection>
### <#/GAPDoc>

### - Given a base B and a Gröbner basis (record) GB, this function
###   will return a matrix representation for the i-th generator of the
###   algebra.
### #MatrixQAC uses: MatrixQA#
### #MatrixQAC is used in: MatricesQAC#
###

InstallGlobalFunction(
MatrixQAC,function(i,B,GB)
local   M;

        M:=MatrixQA(i,B,GB);

        ConvertToMatrixRep(M);
        return M;
end);

###################
### MatricesQAC ###
###################
### <#GAPDoc Label="MatricesQAC">
### <ManSection>
### <Func Name="MatricesQAC" Comm="Creates the compressed matrix
### representations" Arg="t, B, GB" />
### <Returns>
### The compressed matrix representation for the <A>t</A> generators of the
### algebra for right multiplication in the quotient algebra
### </Returns>
### <Description>
### Given a basis <A>B</A> of the quotient algebra , a Gröbner basis (record)
### <A>GB</A>, and a natural number <A>t</A>,
### this function creates compressed matrix representations for all <A>t</A>
### generators of the algebra for right multiplication in the quotient algebra.
### <P/>
### For this version to do better than MatrixQA,
### the field must be finite and of order at most 256.
### For more information about compression, see <Ref BookName="Reference"
### Label="Row Vectors over Finite Fields"/>.
### <P/>
### <#Include Label="example-MatricesQAC">
### </Description>
### </ManSection>
### <#/GAPDoc>
### - Given a base B and a Gröbner basis (record) GB, this function
###   will return matrix representations for all t generators of the
###   algebra.
### #MatricesQAC uses: MatrixQAC#
### #MatricesQAC is used in:#
###

InstallGlobalFunction(
MatricesQAC,function(t,B,GB)
        return List([1..t],i->MatrixQAC(i,B,GB));
end);
