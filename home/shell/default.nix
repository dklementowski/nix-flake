{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "candy";
    };
  };

  programs.tmux = {
    enable = true;
    historyLimit = 10000;
    terminal = "screen-256color";
    keyMode = "vi";
    extraConfig = builtins.readFile ./config/tmux.conf;
  };

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

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };

  programs.password-store = {
    enable = true;
    package = pkgs.pass-wayland.withExtensions (es: with es; [
      pass-update
      pass-otp
    ]);
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
