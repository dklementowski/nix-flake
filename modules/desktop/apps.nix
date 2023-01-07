{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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

    # Coding
    kate
  ];

  # Just for fun, an Android container ;-)
  virtualisation = {
    waydroid.enable = true;
    lxd.enable = true;
  };
}
