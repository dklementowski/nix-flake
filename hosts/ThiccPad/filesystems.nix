{ config, pkgs, modulesPath, ...}:

let
  vars = import ../../vars.nix;
  UUIDs = {
    efi    = "B49E-F6C7";
    root   = "fec73dd4-9e1d-4632-8bf3-41e011834756";
    swap   = "c7e5502c-f02c-40e2-bced-19afd6332d14";
  };
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.luks.devices = {
    os   = { device = "/dev/disk/by-uuid/${UUIDs.root}"; };
    swap = { device = "/dev/disk/by-uuid/${UUIDs.swap}"; };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/${UUIDs.root}";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/${UUIDs.root}";
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };

    "/var" = {
      device = "/dev/disk/by-uuid/${UUIDs.root}";
      fsType = "btrfs";
      options = [ "subvol=@var" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/${UUIDs.root}";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

    "/boot/efi" = {
      device = "/dev/disk/by-uuid/${UUIDs.efi}";
      fsType = "vfat";
    };
  };

  swapDevices = [{
    device = "/dev/disk/by-uuid/${UUIDs.swap}";
    encrypted.enable = true;
  }];
}
