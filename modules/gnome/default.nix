{ pkgs, lib, ... }:

let
  vars = import ../../vars.nix;
in {
  hardware.pulseaudio.enable = false;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.battery-indicator-upower
    gnome.gnome-tweaks
    tela-icon-theme
  ];

  programs.gpaste.enable = true;

  # Wayland tweaks
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";

    QT_QPA_PLATFORM = "wayland";
  };

  qt.style = "adwaita-dark";
  qt.platformTheme = "gnome";

  # Enable Flatpak support
  services.flatpak.enable = true;
}
