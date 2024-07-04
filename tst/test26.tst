gap> START_TEST("GBNP test26");
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
gap> ### filename = "exampleColagen.g"
gap> ### authors Cohen & Gijsbers
gap> 
gap> ### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES
gap> 
gap> # <#GAPDoc Label="ExampleColagen">
gap> # <Section Label="ExampleColagen"><Heading>The cola gene puzzle</Heading>
gap> # <P/>
gap> # A prize question appearing in the January 2005 issue of
gap> # the Dutch journal "Natuur en Techniek" asked for a DNA change
gap> # of cows so that they could produce Cola instead of milk.
gap> # A team of genetic manipulators
gap> # has tools to perform the following
gap> # five DNA string operations. (Here the strings before and
gap> # after the equality sign can be interchanged at will.)
gap> # <P/>
gap> # operation 1: TCAT = T;
gap> # <P/>
gap> # operation 2: GAG =  AG;
gap> # <P/>
gap> # operation 3: CTC =  TC;
gap> # <P/>
gap> # operation 4: AGTA =  A;
gap> # <P/>
gap> # operation 5: TAT =  CT.
gap> # <P/>
gap> # The first question is to show how they can transform the
gap> # milk gene TAGCTAGCTAGCT to the
gap> # cola gene CTGACTGACT.
gap> # <P/>
gap> # A second question is to show that mad cow disease related
gap> # retro virus CTGCTACTGACT can be avoided at all times.
gap> # Can this be guaranteed?
gap> # <P/>
gap> # We answer these questions using the trace functions of the
gap> # Gröbner basis package GBNP in Section <Ref Sect="tracefun"/>.
gap> # <P/>
gap> # First load the package and set the standard infolevel <Ref
gap> # InfoClass="InfoGBNP" Style="Text"/> to 0 and the time infolevel <Ref
gap> # Func="InfoGBNPTime" Style="Text"/> to 0 to minimize the printing of
gap> # data regarding the computation (for more information about the info
gap> # level, see Chapter <Ref Chap="Info"/>).
gap> 
gap> # <L>
gap> LoadPackage("gbnp", false);
true
gap> SetInfoLevel(InfoGBNP,0);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> # </L>
gap> 
gap> 
gap> # We introduce the free algebra <C>ALG</C>
gap> # on the generators corresponding to the four letters in the DNA code
gap> # and express the milk gene and cola gene as monomials in this algebra.
gap> 
gap> # <L>
gap> ALG:=FreeAssociativeAlgebraWithOne(Rationals, "A", "C", "G", "T");;
gap> g:=GeneratorsOfAlgebra(ALG);;
gap> A:=g[2];;
gap> C:=g[3];;
gap> G:=g[4];;
gap> T:=g[5];;
gap> 
gap> milk := T*A*G*C*T*A*G*C*T*A*G*C*T;;
gap> cola := C*T*G*A*C*T*G*A*C*T;;
gap> # </L>
gap> 
gap> 
gap> # We next enter the set  <M>K</M> of binomials <M>x-y</M>
gap> # corresponding to the five operations <M>x = y</M> listed above.
gap> # We enter the binomials as members of <C>ALG</C> and
gap> # let <C>KNP</C> be the corresponding set of NP polynomials.
gap> 
gap> # <L>
gap> rule1 := T*C*A*T - T;;
gap> rule2 :=  G*A*G -  A*G;;
gap> rule3 :=  C*T*C - T*C;;
gap> rule4 := A*G*T*A - A;;
gap> rule5 := T*A*T -  C*T;;
gap> K := [rule1,rule2,rule3,rule4,rule5];;
gap> KNP := List(K,x-> GP2NP(x));;
gap> # </L>
gap> 
gap> # We stipulate how the variables will be printed and print <C>KNP</C>.
gap> # See  <Ref Func="PrintNPList" Style="Text"/>.
gap> 
gap> # <L>
gap> GBNP.ConfigPrint("A","C","G","T");
gap> PrintNPList(KNP);
 TCAT - T
 GAG - AG
 CTC - TC
 AGTA - A
 TAT - CT
