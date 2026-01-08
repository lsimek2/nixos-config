{ lib, ... }:
{
  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
      font = lib.mkForce "monospace:size=15";
      prompt = "> ";
      lines = 15;
      width = 75;
      icons-enabled = "yes";
      # launch-prefix = "uwsm app -- ";
    };
    colors = {
      # background = "1e1e2eff";
      # text = "dcdceeff";
      # selection = "5a5a6eff";
      # border = "3a3a3eff";
      # match = "ff6e6eff";
    };
    border = {
      width = 1;
      radius = 5;
    };
  };
}
