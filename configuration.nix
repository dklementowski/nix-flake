{ config, pkgs, ... }:

let
  vars = import ./vars.nix;
in
{
  imports = [
    ./global-programs.nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${vars.userName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "libvirtd" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      obs-studio
      obs-studio-plugins.obs-gstreamer
      gst_all_1.gst-vaapi

      vagrant
      tfswitch
      packer
      ansible
      virt-manager
      podman-compose
      pods
      k9s
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    cryptsetup
    lm_sensors
    libva-utils
    libva-minimal
    vaapiVdpau
    radeontop
    radeontools
  ];

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
