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
    ];
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
