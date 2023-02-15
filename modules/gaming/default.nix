{ configs, pkgs, ... }:

{
  # DRI support for OpenGL and Vulkan (with 32bit support for older games)
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  # Steam
  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true;
    # dedicatedServer.openFirewall = true;
  };

  # Additional packages for games
  environment.systemPackages = with pkgs; [
    # Game launchers and their tools
    lutris
    heroic
    gogdl

    # System-wide utilities
    xboxdrv
    gamescope
    steamtinkerlaunch
  ];
}
