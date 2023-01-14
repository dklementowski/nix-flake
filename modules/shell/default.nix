{ configs, pkgs, ... }:

let
  vars = ../../vars.nix;
in {
  # Configure shell basics
  environment = {
    shells = with pkgs; [ zsh ];

    shellAliases = {
      ll = "ls -lah";
    };

    systemPackages = with pkgs; [
      killall
      tree
      ripgrep
      wl-clipboard
      wget
      curl
      git
      ncdu
      btop
      neofetch
      unzip

      # LSP dependencies
      sumneko-lua-language-server
      rnix-lsp
      nodejs-18_x
    ];
  };

  programs = {
    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "candy";
      };
    };

    tmux = {
      enable = true;
      historyLimit = 10000;
      terminal = "screen-256color";
      keyMode = "vi";
      extraConfig = builtins.readFile ./dotfiles/tmux.conf;
    };

    neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      defaultEditor = true;
      withPython3 = true;
      withNodeJs = true;
      configure = {
        customRC = ''
          luafile ${ ./dotfiles/nvim/init.lua }
        '';

        packages.plugins = with pkgs.vimPlugins; {
          start = [ packer-nvim ];
        };
      };
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
