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

.PHONY:doc depend tests examples workspace comment

# set $GAP to the gap command you want to use (if not set it will try to run
# gap from the path

all: depend doc examples tests workspace

clean: distclean
	rm -rf tst/*tst

computerinfo:
	etc/maketiming > doc/timing.xml

distclean:
	rm -rf doc/examples/*xml .depend doc/examples/.depend examples/.depend tst/.depend .depend makedoc.txt build

doc: depend computerinfo
	cd doc/examples && ${MAKE} allxml
	cd ../..
	etc/gapscript makedoc
	rm -f makedoc.txt

depend: workspace
	etc/makedepend
	cp .depend examples
	cp .depend tst
	cp .depend doc/examples

.depend: depend

examples:
	cd examples && ${MAKE} all && cd ..

tests: depend
	cd tst && ${MAKE} all && cd ..

workspace: build/gbnp.wks.gz

build/gbnp.wks.gz:
	etc/workspace

build/COPYRIGHTcmt: COPYRIGHT etc/copyrightcomment
	mkdir -p build
	etc/copyrightcomment <COPYRIGHT >build/COPYRIGHTcmt

build/changecomment.vim: etc/changecomment.vim.sh build/COPYRIGHTcmt
	etc/changecomment.vim.sh >build/changecomment.vim

comment: build/COPYRIGHTcmt build/changecomment.vim

lib/gbnp-all.g: lib/*.g[di]
	cat lib/*.g[di] >lib/gbnp-all.g
