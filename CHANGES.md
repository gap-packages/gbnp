This file describes changes in the GBNP package.

## Unreleased

- Fix compatibility with the development version of GAP, where `Grobner`,
  `SGrobner` and everything built on them failed with the error
  "`<type>` implies `IsDataObjectRep` but `<obj>` requires
  `IsComponentObjectRep`"
- Fix `InstallNoncommutativeMonomialOrdering` failing when given the name
  of the new ordering as a string, as the manual describes
- Correct the manual examples whose output no longer matched what GBNP
  prints, and examples that showed GAP code without its input prompt; the
  examples are now checked automatically. They no longer show timing
  information, which differs from one computer to the next
- Fix the description of `OrderingLtFunctionListRep` and
  `OrderingGtFunctionListRep` in the manual
- Correct many typos, grammar mistakes, wrong function names and outdated
  statements in the manual and README
- Fix module elements being printed without their zero components, e.g.
  `[ b - 1 ]` instead of `[ b - 1 , 0]`, after an earlier computation used
  fewer module generators

## 1.1.0 (2024-08-29)

- Fix a bug the could cause an unexpected error in the Grobner command
- Add LMonNP, LTermNP, LTermsNP; FactorOutGcdNP
- Integrate NMO manual as chapter 5 into the GBNP manual
- Various janitorial changes

## 1.0.5 (2022-03-09)

- Various janitorial changes

## 1.0.4 (2021-05-28)

- Move package to a new home at GitHub (with a new homepage,
  issue tracker, public git repository, etc.)
- Many, many janitorial changes; the most important bit is that
  now new releases of this package can be made quickly, if e.g.
  someone submits a bugfix

## 1.0.3 (2016-03-08)

- ???

## 1.0.1 (2010-05-12)

- ???

## 0.9.5

- added examples 24 and 25
- changed some examples and the order of the examples
- several changes to the manual
- StrongNormalFormTraceNP has been replaced by StrongNormalFormTraceDiff

## 0.9.4

 - added example 23 (jwk)
 - added workspace creation with "workspace" target (for faster rebuilding of
     examples/documentation set $GAP as displayed) (jwk)

Acknowledgments:
  -based on an earlier version by Rosane Ushirobira
  -based on literature by Teo Mora
  -from 0.8.3 on: three additional files (fincheck.g, tree.g graphs.g)
   with routines for finding the Hilbert function and testing
   finite-dimensionality when given a GB by Chris Krook, based on
   work by Victor Ufnarovski.
  -From 0.9 on the package is enriched with support for gap-fields and
   additional prefix rules as well as some speed improvements by Jan
   Willem Knopper.

Authors:
    A.M. Cohen & D.A.H. Gijsbers
