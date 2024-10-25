{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  pname = "nwg-launchers-assets";
  version = "1.0";
  installPhase = ''
    mkdir -p $out/usr/share/nwg-launchers
    cp -r ./res/* $out/usr/share/nwg-launchers
  '';
  src = ./.;
}

