# for gmake
#

include .depend

all: ${TESTS}

functions.g: ../doc/examples/functions.g
test%.g: ../doc/examples/example%.g
	grep -v '^time' ../doc/examples/example"$*".g |grep -v '^Info(InfoGBNPTime' > test"$*".g

test-bound%.g: ../doc/examples/bound-test%.g
	grep -v '^time' ../doc/examples/bound-test"$*".g |grep -v '^Info(InfoGBNPTime' > test-bound"$*".g

test-functions.g: ../doc/examples/functions.g
	grep -v '^time' ../doc/examples/functions.g |grep -v '^Info(InfoGBNPTime' > test-functions.g

%.test: %.txt
	../scripts/testscript "$*"
%.txt: %.g
	../scripts/gapscript "$*"
%.xml: %.txt txt2xml.sed
	sed -f txt2xml.sed "$<" > "$@"
%.chk: %.test
	../scripts/chkscript "$*"

svn: 	${TESTS}
	svn diff --diff-cmd `which diff` -x --ignore-matching-lines='^#I.*' *.test
