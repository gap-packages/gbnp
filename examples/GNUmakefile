.PHONY: depend

include .depend

all: ${EXAMPLESG}

example%.g: ../doc/examples/example%.g
	grep -v '^#' "$<" > "$@"

bound-test-%.g: ../doc/examples/bound-test-%.g
	grep -v '^#' "$<" > "$@"

functions.g: ../doc/examples/functions.g
	grep -v '^#' "$<" > "$@"

.depend: depend

depend: 
	{ cd .. &&${MAKE} depend ; }

