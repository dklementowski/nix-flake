{ config, pkgs, modulesPath, ...}:

let
  vars = import ../../vars.nix;
  UUIDs = {
    efi    = "272C-7D79";
    root   = "d6b0fa92-30d4-4a98-a2a4-ba984c9fc8e6";
    backup = "e321cc57-8b4c-425a-97ba-4547a005713d";
    games  = "ec551948-21e6-4b0f-86c4-41a6132c7827";
    swap   = "fd460598-98f1-4f4b-b77c-f4c7a2432830";
  };
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

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

    "/mnt/backup" = {
      device = "/dev/mapper/backup";
      fsType = "ext4";
      encrypted = {
        blkDev = "/dev/disk/by-uuid/${UUIDs.backup}";
        enable = true;
        label = "backup";
        keyFile = "/mnt-root/root/.backup-key";
      };
    };

    "/mnt/games" = {
      device = "/dev/disk/by-uuid/${UUIDs.games}";
      fsType = "btrfs";
    };

    "/home/${vars.userName}/Games" = {
      device = "/mnt/games/Games";
      options = [ "bind" ];
    };
  };

  swapDevices = [{ device = "/dev/disk/by-uuid/${UUIDs.swap}"; }];
}
