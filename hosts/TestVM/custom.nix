{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in {
  services.openssh.enable = true;
}
