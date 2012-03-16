.PHONY: depend

include .depend

all: ${EXAMPLESG}

example%.g: ../doc/examples/example%.g
	grep -v '^#' "$<" > "$@"

.depend: depend

depend: 
	{ cd .. &&${MAKE} depend ; }

