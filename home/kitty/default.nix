{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in {
  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font";

    settings = {
      wayland_titlebar_color = "#000000";
      hide_window_decorations = "yes";
      active_tab_foreground = "#000";
      active_tab_background = "#eee";
      enable_audio_bell = "no";
    };
  };

  # Configure fonts
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerdfonts
    fira-code-symbols
  ];
}
