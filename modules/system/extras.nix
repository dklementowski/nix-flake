{ config, pkgs, ... }:

{
  # A workaround for dynamically linked 3rd party (unpatched) libraries
  # https://github.com/Mic92/nix-ld
  programs.nix-ld.enable = true;

  # Additional system packages
  environment.systemPackages = with pkgs; [
    cryptsetup # FIXME move to hosts after moving backup to unencrypted drive
    nix-index
    lm_sensors

    networkmanager-fortisslvpn
  ];

  programs.command-not-found.enable = true;

  # Hosts for local VM testing
  networking.extraHosts = "10.80.81.10 vm.local";
}
