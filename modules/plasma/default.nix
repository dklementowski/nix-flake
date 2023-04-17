{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in
{
  imports = [
    ./apps.nix
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd startplasma-wayland";
        user = vars.userName;
      };
    };
  };
  security.pam.services.greetd.enableKwallet = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable desktop portals to play nicely with Wayland and Flatpaks
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
    };
  };

  # Enable Flatpak support
  services.flatpak.enable = true;

  # Wayland tweaks
  environment.sessionVariables = {
    GTK_USE_PORTAL = "1";
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    # Some missing packages for KDE Plasma desktop
    # It might change over time as packages are being added to pre-installed in nixpkgs.
    sddm-kcm
    bluedevil
    discover
    ark
    okular
    gwenview
    dolphin

    libsForQt5.accounts-qt
    libsForQt5.kaccounts-integration
    libsForQt5.kaccounts-providers
    libsForQt5.applet-window-buttons
    libsForQt5.polkit-kde-agent

    # Use GNOME's cursor to overcome this bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1513
    # Forcing software curosr fixes how it looks, but introduces other glitches.
    gnome.adwaita-icon-theme
  ];

  users.users.${vars.userName}.packages = with pkgs; [
    (callPackage ./activity-aware {})
  ];

  services.dbus.packages = [ pkgs.gcr ];

  programs = {
    kdeconnect.enable = true;
    partition-manager.enable = true;

    # Workaround for badly themed GTK apps on Wayland
    dconf.enable = true;
  };
}
