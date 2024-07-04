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

### read.g file for GBNP, reads all the .gi files
### made by Jan Willem Knopper on 13 august 2003
### part of GBNP package since version 0.9

BindGlobal("GBNP",rec());

ReadPackage("GBNP", "lib/nparith.gi");
ReadPackage("GBNP", "lib/npformat.gi");
ReadPackage("GBNP", "lib/printing.gi");
ReadPackage("GBNP", "lib/grobner.gi");
ReadPackage("GBNP", "lib/tree.gi");
ReadPackage("GBNP", "lib/graphs.gi");
ReadPackage("GBNP", "lib/trace.gi");
ReadPackage("GBNP", "lib/trunc.gi");
ReadPackage("GBNP", "lib/fincheck.gi");

ReadPackage("GBNP", "lib/occurtree.gi");
ReadPackage("GBNP", "lib/grobnerloops.gi");
ReadPackage("GBNP", "lib/options.gi");

ReadPackage("GBNP", "lib/kary-heap.gi");

# nmo files
ReadPackage("GBNP", "lib/nmo/ncutils.gi");
ReadPackage("GBNP", "lib/nmo/ncordmachine.gi");
ReadPackage("GBNP", "lib/nmo/ncorderings.gi");
ReadPackage("GBNP", "lib/nmo/ncinterface.gi");
