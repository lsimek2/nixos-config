{ pkgs, ... }: {
  repl = pkgs.callPackage ./repl { };

  wl-ocr = pkgs.callPackage ./wl-ocr { };
}
