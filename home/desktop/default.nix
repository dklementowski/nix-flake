{ config, ... }:

{
  imports = [ ./plasma.nix ];

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
}