gap> # </L>
gap> 
gap> 
gap> # Now calculate the usual Gröbner basis with <Ref Func="SGrobner"
gap> # Style="Text"/>.
gap> 
gap> # <L>
gap> GB := SGrobner(KNP);;
gap> # </L>
gap> 
gap> 
gap> # Compare milk and cola after taking their strong normal forms
gap> # with respect to <C>GB</C>
gap> # using
gap> # <Ref Func="StrongNormalFormNP" Style="Text"/>.
gap> # We observe that they have the same normal form and so there is
gap> # a way to transform the milk gene into the cola gene.
gap> 
gap> # <L>
gap> milkNP := GP2NP(milk);;
gap> colaNP := GP2NP(cola);;
gap> milkRed := NP2GP(StrongNormalFormNP(milkNP,GB),ALG);
(1)*T
gap> colaRed := NP2GP(StrongNormalFormNP(colaNP,GB),ALG);
(1)*T
gap> # </L>
gap> 
gap> # But this information does not yet show us how to perform the transformation.
gap> # To this end we calculate the Gröbner basis with trace information,
gap> # using the function
gap> # <Ref Func="SGrobnerTrace" Style="Text"/>.
gap> 
gap> # <L>
gap> GTrace := SGrobnerTrace(KNP);;
gap> # </L>
gap> 
gap> # The full trace can be printed with <Ref Func="PrintTraceList" Style="Text"/>,
gap> # but we only print the relations (and no trace) by invoking <Ref
gap> # Func="PrintNPListTrace" Style="Text"/>.
gap> 
gap> # <L>
gap> PrintNPListTrace(GTrace);
 CT - T
 GA - A
 AGT - AT
 ATA - A
 TAT - T
 TCA - TA
