{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${vars.userName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "libvirtd" ];
    shell = pkgs.zsh;
  };
}
