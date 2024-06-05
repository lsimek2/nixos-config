{ stylix, pkgs, ... }: {
  stylix.image = pkgs.fetchurl {
    url = "https://images.squarespace-cdn.com/content/v1/536ce6b7e4b023ebcb5fc045/1534918235616-LJ5FTYQDFNLS6R12IA6I/to_sh250_ooh_01_01_wip002.jpg?format=2500w";

    sha256 = "LTD8jdG0ZSOB81SaDrTo75yFvYZcJ3LQaIRnZDNfJog=";
  };

  stylix.polarity = "dark";

}
