{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in
{
  imports = [
    ./users.nix
    ./extras.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 14;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Allow non-free software, sorry Richard
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

  # Basic distro settings
  # Note: don't update the stateVersion variable when switching to newer version
  system.stateVersion = vars.stateVersion; # Did you read the comment?

  # Let's just keep that here for now...
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings.auto-optimise-store = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-21.4.0"
  ];
}
