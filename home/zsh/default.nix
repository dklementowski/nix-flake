{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in {
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "candy";
    };
  };
}
