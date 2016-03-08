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
  	ReadTest(name);
	# reset printing
	GBNP.ConfigPrint();

	# reset Info levels
	SetInfoLevel(InfoGBNP,0);
	SetInfoLevel(InfoGBNPTime,0);

	# reset options
	GBNP.ClearOptions();
end;

RT("test/test-bound-01.test");
RT("test/test-bound-02.test");
RT("test/test-bound-03.test");
RT("test/test-bound-04.test");
RT("test/test-bound-05.test");
RT("test/test-bound-06.test");
RT("test/test-bound-07.test");
RT("test/test-bound-08.test");
RT("test/test-bound-09.test");

RT("test/test-functions.test");

# normal examples disabled
RT("test/test01.test");
RT("test/test02.test");
RT("test/test03.test");
RT("test/test04.test");
RT("test/test05.test");
RT("test/test06.test");
RT("test/test07.test");
RT("test/test08.test");
RT("test/test09.test");
RT("test/test10.test");
RT("test/test11.test");
RT("test/test12.test");
RT("test/test13.test");
RT("test/test14.test");
RT("test/test15.test");
RT("test/test16.test");
RT("test/test17.test");
RT("test/test18.test");
RT("test/test19.test");
RT("test/test20.test");
RT("test/test21.test");
RT("test/test22.test");
RT("test/test23.test");
RT("test/test24.test");
RT("test/test25.test");
RT("test/test26.test");
