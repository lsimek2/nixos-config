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

		colorschemes.gruvbox.enable = true;
		plugins = {
			lualine.enable = true;
			telescope.enable = true;
			oil.enable = true;
			treesitter.enable = true;
			luasnip.enable = true;
		};
	
		plugins.lsp = {
			enable = true;
	
			servers = {
				ruff.enable = true;
			};
		};
	
		plugins.cmp = {
			enable = true;
			autoEnableSources = true;
	
# 			sources = [
# 				{name = "nvim-lsp";}
# 				{name = "path";}
# 				{name = "buffer";}
# 			];
		};
	
		options = {
			number = true;
			relativenumber = true;
	
			shiftwidth = 2;
	
		};
	
	  globals.mapleader = " ";
	};
}
