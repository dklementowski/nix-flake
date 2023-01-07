{ config, pkgs, ... }:

let
  vars = import ./vars.nix;
in
{
  imports = [
    ./global-programs.nix
  ];

  # Configure shell basics
  environment.shells = with pkgs; [ zsh ];
  environment.shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch";
  };
  environment.variables.EDITOR = "nvim";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${vars.userName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "libvirtd" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      qpwgraph
      kmail
      kalendar
      xboxdrv
      neofetch
      nerdfonts
      fira-code-symbols
      ripgrep
      appimage-run
      nix-index

      obs-studio
      obs-studio-plugins.obs-gstreamer
      gst_all_1.gst-vaapi

      ardour
      distrho
      calf
      eq10q
      lsp-plugins
      x42-plugins
      x42-gmsynth
      dragonfly-reverb
      guitarix
      yabridge
      yabridgectl
      wine
      klick
      tenacity

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
    sddm-kcm
    bluedevil
    discover
    ark
    kate
    gnome.adwaita-icon-theme

    thefuck
    wget
    curl
    git
    wl-clipboard
    tree
    ncdu
  ];

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable Flatpak support
  services.flatpak.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.dnsname.enable = true;
    };

    # Just for fun, an Android container ;-)
    waydroid.enable = true;
    lxd.enable = true;
  };
}
