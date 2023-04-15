{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
  pythonPackages = p: with p; [
    boto3
    pyyaml
    validate-email
    docopt
    pydns
    pip
  ];
in {
  users.users.${vars.userName}.packages = with pkgs; [
    vagrant
    tfswitch
    packer
    ansible
    podman-compose
    pods
    k9s
    kubectl
    kubernetes-helm
    awscli2
    dnsutils

    # Python for runing helper scripts like AWS SSO
    (pkgs.python3.withPackages pythonPackages)
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.ovmf.enable = true;
      qemu.package = pkgs.qemu_kvm;
    };

    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.shellAliases = {
    kcd = "kubectl config set-context $(kubectl config current-context) --namespace";
  };
}
