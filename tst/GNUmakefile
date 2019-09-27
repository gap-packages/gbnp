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

%.tst: %.txt
	../scripts/testscript "$*"
%.txt: %.g
	../scripts/gapscript "$*"
%.xml: %.txt txt2xml.sed
	sed -f txt2xml.sed "$<" > "$@"
