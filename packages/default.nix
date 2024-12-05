{ pkgs, ... }:
{
  repl = pkgs.callPackage ./repl { };

  ammonite = pkgs.callPackage ./ammonite { };

  wl-ocr = pkgs.callPackage ./wl-ocr { };
}
