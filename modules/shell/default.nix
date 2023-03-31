{ configs, pkgs, ... }:

let
  vars = ../../vars.nix;
in {
  # Configure shell basics
  environment = {
    variables = {
      EDITOR = "nvim";
      BROWSER = "xdg-open";
    };

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

    localBinInPath = true;
  };

  programs.zsh.enable = true;
  programs.ssh.startAgent = true;
}
