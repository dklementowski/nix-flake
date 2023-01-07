{ config, pkgs, ... }:

let
  vars = import ../../vars.nix
{
  imports = [
    ./filesystems.nix
    ./hardware.nix
  ];
}