gap> # </L>
gap> 
gap> 
gap> # In order to display a proof that <M>milk-cola</M>
gap> # belongs to the ideal
gap> # we use <Ref Func="StrongNormalFormTraceDiff" Style="Text"/>,
gap> # The result is a record, <C>p</C> say, containing
gap> # <C>milk-cola</C> in the field <C>p.pol</C>
gap> # (the normal form will be subtracted from the argument <C>milk-cola</C>
gap> # to obtain <C>p.pol</C>, but the normal form is zero
gap> # because the argument belongs to the ideal generated by <C>K</C>).
gap> # The other field of the record <C>p</C> is
gap> # <C>p.trace</C>, the traced polynomial, which is best displayed
gap> # by use of <Ref Func="PrintTracePol" Style="Text"/>.
gap> 
gap> # <L>
gap> p := StrongNormalFormTraceDiff(CleanNP(GP2NP(milk-cola)),GTrace);;
gap> NP2GP(p.pol,ALG);
(1)*(T*A*G*C)^3*T+(-1)*(C*T*G*A)^2*C*T
gap> PrintTracePol(p);
- TGATGAG(1) + TAGG(1)ATAT - TATATAGG(1) - TGAG(1)GACT + TGATGACG(1) - G(
1)GACTGACT - TAGCG(1)ATAT - TATAGG(1)AGT + TATATAGCG(1) + TGACG(1)GACT + CG(
1)GACTGACT - TAGG(1)AGTAGT + TAGTAGTAGG(1) + TATAGCG(1)AGT + TAGCG(
1)AGTAGT + TAGTAGG(1)AGCT - TAGTAGTAGCG(1) + TAGG(1)AGCTAGCT - TAGTAGCG(
1)AGCT - TAGCG(1)AGCTAGCT - TATG(2)TAT - TG(2)TATGAT - TGATGAG(3)AT + TAGG(
3)ATATAT - TATATAGG(3)AT - TGAG(3)ATGACT - G(3)ATGACTGACT - TATAGG(
3)ATAGT - TAGG(3)ATAGTAGT + TAGTAGTAGG(3)AT + TAGTAGG(3)ATAGCT + TAGG(
3)ATAGCTAGCT - TATG(4)T + TG(4)TAT + TATGG(4)T - TG(4)TGAT + TATATG(4)T + TGG(
4)TGAT - TG(4)TATAT + TATG(4)TAGT + TG(4)TAGTAGT + TAGG(5)ATAT - TATATAGG(
5) - TATAGG(5)AGT - TAGG(5)AGTAGT
gap> # </L>
gap> 
gap> # In order to give a precise answer to the first question
gap> # we need to work a little on <C>p.trace</C>. To do so, we
gap> # introduce the following function, which creates the NP polynomial
gap> # corresponding
gap> # to the <C>i</C>-th term in the expression <C>p.trace</C>
gap> # of <C>p.pol</C> as a linear combination of members of <C>KNP</C>.
gap> # It is used to obtain the list <C>EvalList</C> of polynomials
gap> # for all <C>i</C>.
gap> 
gap> # <L>
gap> EvalTracePol := function(i,p,KNP)
>   local x,pi;
>   pi := p.trace[i];
>   x := BimulNP(pi[1],KNP[pi[2]],pi[3]);
>   return  [x[1],pi[4]*x[2]];
> end;;
gap> 
gap> lev :=  Length(p.trace);;
gap> EvalList := List([1..lev], y -> CleanNP(EvalTracePol(y,p,KNP)));;
gap> # </L>
gap> 
gap> # In order to find the rewrite from the milk gene to the cola gene
gap> # as required for an answer to the first question,
gap> # we match leading terms recursively.
gap> 
gap> # <L>
gap> UnusedIndices := Set([1..lev]);;
gap> RunningTerm :=  milkNP[1][1];;
gap> stepno := 0;;
gap> NP2GP(milkNP,ALG);
(1)*(T*A*G*C)^3*T
gap> while Length(UnusedIndices) > 0 do
>   i := 0;
>   notfnd := true;
>   while i < lev and notfnd do
>     i := i+1;
>     if EvalList[i][1][1] = RunningTerm and i in UnusedIndices then
>        notfnd := false;
>        RemoveSet(UnusedIndices, i);
>        RunningTerm :=  EvalList[i][1][2];
>        stepno := stepno+1;
>     elif EvalList[i][1][2] = RunningTerm and i in UnusedIndices then
>        notfnd := false;
>        RemoveSet(UnusedIndices, i);
>        RunningTerm :=  EvalList[i][1][1];
>        stepno := stepno+1;
>     fi;
>   od;
>   if i = lev and notfnd = true then Print("error not fnd in"); fi;
>   Print(" -(",stepno,")- ");
>   PrintNP([[p.trace[i][1]],[1]]);
>   Print("         K[",p.trace[i][2],"]\n        ");
>   PrintNP([[p.trace[i][3]],[1]]);
>   Print(" --> ");
>   PrintNP([[EvalList[i][1][2]],[1]]);
> od;;
 -(1)-  TAGC
         K[1]
         AGCTAGCT
 -->  TAGCTAGCTAGCT
 -(2)-  TAG
         K[3]
         ATAGCTAGCT
 -->  TAGTCATAGCTAGCT
 -(3)-  TAG
         K[1]
         AGCTAGCT
 -->  TAGTAGCTAGCT
 -(4)-  TAGTAGC
         K[1]
         AGCT
 -->  TAGTAGCTAGCT
 -(5)-  TAGTAG
         K[3]
         ATAGCT
 -->  TAGTAGTCATAGCT
 -(6)-  TAGTAG
         K[1]
         AGCT
 -->  TAGTAGTAGCT
 -(7)-  TAGTAGTAGC
         K[1]
         1
 -->  TAGTAGTAGCT
 -(8)-  TAGTAGTAG
         K[3]
         AT
 -->  TAGTAGTAGTCAT
 -(9)-  TAGTAGTAG
         K[1]
         1
 -->  TAGTAGTAGT
 -(10)-  TAG
         K[1]
         AGTAGT
 -->  TAGTAGTAGT
 -(11)-  TAG
         K[3]
         ATAGTAGT
 -->  TAGTCATAGTAGT
 -(12)-  TAGC
         K[1]
         AGTAGT
 -->  TAGCTAGTAGT
 -(13)-  TAG
         K[5]
         AGTAGT
 -->  TAGCTAGTAGT
 -(14)-  T
         K[4]
         TAGTAGT
 -->  TATAGTAGT
 -(15)-  TATAG
         K[1]
         AGT
 -->  TATAGTAGT
 -(16)-  TATAG
         K[3]
         ATAGT
 -->  TATAGTCATAGT
 -(17)-  TATAGC
         K[1]
         AGT
 -->  TATAGCTAGT
 -(18)-  TATAG
         K[5]
         AGT
 -->  TATAGCTAGT
 -(19)-  TAT
         K[4]
         TAGT
 -->  TATATAGT
 -(20)-  TATATAG
         K[1]
         1
 -->  TATATAGT
 -(21)-  TATATAG
         K[3]
         AT
 -->  TATATAGTCAT
 -(22)-  TATATAGC
         K[1]
         1
 -->  TATATAGCT
 -(23)-  TATATAG
         K[5]
         1
 -->  TATATAGCT
 -(24)-  TATAT
         K[4]
         T
 -->  TATATAT
 -(25)-  T
         K[4]
         TATAT
 -->  TATATAT
 -(26)-  TAG
         K[5]
         ATAT
 -->  TAGCTATAT
 -(27)-  TAGC
         K[1]
         ATAT
 -->  TAGCTATAT
 -(28)-  TAG
         K[3]
         ATATAT
 -->  TAGTCATATAT
 -(29)-  TAG
         K[1]
         ATAT
 -->  TAGTATAT
 -(30)-  T
         K[4]
         TAT
 -->  TATAT
 -(31)-  TAT
         K[4]
         T
 -->  TATAT
 -(32)-  TAT
         K[2]
         TAT
 -->  TATAGTAT
 -(33)-  TATG
         K[4]
         T
 -->  TATGAT
 -(34)-  T
         K[4]
         TGAT
 -->  TATGAT
 -(35)-  T
         K[2]
         TATGAT
 -->  TAGTATGAT
 -(36)-  TG
         K[4]
         TGAT
 -->  TGATGAT
 -(37)-  TGATGA
         K[1]
         1
 -->  TGATGAT
 -(38)-  TGATGA
         K[3]
         AT
 -->  TGATGATCAT
 -(39)-  TGATGAC
         K[1]
         1
 -->  TGATGACT
 -(40)-  TGA
         K[1]
         GACT
 -->  TGATGACT
 -(41)-  TGA
         K[3]
         ATGACT
 -->  TGATCATGACT
 -(42)-  TGAC
         K[1]
         GACT
 -->  TGACTGACT
 -(43)-  1
         K[1]
         GACTGACT
 -->  TGACTGACT
 -(44)-  1
         K[3]
         ATGACTGACT
 -->  TCATGACTGACT
 -(45)-  C
         K[1]
         GACTGACT
 -->  CTGACTGACT
