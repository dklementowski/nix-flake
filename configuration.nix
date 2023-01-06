{ config, pkgs, ... }:

let
  vars = import ./vars.nix;
in
{
  imports =
    [ ./hardware-configuration.nix
      ./global-programs.nix
    ];

  # Allow nonfree software
  nixpkgs.config.allowUnfree = true; 

  boot.kernelPackages = pkgs.linuxPackages_6_0;
  boot.extraModulePackages = with config.boot.kernelPackages; [ it87 v4l2loopback ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.kernelParams = [
    "video=HDMI-A-1:3840x2160@60"
  ];

  networking.hostName = "BigPC"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = vars.timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = vars.defaultLocale;
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"   ; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio" ; type = "-"   ; value = "99"       ; }
    { domain = "@audio"; item = "nofile" ; type = "soft"; value = "99999"    ; }
    { domain = "@audio"; item = "nofile" ; type = "hard"; value = "99999"    ; }
  ];
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
    config.pipewire = {
      "context.properties" = {
        "link.max-buffers" = 16;
        "log.level" = 2;
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 128;
        "default.clock.min-quantum" = 128;
        "default.clock.max-quantum" = 128;
        "core.daemon" = true;
        "core.name" = "pipewire-0";
      };
      "context.modules" = [
        {
          name = "libpipewire-module-rtkit";
          args = {
            "nice.level" = -15;
            "rt.prio" = 88;
            "rt.time.soft" = 200000;
            "rt.time.hard" = 200000;
          };
          flags = [ "ifexists" "nofail" ];
        }
        { name = "libpipewire-module-protocol-native"; }
        { name = "libpipewire-module-profiler"; }
        { name = "libpipewire-module-metadata"; }
        { name = "libpipewire-module-spa-device-factory"; }
        { name = "libpipewire-module-spa-node-factory"; }
        { name = "libpipewire-module-client-node"; }
        { name = "libpipewire-module-client-device"; }
        {
          name = "libpipewire-module-portal";
          flags = [ "ifexists" "nofail" ];
        }
        {
          name = "libpipewire-module-access";
          args = {};
        }
        { name = "libpipewire-module-adapter"; }
        { name = "libpipewire-module-link-factory"; }
        { name = "libpipewire-module-session-manager"; }
      ];
    };
  };

  # Enable Bluetooth support.
  hardware.bluetooth.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

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

      heroic
      gogdl
      lutris
    ];
  };

  # Gaming-related
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
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

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gnome
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
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = vars.stateVersion; # Did you read the comment?
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-${vars.currentVersion}";
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
}
