{ config, ... }:

let
  vars = import ../vars.nix;
in {
  home.stateVersion = vars.stateVersion;

  imports = [
    # Shell, Terminals
    ./shell
    ./kitty

    # Additional desktop stuff
    ./gaming
    ./pro-audio
    ./protonmail
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    desktop     = "${config.home.homeDirectory}/Pulpit";
    documents   = "${config.home.homeDirectory}/Dokumenty";
    download    = "${config.home.homeDirectory}/Pobrane";
    music       = "${config.home.homeDirectory}/Muzyka";
    pictures    = "${config.home.homeDirectory}/Obrazy";
    videos      = "${config.home.homeDirectory}/Wideo";
    templates   = "${config.home.homeDirectory}/Szablony";
    publicShare = "${config.home.homeDirectory}/Publiczny";
  };

  services.syncthing.enable = true;
}
