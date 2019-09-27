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

LoadPackage("gbnp");

RT:=function(name)
  	Test(name);
	# reset printing
	GBNP.ConfigPrint();

	# reset Info levels
	SetInfoLevel(InfoGBNP,0);
	SetInfoLevel(InfoGBNPTime,0);

	# reset options
	GBNP.ClearOptions();
end;

RT("test/test-bound-01.tst");
RT("test/test-bound-02.tst");
RT("test/test-bound-03.tst");
RT("test/test-bound-04.tst");
RT("test/test-bound-05.tst");
RT("test/test-bound-06.tst");
RT("test/test-bound-07.tst");
RT("test/test-bound-08.tst");
RT("test/test-bound-09.tst");

RT("test/test-functions.tst");

# normal examples disabled
RT("test/test01.tst");
RT("test/test02.tst");
RT("test/test03.tst");
RT("test/test04.tst");
RT("test/test05.tst");
RT("test/test06.tst");
RT("test/test07.tst");
RT("test/test08.tst");
RT("test/test09.tst");
RT("test/test10.tst");
RT("test/test11.tst");
RT("test/test12.tst");
RT("test/test13.tst");
RT("test/test14.tst");
RT("test/test15.tst");
RT("test/test16.tst");
RT("test/test17.tst");
RT("test/test18.tst");
RT("test/test19.tst");
RT("test/test20.tst");
RT("test/test21.tst");
RT("test/test22.tst");
RT("test/test23.tst");
RT("test/test24.tst");
RT("test/test25.tst");
RT("test/test26.tst");
