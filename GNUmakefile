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

.PHONY:doc depend tests examples archives workspace comment builddir

VERSION=1.0.3
# date as text
DATE=8 March 2016
# date as dd/mm/yyyy
DATE2=08/03/2016
URLBASE='http://mathdox.org/products/gbnp'

# set $GAP to the gap command you want to use (if not set it will try to run
# gap from the path

all: depend doc examples tests archives workspace
	
archives: GBNPdoc-${VERSION}.tar.gz GBNP-${VERSION}.tar.gz

builddir:
	mkdir -p build
	mkdir -p build/archives

clean: distclean
	rm -rf test/*test 

computerinfo: 
	scripts/maketiming > doc/timing.xml

distclean:
	rm -rf GBNPdoc-${VERSION}.tar.gz GBNP-${VERSION}.tar.gz doc/examples/*xml .depend doc/examples/.depend examples/.depend test/.depend .depend make_doc.txt build www

doc: depend computerinfo
	cd doc/examples && ${MAKE} allxml
	cd ../..
	scripts/gapscript make_doc
	rm -f make_doc.txt

GBNPdoc-${VERSION}.tar.gz: doc builddir
	tar -cvzf build/archives/GBNPdoc-${VERSION}.tar.gz --exclude '*CVS*' --exclude '*.svn*' --exclude '.depend' doc

GBNP-${VERSION}.tar.gz: doc tests builddir
	tar -cvzf build/archives/GBNP-${VERSION}.tar.gz -C .. --exclude 'build/archives' --exclude '*.svn*' --exclude '*CVS*' --exclude 'build' --exclude 'www' --exclude '.depend' gbnp

depend: workspace
	scripts/makedepend
	cp .depend examples
	cp .depend test
	cp .depend doc/examples
	sed -e 's/$$VERSION/${VERSION}/g' -e 's,$$URLBASE,${URLBASE},g' -e 's,$$DATE2,${DATE2},g' -e 's,$$DATE,${DATE},g' version/PackageInfo.g >PackageInfo.g
	sed -e 's/$$VERSION/${VERSION}/g' -e 's,$$URLBASE,${URLBASE},g' -e 's,$$DATE2,${DATE2},g' -e 's,$$DATE,${DATE},g' version/README.in >README
	sed -e 's/$$VERSION/${VERSION}/g' -e 's,$$URLBASE,${URLBASE},g' -e 's,$$DATE2,${DATE2},g' -e 's,$$DATE,${DATE},g' doc/gbnp_doc.xml.in >doc/gbnp_doc.xml

.depend: depend

examples: 
	cd examples && ${MAKE} all && cd ..

tests: depend 
	cd test && ${MAKE} all && cd ..

workspace: build/gbnp.wks.gz

www: doc archives
	mkdir -p www www/nmo
	cp build/archives/GBNPdoc-${VERSION}.tar.gz build/archives/GBNP-${VERSION}.tar.gz www/
	cp doc/chap* www/
	cp doc/manual* www/
	cp doc/nmo/chap* www/nmo/
	cp doc/nmo/manual* www/nmo/
	cp doc/articles/* www/
	cp PackageInfo.g README www/
	cd www && ln -fs chap0.html index.html && cd -

build/gbnp.wks.gz: 
	scripts/workspace

build/COPYRIGHTcmt: COPYRIGHT scripts/copyrightcomment builddir
	scripts/copyrightcomment <COPYRIGHT >build/COPYRIGHTcmt

build/changecomment.vim: scripts/changecomment.vim.sh build/COPYRIGHTcmt
	scripts/changecomment.vim.sh >build/changecomment.vim

comment: build/COPYRIGHTcmt build/changecomment.vim

lib/gbnp-all.g: lib/*.g[di]
	cat lib/*.g[di] >lib/gbnp-all.g
