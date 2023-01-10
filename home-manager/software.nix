{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      python39
      python39Packages.pip

      glfw # Dependency for reVC
    ];
  };

  programs = {
    kitty = {
      enable = true;
      font.name = "FiraCode Nerd Font";
      font.size = 12;

      settings = {
        wayland_titlebar_color = "#000000";
        hide_window_decoration = "yes";
        active_tab_foreground = "#000";
        active_tab_background = "#eee";
        enable_audio_bell = "no";
      };
    };

    mangohud = {
      enable = true;
    };
  };
}
