{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in
{
  imports = [
    ./apps.nix
  ];

  # Use Plasma on Wayland as the desktop
  services.xserver = {
    # Enable the X11 windowing system.
    # In theory, that shouldn't be required in some time, but for now SDDM only works on X11.
    enable = true;

    displayManager.sddm.enable = true;
    displayManager.defaultSession = "plasmawayland";
  };

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

    # I don't find AppImages all that useful theese days, but it doesn't seem like
    # a whole lot of packages to keep supporting them either.
    appimage-run

    # Use GNOME's cursor to overcome this bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1513
    # Forcing software curosr fixes how it looks, but introduces other glitches.
    gnome.adwaita-icon-theme
  ];

  users.users.${vars.userName}.packages = with pkgs; [
    # Fancy terminal font
    nerdfonts
    fira-code-symbols

    (callPackage ./activity-aware {})
  ];

  programs = {
    kdeconnect.enable = true;

    # Workaround for badly themed GTK apps on Wayland
    dconf.enable = true;
  };
}
