{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in {
  imports = [
    ./filesystems.nix
    ./hardware.nix
  ];
}
