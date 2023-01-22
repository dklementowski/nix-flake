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
    evolution
    slackWayland
    # teams-for-linux # TODO check again in some time if it still crashes

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

    # VM utils
    virt-manager

    # Other tools
    keepassxc
    pass
  ];

  programs = {
    partition-manager.enable = true;
  };
}
