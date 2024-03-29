{ configs, pkgs, ... }:

{
  # DRI support for OpenGL and Vulkan (with 32bit support for older games)
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  # Enable experimental support for RADV Graphics Pipeline feature
  # That will be default starting with Mesa 23.1
  environment.variables = {
    RADV_PERFTEST = "gpl";
  };

  # Avoid crashes in some Windows games
  boot.kernel.sysctl = {
    "vm.max_map_count" = "2147483642";
  };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
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
    mesa-demos
  ];
}
