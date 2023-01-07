{ config, pkgs, ... }:

{
  # A workaround for dynamically linked 3rd party (unpatched) libraries
  # https://github.com/Mic92/nix-ld
  programs.nix-ld.enable = true;

  # Additional system packages
  environment.systemPackages = with pkgs; [
    cryptsetup # @TODO move to hosts after moving backup to unencrypted drive
    nix-index
    lm_sensors
  ];
}
