{ config, pkgs, modulesPath, ...}:

let
  vars = import ../../vars.nix;
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d8e39c4c-4794-49c8-80c7-e82f757baaa4";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-40db72d4-666a-4b1d-8137-1cad80ce64c1".device = "/dev/disk/by-uuid/40db72d4-666a-4b1d-8137-1cad80ce64c1";

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/3865-F6CD";
      fsType = "vfat";
    };

  swapDevices = [ ];

  #swapDevices = [{
  #  device = "/swapfile";
  #  size = 18000;
  #}];
}
