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

### init file for GBNP, reads all the .gd files

ReadPackage("GBNP", "lib/fincheck.gd");
ReadPackage("GBNP", "lib/graphs.gd");
ReadPackage("GBNP", "lib/grobner.gd");
ReadPackage("GBNP", "lib/nparith.gd");
ReadPackage("GBNP", "lib/npformat.gd");
ReadPackage("GBNP", "lib/printing.gd");
ReadPackage("GBNP", "lib/trace.gd");
ReadPackage("GBNP", "lib/trunc.gd");

ReadPackage("GBNP", "lib/kary-heap.gd");
DeclareInfoClass("InfoGBNP");
DeclareInfoClass("InfoGBNPTime");

# nmo files

ReadPackage("GBNP", "lib/nmo/ncalgebra.gd");
ReadPackage("GBNP", "lib/nmo/ncordmachine.gd");
ReadPackage("GBNP", "lib/nmo/ncorderings.gd");
ReadPackage("GBNP", "lib/nmo/ncinterface.gd");
ReadPackage("GBNP", "lib/nmo/ncutils.gd");
