{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = [ pkgs.vimPlugins.packer-nvim ];
    extraConfig = ''
      luafile ${ ./config/init.lua }
    '';
  };
}
