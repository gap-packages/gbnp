[![Build Status](https://github.com/gap-packages/gbnp/workflows/CI/badge.svg?branch=master)](https://github.com/gap-packages/gbnp/actions?query=workflow%3ACI+branch%3Amaster)
[![Code Coverage](https://codecov.io/github/gap-packages/gbnp/coverage.svg?branch=master&token=)](https://codecov.io/gh/gap-packages/gbnp)

# The GAP 4 package 'GBNP'

## Summary

We provide algorithms, written in the GAP 4 programming language, for
computing Grobner bases of non-commutative polynomials with coefficients from
a field implemented in GAP, and some variations, such as a weighted and
truncated version and a tracing facility.

The word algorithm is interpreted loosely: in general one cannot
expect such an algorithm to terminate, as it would imply solvability
of the word problem for finitely presented (semi)groups.

## Distribution

 * The GitHub package repository is at
   <https://github.com/gap-packages/gbnp/>
 * and the latest release is available at
   <https://gap-packages.github.io/gbnp/>

## Copyright

The 'GBNP' package is Copyright The GAP Group, 2001-2020.

'GBNP' is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

For details, see <https://www.gnu.org/licenses/gpl.html>

## Installation

 * unpack `gbnp-<version_number>.tar.gz` in the `pkg` subdirectory
of the GAP root directory.

 * From within GAP load the package with:

    gap> LoadPackage( "gbnp" );

 * The file `manual.pdf` is in the `doc` subdirectory.

## Acknowledgments:

 * The package is based on an earlier version by Rosane Ushirobira.

 * The bulk of the package is written by Arjeh M. Cohen and Dié A.H. Gijsbers.

 * The theory is mainly taken from literature by Teo Mora and Edward L. Green.

 * From Version 0.8.3 on the package has three additional files by Chris Krook,
   based on work by Victor Ufnarovski. These files (`fincheck.g`, `tree.g`,
   `graphs.g`) contain routines for finding the Hilbert function and testing
   finite-dimensionality when given a GB.

 * From Version 0.9 on the package is enriched with support for GAP fields and
   additional prefix rules for quotient modules as well as some speed
   improvements by Jan Willem Knopper. Knopper has also formatted the
   documentation in GAPDoc.

 * From Version 1.0 on the package is extended with NMO (for Noncommutative
   Monomial Orderings) by Randall Cone. This enables the GBNP user to choose a
   wider selection of monomial orderings than the standard one built into GBNP
   itself. The files of this extension can be found in `.../gbnp/doc/nmo`,
   `.../gbnp/doc/examples/nmo`, and `.../gbnp/lib/nmo`.

## Authors:

 *  Arjeh M. Cohen, A.M.Cohen@tue.nl

 *  Jan Willem Knopper, J.W.Knopper@tue.nl

 *  Address: RIACA,   Dept. Math. and Comp. Sc., TU/e,
             POB 513, 5600 MB Eindhoven, The Netherlands.

## Contact

If you have a question relating to 'GBNP' or encounter any problems,
please report an issue on the GitHub issue tracker at:
   <https://github.com/gap-packages/gbnp/issues/new>
