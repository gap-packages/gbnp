##  this creates the documentation, needs: GAPDoc and AutoDoc packages, pdflatex
##  and extracts the manual examples into tst/gbnpNN.tst
##
##  Call this with GAP from within the package directory.

if fail = LoadPackage("AutoDoc", ">= 2022.07.10") then
    Error("AutoDoc 2022.07.10 or newer is required");
fi;


files := AUTODOC_FindMatchingFiles(DirectoryCurrent(), [ "doc/examples" ], [ "xml" ]);

AutoDoc(rec(
    gapdoc := rec(
        scan_dirs := [ "lib", "lib/nmo" ],
        files := files,
    ),
    #autodoc := rec( files := [ "doc/Intros.autodoc" ] ),
    scaffold := rec(
        bib := "gbnp_doc",
        includes := [ "gbnp_doc.xml", "nmo.xml" ],
        appendix := [ "examples.xml" ],
    ),
    # one file per section: each appendix example is its own session
    extract_examples := rec( units := "Section" ),
));
