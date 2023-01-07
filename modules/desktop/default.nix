{ config, pkgs, ... }:

let
  vars = import ./vars.nix;
in
{
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
}
