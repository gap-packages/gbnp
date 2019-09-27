#############################################################################
##  
##  PackageInfo.g for the package `GBNP'
##

SetPackageInfo( rec(

PackageName := "GBNP",
Subtitle := "computing Gröbner bases of noncommutative polynomials",
Version := "1.0dev",
Date := "08/03/2016", # dd/mm/yyyy format
License := "LGPL-2.1-or-later", # SPDX identifier

##  <#GAPDoc Label="PKGVERSIONDATA">
##  <!ENTITY VERSION "1.0dev">
##  <!ENTITY DATE "8 March 2016">
##  <#/GAPDoc>

Persons := [
  rec( 
    LastName      := "Cohen",
    FirstNames    := "A.M.",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "A.M.Cohen@tue.nl",
    WWWHome       := "http://www.win.tue.nl/~amc",
    PostalAddress := Concatenation( [
                       "RIACA\n",
		       "Dept. Math. and Comp. Sc.\n",
		       "Eindhoven University of Technology\n",
                       "PO Box 513\n",
		       "5600 MB Eindhoven\n",
                       "The Netherlands" ] ),
    Place         := "Eindhoven",
    Institution   := "Eindhoven University of Technology"
  ),
  rec( 
    LastName      := "Knopper",
    FirstNames    := "J.W.",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "J.W.Knopper@tue.nl",
    PostalAddress := Concatenation( [
                       "RIACA\n",
		       "Dept. Math. and Comp. Sc.\n",
		       "Eindhoven University of Technology\n",
                       "PO Box 513\n",
		       "5600 MB Eindhoven\n",
                       "The Netherlands" ] ),
    Place         := "Eindhoven",
    Institution   := "Eindhoven University of Technology"
  ),
],

Status := "accepted",
CommunicatedBy := "Alexander Hulpke (Fort Collins, CO)",
AcceptDate := "05/2010",

PackageWWWHome  := "https://gap-packages.github.io/gbnp/",
README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/gap-packages/gbnp",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/gbnp-", ~.Version ),
ArchiveFormats := ".tar.gz",

AbstractHTML := 
  "The <span class=\"pkgname\">GBNP</spam> package provides algorithms for \
   computing Grobner bases of noncommutative polynomials with coefficients \
   from a field implemented in <span class=\"pkgname\">GAP</span> and with \
   respect to the \"total degree first then lexicographical\" ordering. \
   Further provided are some variations, such as a weighted and truncated \
   version and a tracing facility. The word \"algorithm\" is to be \
   interpreted loosely here: in general one cannot expect such an algorithm \
   to terminate, as it would imply solvability of the word problem for \
   finitely presented (semi)groups.",
               
PackageDoc := rec(
  BookName  := "GBNP",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Non-commutative Gröbner bases",
  Autoload  := true
),

Dependencies := rec(
  GAP := ">=4.4",
  NeededOtherPackages := [["GAPDoc", ">= 0.99"]],
  SuggestedOtherPackages := [],
  ExternalConditions := []
                      
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

Keywords := ["Grobner basis", "noncommutative polynomial", "partial Hilbert series"],

));


