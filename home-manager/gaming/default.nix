{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in
{
  home.packages = with pkgs; [
    glfw # Dependency for reVC
  ];

  programs.mangohud = {
    enable = true;
  };
}
