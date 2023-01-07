{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
      defaultNetwork.dnsname.enable = true;
    };
  };
}