gap> NP2GP(colaNP,ALG);
(1)*(C*T*G*A)^2*C*T
gap> # </L>
gap> 
gap> 
gap> # And now the second question regarding the retro virus.
gap> 
gap> # <L>
gap> retro := C*T*G*C*T*A*C*T*G*A*C*T;;
gap> # </L>
gap> 
gap> 
gap> # We compute the Strong Normal Form
gap> # <Ref Func="StrongNormalFormNP" Style="Text"/>
gap> # of <C>retro</C> with respect to <C>GB</C>.
gap> # As it is <C>TGT</C>, distinct to <C>T</C>, the strong normal form of milk,
gap> # there is no transformation from milk to retro.
gap> # <L>
gap> NP2GP(StrongNormalFormNP(CleanNP(GP2NP(retro)),GB), ALG);
(1)*T*G*T
gap> # </L>
gap> 
gap> 
gap> # Of course, here too we can verify the reduction,
gap> # by computing <Ref Func="StrongNormalFormTraceDiff" Style="Text"/>
gap> # with input the NP polynomial corresponding to <C>retro</C>
gap> # and with respect to <C>K</C>;
gap> # it is called <C>retroTrace</C>.
gap> # The symbol <C>G</C> in expression like <C>G(2)</C>
gap> # are not to be confused with the single symbols <C>G</C>
gap> # representing the DNA element.
gap> 
gap> # <L>
gap> retroTrace := StrongNormalFormTraceDiff(CleanNP(GP2NP(retro)),GTrace);;
gap> PrintTracePol(retroTrace);
 TGG(1) - TGC^2G(1) - TGTAG(1) + TGTACG(1) + TGTAGG(1)AT + TGTATGAG(
1) + TGTAG(1)GACT - TGTAGCG(1)AT - TGTATGACG(1) + TGG(1)ACTGACT - TGTACG(
1)GACT + G(1)GCTACTGACT - TGCG(1)ACTGACT - CG(1)GCTACTGACT + TGTATG(
2)TAT + TGG(3)AT + TGCG(3)AT - TGTAG(3)AT + TGTAGG(3)ATAT + TGTATGAG(
3)AT + TGTAG(3)ATGACT + TGG(3)ATACTGACT + G(3)ATGCTACTGACT + TGTG(
4)T + TGTATG(4)T - TGTG(4)TAT - TGTATGG(4)T + TGCG(5) + TGG(5)AT - TGTAG(
5) + TGTAGG(5)AT
gap> # </L>
gap> 
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> STOP_TEST("test26.g",10000);
