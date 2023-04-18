{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in {

  home.file.".tfswitch.toml" = {
    enable = true;
    text = "bin = \"/home/${vars.userName}/.local/bin/terraform\"";
    target = "/home/${vars.userName}/.tfswitch.toml";
  };
}
