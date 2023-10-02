##  this creates the documentation, needs: GAPDoc and AutoDoc packages, pdflatex
##
##  Call this with GAP from within the package directory.

if fail = LoadPackage("AutoDoc", ">= 2019.04.10") then
    Error("AutoDoc 2019.04.10 or newer is required");
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
));
