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

    clipboard.providers.xclip.enable = true;

    plugins = {
      lualine.enable = true;
      telescope.enable = true;
      oil.enable = true;
      treesitter.enable = true;
      luasnip.enable = true;

      nvim-tree.enable = true;
      surround.enable = true;
      bufferline.enable = true;

#      lazy.enable = true;
    };

    plugins.lsp = {
      enable = true;

      servers = {
        ruff.enable = true;
        hls.enable = true;
        ccls.enable = true;

        rust-analyzer.enable = true;
        rust-analyzer.installRustc = false;
        rust-analyzer.installCargo = false;

        ruby-lsp.enable = true;
        clojure-lsp.enable = true;
        zls.enable = true;

        html.enable = true;
        cssls.enable = true;

        nushell.enable = true;
        bashls.enable = true;

        nixd.enable = true;
        ltex.enable = true;
      };
    };

    plugins.alpha = {
      enable = true;
      theme = "dashboard";
    };

    plugins.cmp = {
      enable = true;
      autoEnableSources = true;

      settings.sources = [
        { name = "nvim-lsp"; }
        { name = "path"; }
        { name = "buffer"; }
        #{ name = "cmdline"; }
        #{ name = "cmdline-history"; }
        { name = "dictionary"; }
        { name = "latex_symbols"; }
        { name = "luasnip"; }
      ];
      
      settings.mapping = {
      	 "<CR>" = "cmp.mapping.confirm({ select = true })";
	 "<Tab>" = ''
	   cmp.mapping(
	     function(fallback)
		if cmp.visible() then
		 cmp.select_next_item()
		elseif luasnip and luasnip.expandable() then
		 luasnip.expand()
		elseif luasnip and luasnip.expand_or_jumpable() then
		 luasnip.expand_or_jump()
		elseif check_backspace and check_backspace() then
		 fallback()
		else
		 fallback()
		end
	     end
	   ,
	   { "i", "s" }
	 )
         '';
       };
    };


    opts = {
      number = true;
      relativenumber = true;
      expandtab = true;

      shiftwidth = 2;

    };

    keymaps = [
      {
        action = "<cmd>NvimTreeToggle<CR>";
        key = "<C-n>";
        mode = "n";
      }

      {
        action = "<cmd>bnext<CR>";
        key = "<Tab>";
        mode = "n";
      }

      {
        action = "<cmd>bprevious<CR>";
        key = "<S-Tab>";
        mode = "n";
      }

      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<Space>ff";
        mode = "n";
      }

      {
        action = "<C-w>l";
        key = "<C-l>";
        mode = "n";
      }

      {
        action = "<C-w>h";
        key = "<C-h>";
        mode = "n";
      }

      {
        action = "<cmd>close<CR>";
        key = "<Space>x";
        mode = "n";
      }
    ];

    globals.mapleader = " ";
  };
}
