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


# this file enables options
# WARNING the option records are not copied (not with set and not with get)

### GBNP.GetOptions:=function()
### GBNP.GetOption:=function(name)
### GBNP.SetOptions:=function(options)
### GBNP.SetOption:=function(name,value)
### GBNP.ClearOptions:=function(arg)
### GBNP.ClearOption:=function(name)
### GBNP.ConfigPrint:=function(arg)
### GBNP.CalculatePG:=function(L)

GBNP.OptionsRec:=rec(pg:=0);

#######################
### GBNP.GetOptions ###
#######################
###
### Get all options
###
### Arguments: none
###
### #GBNP.GetOptions uses:#
### #GBNP.GetOptions is used in: GBNP.AllObs GBNP.CreateOccurTreePTSLR GBNP.GP2NPM GBNP.NondivMonsPTSenum GBNP.PrintTraceTerm GBNP.ReduceCancellation GBNP.ReduceCancellationTrace GBNP.ReducePol2 GBNP.SGrobnerLoops GBNP.TransLetter PrintNP SGrobnerModule#
###

GBNP.GetOptions:=function()
        return GBNP.OptionsRec;
end;

######################
### GBNP.GetOption ###
######################
###
### Get one option (slow, faster is GBNP.GetOptions().name)
###
### Arguments:
### - name              the name of the option asked for (string)
###
### #GBNP.GetOption uses:#
### #GBNP.GetOption is used in:#
###

GBNP.GetOption:=function(name)
        if IsBound(GBNP.OptionsRec.(name)) then
                return GBNP.OptionsRec.(name);
        fi;
        return fail;
end;

#######################
### GBNP.SetOptions ###
#######################
###
### Function to set all options
###
### Arguments:
### - options           the new set of options
###
### #GBNP.SetOptions uses:#
### #GBNP.SetOptions is used in:#
###

GBNP.SetOptions:=function(options)
        GBNP.OptionsRec:=options;
end;

######################
### GBNP.SetOption ###
######################
###
### Function to set one option (slow, faster is GBNP.GetOptions().name:=value)
###
### Arguments:
### - name              the name of the option to change (string)
### - value             the new value
###
### #GBNP.SetOption uses:#
### #GBNP.SetOption is used in: GBNP.ConfigPrint GBNP.GP2NPM GBNP.SGrobnerLoops SGrobnerModule#
###

GBNP.SetOption:=function(name,value)
        GBNP.OptionsRec.(name):=value;
end;

#########################
### GBNP.ClearOptions ###
#########################
###
### function to clear all options
###
### Arguments: none
###
### #GBNP.ClearOptions uses:#
### #GBNP.ClearOptions is used in:#
###

GBNP.ClearOptions:=function(arg)
        GBNP.OptionsRec:=rec(pg:=0);
end;

########################
### GBNP.ClearOption ###
########################
###
### function to clear one option
###
### Arguments:
### - name               name of option to clear (string)
###
### #GBNP.ClearOption uses:#
### #GBNP.ClearOption is used in:#
###

GBNP.ClearOption:=function(name)
        Unbind(GBNP.OptionsRec.(name));
end;

########################
### GBNP.ConfigPrint ###
########################
### XXX integer -> discarded
### <#GAPDoc Label="GBNP.ConfigPrint">
### <ManSection>
### <Func Name="GBNP.ConfigPrint" Comm="Set GBNP print options" Arg="arg" />
### <Description>
### By default the generators of the algebra are printed as <C>a</C>, ...,
### <C>l</C> and everything after the twelfth generator as <C>x</C>.
### By calling <C>ConfigPrint</C> it is possible to
### alter this printing convention.
### The argument(s) will be an algebra or arguments used for naming algebras in
### GAP upon creation. More specifically, we have the following choices.
### <List>
### <Mark><Emph>no arguments</Emph></Mark><Item>When the function is invoked
### without arguments the printing is reset to the default (see above).</Item>
### <Mark>algebra</Mark><Item>When the function is invoked with an algebra as
### argument, generators will be printed as they would be in the
### algebra.</Item>
### <Mark>algebra,integer</Mark><Item>When the function is invoked with an
### algebra and an integer <A>n</A> as arguments, generators will be printed as
### they would be in the algebra and separated over the <A>n</A> dimensions.</Item>
### <Mark>leftmodule</Mark><Item>When the function is invoked with an
### leftmodule <M>A^n</M> of an associative algebra as argument, generators
### will be printed as they would be in the algebra, separated over the
### <A>n</A> dimensions.</Item>
### <Mark>string</Mark><Item>When the function is invoked with a string as its
### argument, it is assumed that there is only 1 generator and that this should
### be named as indicated by the string.</Item>
### <Mark>integer</Mark><Item>When the function is invoked with an integer
### as its argument, the <A>n</A>-th generator will be printed as
### <C>x.&lt;n&gt;</C>.</Item>
### <Mark>integer, string</Mark><Item>When the function is invoked with a
### non-negative integer and a string as its arguments,
### generators will be printed as
### <C>&lt;s&gt;.&lt;n&gt;</C>, where <C>&lt;s&gt;</C> is the string given as
### argument and <C>&lt;n&gt;</C> the number of the generator. There is no
### checking whether the number given as argument is really the dimension. So
### it is possible that higher numbers return in the output. This way of input
### is useful however, because it is a distinction
### from the one-dimensional case
### and compatible with the way a free algebra is created.</Item>
### <Mark>string, string, ..., string</Mark><Item>When the function is invoked
### with a sequence of strings, then
### generators will be printed with the corresponding
### string or <C>x</C> if the sequence is not long enough.</Item>
### </List>
### <P/>
### <#Include Label="example-ConfigPrint">
### </Description>
### </ManSection>
### <#/GAPDoc>
###
### #GBNP.ConfigPrint uses: GBNP.SetOption#
### #GBNP.ConfigPrint is used in:#
###

