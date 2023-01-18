{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
  pythonPackages = p: with p; [
    boto3
    pyyaml
    validate-email
    docopt
  ];
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
    awscli2

    # Python for runing helper scripts like AWS SSO
    (pkgs.python3.withPackages pythonPackages)
  ];

  virtualisation = {
    libvirtd.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
