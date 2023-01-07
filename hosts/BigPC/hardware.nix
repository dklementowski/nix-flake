{ config, lib, pkgs, modulesPath, ... }:

let
  vars = import ../../vars.nix;
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ it87 v4l2loopback ];

  # For some reason the TV's default resolution is 1920x1080 and the TV's built-in upscaler is a joke.
  # Let's avoid that ugly thing whenever possible.
  boot.kernelParams = [
    "video=HDMI-A-1:3840x2160@60"
  ];

  hardware.bluetooth.enable = true;
}
