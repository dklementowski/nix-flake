{ pkgs, ... }:

let
  vars = import ../../vars.nix;
in {
  users.users.${vars.userName}.packages = with pkgs; [
    # Browser
    firefox

    # Media players
    lollypop
    spotify
    mpv

    # Office suite
    libreoffice
    kmail
    kalendar
    evolution
    slack

    # Graphics
    gimp

    # Coding
    kate

    # Screen recording, streaming, video manipulation...
    obs-studio
    obs-studio-plugins.obs-gstreamer
    ffmpeg
    kdenlive
  ];

  # Just for fun, an Android container ;-)
  virtualisation = {
    waydroid.enable = true;
    lxd.enable = true;
  };
}
