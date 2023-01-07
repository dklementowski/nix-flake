{ config, pkgs, ... }:

let
  vars = import ./vars.nix;
in
{
  imports = [
    ./apps.nix
  ];

  # Enable the X11 windowing system.
  # In theory, that shouldn't be required in some time, but for now SDDM only works on X11.
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";

  # Enable desktop portals to play nicely with Wayland and Flatpaks
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gnome
  ];

  # Enable Flatpak support
  services.flatpak.enable = true;

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

    # Fancy terminal font
    nerdfonts
    fira-code-symbols
  ];

  programs = {
    kdeconnect.enable = true;

    # Workaround for badly themed GTK apps on Wayland
    dconf.enable = true;
  };
}
