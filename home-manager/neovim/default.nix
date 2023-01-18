{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in {
  systemd.user.sessionVariables = {
    EDITOR = "nvim";
  };

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
    extraPackages = with pkgs; [
      nodejs-18_x
      python310
      rustc
      cargo
      gcc
    ];
  };
}
