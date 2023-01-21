{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in {
  boot.kernelPackages = pkgs.linuxPackages_5_15;

  networking.hostName = "ThiccPad"; 
}
