{ config, pkgs, ...}:

let
  efiUUID    = "272C-7D79";
  rootUUID   = "d6b0fa92-30d4-4a98-a2a4-ba984c9fc8e6";
  backupUUID = "e321cc57-8b4c-425a-97ba-4547a005713d";
  gamesUUID  = "ec551948-21e6-4b0f-86c4-41a6132c7827";
in {
  filesystems = {
    "/" = {
      device = "/dev/disk/by-uuid/${rootUUID}";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/${rootUUID}";
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };

    #TODO @var

    "/home" = {
      device = "/dev/disk/by-uuid/${rootUUID}";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

    "/boot/efi" = {
      device = "/dev/disk/by-uuid/${efiUUID}";
      fsType = "vfat";
    };

    "/mnt/backup" = {
      device = "/dev/mapper/backup";
      fsType = "ext4";
      encrypted = {
        blkDev = "/dev/disk/by-uuid/${backupUUID}";
        enable = true;
        label = "backup";
        keyFile = "/mnt-root/root/.backup-key";
      };
    };

    "/mnt/sandisk" = {
      device = "/dev/disk/by-uuid/${gamesUUID}";
      fsType = "btrfs";
    };

    "/home/${var.userName}/Games" = {
      device = "/mnt/sandisk/Games";
      options = [ "bind" ];
    };
  };

  #TODO setup swap + hibernation
  swapDevices = [ ];
}
