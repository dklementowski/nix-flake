{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in {
  programs.tmux = {
    enable = true;
    historyLimit = 10000;
    terminal = "screen-256color";
    keyMode = "vi";
    extraConfig = builtins.readFile ./config/tmux.conf;
  };
}
