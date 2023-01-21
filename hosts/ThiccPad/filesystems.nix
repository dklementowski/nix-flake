{ config, pkgs, modulesPath, ...}:

let
  vars = import ../../vars.nix;
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/7f238399-6ef1-4d65-b9ac-0a65032b9b85";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."os".device = "/dev/disk/by-uuid/4280ec95-e2af-426e-9889-7e155589a76f";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/B49E-F6C7";
      fsType = "vfat";
    };

  swapDevices = [{
    device = "/swapfile";
    size = 18000;
  }];
}
