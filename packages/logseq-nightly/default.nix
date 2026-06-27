{ appimageTools, fetchurl, lib }:

let
  pname = "logseq-nightly";
  version = "2.0.1-alpha-nightly-2026-06-24";
  src = fetchurl {
    url = "https://github.com/logseq/logseq/releases/download/nightly/Logseq-linux-x86_64-2.0.1.AppImage";
    hash = "sha256-v90mkUwKzhEJur1tYOga/ziKs+bjcvKkviTl2ia49W4=";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  meta = {
    description = "Privacy-first, open-source platform for knowledge management and collaboration (nightly)";
    homepage = "https://github.com/logseq/logseq";
    license = lib.licenses.agpl3Only;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    mainProgram = "logseq";
  };
}
