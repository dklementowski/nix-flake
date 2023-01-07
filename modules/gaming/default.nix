{ configs, pkgs, ... }:

let
  vars = ../../vars.nix;
in {
  # DRI support for OpenGL and Vulkan
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Additional packages for games
  environment.systemPackages = with pkgs; [
    lutris
    heroic
    gogdl
  ];
}