GBNP.ConfigPrint:=function(arg)
local   larg,   # length of arg
        names,  # names of the generators
        ln,     # length of names
        A;

        larg:=Length(arg);
        if larg=0 then
                # no arguments, use default
                GBNP.ClearOption("PrintLetterFunction");
                GBNP.ClearOption("PrintModuleDimension");
                return;
        elif larg=1 then
                if IsAlgebra(arg[1]) and IsAssociative(arg[1]) then
                        names:=ShallowCopy(ElementsFamily(
                                        FamilyObj(arg[1]))!.names);
                                # is this the right function - jwk
                elif IsString(arg[1]) then
                        GBNP.SetOption("PrintLetterFunction",x->arg[1]);
                        return ;
                elif IsInt(arg[1]) then
                        GBNP.SetOption("PrintLetterFunction",
                                x->Concatenation("x.",String(x)));
                        return ;
                elif IsLeftModule(arg[1]) then
                        A:=LeftActingDomain(arg[1]);

                        # should be a module of an associative algebra
                        if not (IsAlgebra(A) and IsAssociative(A)) then
                                return fail;
                        fi;

                        names:=ShallowCopy(ElementsFamily(
                                        FamilyObj(A))!.names);

                        GBNP.SetOption("PrintModuleDimension",DimensionOfVectors(arg[1]));
                fi;
        elif larg=2 then
                if IsInt(arg[1]) then # dimension doesn't really matter
                        GBNP.SetOption("PrintLetterFunction",
                                x->Concatenation(arg[2],".",String(x)));
                        return ;
                elif IsAlgebra(arg[1]) and IsAssociative(arg[1]) and
                                IsInt(arg[2]) then
                        names:=ShallowCopy(ElementsFamily(
                                        FamilyObj(arg[1]))!.names);

                        GBNP.SetOption("PrintModuleDimension",arg[2]);

                else # should be all strings
                        names:=ShallowCopy(arg);
                fi;
        else
                names:=ShallowCopy(arg);
        fi;

        ln:=Length(names);
        GBNP.SetOption("PrintLetterFunction",function(x)
                                if x<=ln then
                                        return names[x];
                                else
                                        return "x";
                                fi;
                        end);
end;

########################
### GBNP.CalculatePG ###
########################
###
### checks for the number of prefix generators (that is the number of the
### lowest generator, multiplied with -1 to make it positive)
###
### NOTE: this procedure assumes that L does contain 0 ( [[],[]] )
###
### Arguments:
### - L         list of polynomials
###
### #GBNP.CalculatePG uses:#
### #GBNP.CalculatePG is used in: GBNP.IsGrobnerBasisTest Grobner IsGrobnerPair MakeGrobnerPair SGrobner SGrobnerModule#
###

GBNP.CalculatePG:=function(L)
local F;
        F:=Filtered(L, x->IsBound(x[1][1][1]) and x[1][1][1]<0);
        if Length(F)=0 then
                return 0;
        else
                return -Minimum(List(F,x->x[1][1][1]));
        fi;
end;

###########################
### GBNP.CalculatePGlts ###
###########################
###
### checks for the number of prefix generators (that is the number of the
### lowest generator, multiplied with -1 to make it positive)
###
### Arguments:
### - L         list of leading terms
###
### #GBNP.CalculatePG uses:#
### #GBNP.CalculatePG is used in: GBNP.IsGrobnerBasisTest Grobner IsGrobnerPair MakeGrobnerPair SGrobner SGrobnerModule#
###

GBNP.CalculatePGlts:=function(L)
local F;
        F:=Filtered(L, x->IsBound(x[1]) and x[1]<0);
        if Length(F)=0 then
                return 0;
        else
                return -Minimum(List(F,x->x[1]));
        fi;
end;

GBNP.cleancount:=0;
