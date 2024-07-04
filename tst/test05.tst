gap> START_TEST("GBNP test05");
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
gap> ### filename = "example05.g"
gap> ### authors Cohen & Gijsbers
gap> 
gap> ### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES
gap> 
gap> ### Last change: August 22 2001.
gap> ### amc
gap> 
gap> # <#GAPDoc Label="Example05">
gap> # <Section Label="Example05"><Heading>The gcd of some univariate polynomials</Heading>
gap> # A list of univariate polynomials is generated. The result of the
gap> # Gröbner basis computation on this list should be a single
gap> # monic polynomial, their gcd.
gap> # <P/>
gap> # First load the package and set the standard infolevel <Ref
gap> # InfoClass="InfoGBNP" Style="Text"/> to 2 and the time infolevel <Ref
gap> # Func="InfoGBNPTime" Style="Text"/> to 1
gap> # (for more information about the info
gap> # level, see Chapter <Ref Chap="Info"/>).
gap> 
gap> # <L>
gap> LoadPackage("gbnp", false);
true
gap> SetInfoLevel(InfoGBNP,2);
gap> SetInfoLevel(InfoGBNPTime,0);
gap> # </L>
gap> 
gap> # Let the single variable be printed as x by means of
gap> # <Ref Func="GBNP.ConfigPrint" Style="Text"/>
gap> # <L>
gap> GBNP.ConfigPrint("x");
gap> # </L>
gap> 
gap> # Now input the relations in NP format (see <Ref Sect="NP"/>). They will be
gap> # assigned to <C>KI</C>.
gap> 
gap> # <L>
gap> p0 := [[[1,1,1],[1,1],[1],[]],[1,2,2,1]];;
gap> p1 := [[[1,1,1,1],[1,1],[]],[1,1,1]];;
gap> KI := [p0,p1];;
gap> 
gap> for i in [2..12] do
>     h := AddNP(AddNP(KI[i],KI[i-1],1,3),
>           AddNP(BimulNP([1],KI[i],[]),KI[i-1],2,1),3,-5);
>     Add(KI,h);
> od;
gap> # </L>
gap> 
gap> # The relations can be shown with <Ref Func="PrintNPList" Style="Text"/>:
gap> 
gap> # <L>
gap> PrintNPList(KI);
 x^3 + 2x^2 + 2x + 1
 x^4 + x^2 + 1
 - 10x^5 + 3x^4 - 6x^3 + 11x^2 - 2x + 7
 100x^6 - 60x^5 + 73x^4 - 128x^3 + 57x^2 - 76x + 25
 - 1000x^7 + 900x^6 - 950x^5 + 1511x^4 - 978x^3 + 975x^2 - 486x + 103
 10000x^8 - 12000x^7 + 12600x^6 - 18200x^5 + 14605x^4 - 13196x^3 + 8013x^2 - 2\
792x + 409
 - 100000x^9 + 150000x^8 - 166000x^7 + 223400x^6 - 204450x^5 + 181819x^4 - 123\
630x^3 + 55859x^2 - 14410x + 1639
 1000000x^10 - 1800000x^9 + 2150000x^8 - 2780000x^7 + 2765100x^6 - 2504340x^5 \
+ 1840177x^4 - 982264x^3 + 343729x^2 - 70788x + 6553
 - 10000000x^11 + 21000000x^10 - 27300000x^9 + 34850000x^8 - 36655000x^7 + 342\
32300x^6 - 26732590x^5 + 16070447x^4 - 6878602x^3 + 1962503x^2 - 335534x + 262\
15
 100000000x^12 - 240000000x^11 + 340000000x^10 - 437600000x^9 + 479700000x^8 -\
 463408000x^7 + 381083200x^6 - 250919600x^5 + 124358069x^4 - 44189892x^3 + 106\
17765x^2 - 1551904x + 104857
 - 1000000000x^13 + 2700000000x^12 - 4160000000x^11 + 5480000000x^10 - 6219000\
000x^9 + 6212580000x^8 - 5347676000x^7 + 3789374800x^6 - 2103269850x^5 + 87925\
4915x^4 - 266261734x^3 + 55222347x^2 - 7046418x + 419431
 10000000000x^14 - 30000000000x^13 + 50100000000x^12 - 68240000000x^11 + 79990\
000000x^10 - 82533200000x^9 + 74033300000x^8 - 55790408000x^7 + 33925155700x^6\
 - 16106037100x^5 + 5797814361x^4 - 1527768240x^3 + 278602281x^2 - 31541180x +\
 1677721
 - 100000000000x^15 + 330000000000x^14 - 595000000000x^13 + 843500000000x^12 -\
 1021260000000x^11 + 1087222000000x^10 - 1012808600000x^9 + 804854300000x^8 - \
528013485000x^7 + 277993337300x^6 - 114709334310x^5 + 36188145143x^4 - 8434374\
466x^3 + 1372108031x^2 - 139586422x + 6710887
gap> Length(KI);
13
gap> # </L>
gap> 
gap> # The Gröbner basis can now be calculated with
gap> # <Ref Func="SGrobner" Style="Text"/>:
gap> 
gap> # <L>
gap> GB := SGrobner(KI);;
#I  number of entered polynomials is 13
#I  number of polynomials after reduction is 1
#I  End of phase I
#I  End of phase II
#I  List of todo lengths is [ 0 ]
#I  End of phase III
#I  G: Cleaning finished, 0 polynomials reduced
#I  End of phase IV
gap> # </L>
gap> 
gap> # Printed it looks like:
gap> 
gap> # <L>
gap> PrintNPList(GB);
 x^2 + x + 1
gap> # </L>
gap> 
gap> # </Section>
gap> # <#/GAPDoc>
gap> 
gap> STOP_TEST("test05.g",10000);
