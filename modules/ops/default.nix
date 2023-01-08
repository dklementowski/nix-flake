{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in {
  users.users.${vars.userName}.packages = with pkgs; [
    vagrant
    tfswitch
    packer
    ansible
    virt-manager
    podman-compose
    pods
    k9s
  ];

  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}
