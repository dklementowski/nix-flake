{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font";

    settings = {
      wayland_titlebar_color = "#000000";
      hide_window_decoration = "yes";
      active_tab_foreground = "#000";
      active_tab_background = "#eee";
      enable_audio_bell = "no";
    };
  };
}
