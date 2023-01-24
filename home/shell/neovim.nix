{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true; # This fails on zsh for some reason
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = [ pkgs.vimPlugins.packer-nvim ];
    extraConfig = ''
      luafile ${ ./config/neovim.lua }
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
