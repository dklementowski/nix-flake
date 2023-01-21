{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in {
  networking.hostName = "BigPC"; 
  services.openssh.enable = true;
}
