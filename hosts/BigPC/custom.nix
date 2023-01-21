{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in {
  boot.kernelPackages = pkgs.linuxPackages_6_0;

  networking.hostName = "BigPC"; 
  services.openssh.enable = true;
}
