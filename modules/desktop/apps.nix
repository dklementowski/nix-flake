{ pkgs, ... }:

let
  vars = import ../../vars.nix;
in {
  users.users.${vars.userName}.packages = with pkgs; [
    # Interwebs
    firefox
    tdesktop # Telegram
    signal-desktop
    discord
    protonmail-bridge
    kmail
    evolution
    slack

    # Media players
    lollypop
    spotify
    mpv

    # Office suite
    libreoffice
    kalendar

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

  programs = {
    partition-manager.enable = true;
  };
}
