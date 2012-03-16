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
# http://www.gnu.org/licenses/lgpl.html
########################## END COPYRIGHT MESSAGE ##########################

# the path to the package documentation directory. Usually this is the GAPDIR +
# pkg/GBNP/doc
path := Directory( "doc/" ) ;;
# the main documentation file (in the path)
main := "gbnp_doc.xml";;
# Now construct the names for all the sourcefiles, relative to the path
# the sourcefiles can be found in the lib dir.
gbnpsourcedir := "../lib";;
sources := [ "grobner.gi", "printing.gi", "npformat.gi", "fincheck.gi", 
	"nparith.gi", "graphs.gi", "trunc.gi", "trace.gi", "options.gi"
	];;
Apply(sources, x->JoinStringsWithSeparator([gbnpsourcedir,x],"/"));
# Now construct the names of all the examplefiles, relative to the path.
# The examples can be found in the doc/examples dir.
examples := [ "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11",
	"12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23",
	"24", "25", "26"];;
exampledir := "examples";;
Apply(examples, x->Concatenation(exampledir,"/example",x,".xml"));
Add(examples, Concatenation(exampledir,"/","functions.xml"));
# The files that are to be included are  
files := Concatenation(sources,examples);;
Append(files, [ "timing.xml" ]);
# the name of the book
bookname := "gbnp_book";;
# the next three commands aren't useful, except for checking the xml integrity.
str := ComposedXMLString(path,main,files);;
r := ParseTreeXMLString(str);;
CheckAndCleanGapDocTree(r);
# Make all the files.
#Print("path: "); Print(path); Print("\n");Print("\n");
#Print("main: "); Print(main); Print("\n");Print("\n");
#Print("files: "); Print(files); Print("\n");Print("\n");
#Print("bookname: "); Print(bookname); Print("\n");Print("\n");
MakeGAPDocDoc(path, main, files, bookname);;

# make doc for nmo part
Read("make_nmo_doc.g");
