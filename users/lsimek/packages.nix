{ pkgs, pkgs-unstable, ... }:
let
  local-pkgs = import ../../packages { inherit pkgs; };
in
{

  home.packages =
    (with local-pkgs; [
      hashcards
    ])
    ++ (with pkgs-unstable; [
      tlrc
      nmap
      ani-cli
      protonup-ng
      gemini-cli
      # heroic
    ])
    ++ (with pkgs; [
      lutris
      prismlauncher
      ytfzf
      pandoc
      moonlight-qt
      elan
      kdePackages.ghostwriter
      pgcli
      pcsx2
      ytmdl
      zulu
      gimp3
      vscode-langservers-extracted
      clojure
      clojure-lsp
      cljfmt
      cljstyle
      clj-kondo
      babashka
      leiningen
      xfce4-taskmanager
      telegram-desktop
      vesktop
      signal-desktop
      element-desktop
      mupdf
      inkscape
      chromium
      nextcloud-client
      oterm
      peazip
      claude-code
      deluge-gtk
      osu-lazer-bin
      dconf
      anki-bin
      gedit
      libreoffice
      vscode-fhs
      thunderbird
      halloy
      kdePackages.kdenlive
      yt-dlp
      bemoji
    ]);
}
