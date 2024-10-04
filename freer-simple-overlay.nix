  "freer-simple" = callPackage
    ({ mkDerivation, base, criterion, extensible-effects, free, mtl
     , natural-transformation, QuickCheck, tasty, tasty-hunit
     , tasty-quickcheck, template-haskell, transformers-base
     }:
     mkDerivation {
       pname = "freer-simple";
       version = "1.2.1.2";
       sha256 = "11ypffdkpaxc03hlik6ymilhnk41fy7m92zzwqjma97g614vn0lw";
       revision = "2";
       editedCabalFile = "0p5d7q1bi4prw9mp6fgrz04xb6di47ywadkh788r0chxjdd2dzgl";
       isLibrary = true;
       isExecutable = true;
       libraryHaskellDepends = [
         base natural-transformation template-haskell transformers-base
       ];
       executableHaskellDepends = [ base ];
       testHaskellDepends = [
         base QuickCheck tasty tasty-hunit tasty-quickcheck
       ];
       benchmarkHaskellDepends = [
         base criterion extensible-effects free mtl
       ];
       description = "A friendly effect system for Haskell";
       license = lib.licenses.bsd3;
       hydraPlatforms = lib.platforms.none;
       mainProgram = "freer-simple-examples";
       broken = true;
     }) {};
