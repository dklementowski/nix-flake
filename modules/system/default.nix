{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in
{
  boot.kernelPackages = pkgs.linuxPackages_6_0;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.kernelParams = [
    "video=HDMI-A-1:3840x2160@60"
  ];

  # Allow nonfree software, sorry Richard
  nixpkgs.config.allowUnfree = true; 

  # Set your time zone.
  time.timeZone = vars.timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = vars.defaultLocale;
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Use NetworkManager for network management
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = vars.stateVersion; # Did you read the comment?
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-${vars.currentVersion}";
  };

  # Let's just keep that here for now...
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
}
