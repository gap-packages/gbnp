# for gmake
#

include .depend

all: ${TESTS}

functions.g: ../doc/examples/functions.g
test%.g: ../doc/examples/example%.g
	grep -v '^time' ../doc/examples/example"$*".g |sed 's/InfoGBNPTime,[12345]/InfoGBNPTime,0/' > test"$*".g

test-bound%.g: ../doc/examples/bound-test%.g
	grep -v '^time' ../doc/examples/bound-test"$*".g |sed 's/InfoGBNPTime,[12345]/InfoGBNPTime,0/' > test-bound"$*".g

test-functions.g: ../doc/examples/functions.g
	grep -v '^time' ../doc/examples/functions.g |sed 's/InfoGBNPTime,[12345]/InfoGBNPTime,0/' > test-functions.g

%.tst: %.txt
	../etc/testscript "$*"
%.txt: %.g
	../etc/gapscript "$*"
%.xml: %.txt txt2xml.sed
	sed -f txt2xml.sed "$<" > "$@"
