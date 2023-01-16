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
      rustc
      cargo
    ];
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
