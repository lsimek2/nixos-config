{ nixvim, pkgs, ... }:
{
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
    ];
  };
}
