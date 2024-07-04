LoadPackage("GBNP");

real_START_TEST := START_TEST;
START_TEST := function( name )
    real_START_TEST( name );

        # reset printing
        GBNP.ConfigPrint();

        # reset Info levels
        SetInfoLevel(InfoGBNP,0);
        SetInfoLevel(InfoGBNPTime,0);

        # reset options
        GBNP.ClearOptions();

        # reset names of polynomial indeterminates
        RationalFunctionsFamily( ElementsFamily( FamilyObj( Rationals)))!.namesIndets := [];
end;

dirs := DirectoriesPackageLibrary("GBNP", "tst");
TestDirectory(dirs,
  rec(exitGAP     := true,
      testOptions := rec(compareFunction := "uptowhitespace") ) );
FORCE_QUIT_GAP(1);
