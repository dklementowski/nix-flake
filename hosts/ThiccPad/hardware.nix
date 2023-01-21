{ config, lib, pkgs, modulesPath, ... }:

let
  vars = import ../../vars.nix;
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvmi" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Hardware specific packages like AMD GPU utils, hw video accel drivers etc.
  environment.systemPackages = with pkgs; [
    intel-media-driver
    vaapiVdpau
    libvdpau-va-gl
  ];
}
