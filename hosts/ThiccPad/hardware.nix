{ config, lib, pkgs, modulesPath, ... }:

let
  vars = import ../../vars.nix;
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };

    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxPackages_5_15;
    extraModulePackages = with config.boot.kernelPackages; [];
  };

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

  networking.hostName = "ThiccPad"; 
  networking.useDHCP = lib.mkDefault true;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
