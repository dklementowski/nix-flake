{ pkgs, lib, ... }:

let
  vars = import ../../vars.nix;

  slackWayland = pkgs.slack.overrideAttrs (old: {
    installPhase = old.installPhase + ''
      rm $out/bin/slack

      makeWrapper $out/lib/slack/slack $out/bin/slack \
        --prefix XDG_DATA_DIRS : $GSETTINGS_SCHEMAS_PATH \
        --prefix PATH : ${lib.makeBinPath [pkgs.xdg-utils]} \
        --add-flags "--ozone-platform=wayland --enable-features=UseOzonePlatform,WebRTCPipeWireCapturer"
    '';
  });
in {
  users.users.${vars.userName}.packages = with pkgs; [
    # Interwebs
    firefox
    nextcloud-client
    tdesktop # Telegram
    signal-desktop
    discord
    gnome.geary
    slackWayland
    teams-for-linux

    # Media players
    lollypop
    spotify
    mpv

    # Office / accessories
    libreoffice-still
    kalendar
    speedcrunch

    # Graphics
    gimp

    # Coding
    kate

    # Screen recording, streaming, video manipulation...
    obs-studio
    obs-studio-plugins.obs-gstreamer
    ffmpeg
    kdenlive

    # VM utils
    virt-manager

    # Other tools
    keepassxc
  ];


  programs = {
    partition-manager.enable = true;

    evolution = {
      enable = true;
      plugins = with pkgs; [
        evolution-ews
        gnome.gnome-keyring
      ];
    };
  };

  services.gnome.gnome-keyring.enable = lib.mkForce false;
}
