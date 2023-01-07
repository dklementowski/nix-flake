{ config, pkgs, ... }:

let
  vars = import ./vars.nix;
in
{
  home = {
    stateVersion = vars.stateVersion;

    packages = with pkgs; [
      python39
      python39Packages.pip

      glfw
    ];

    #TODO investigate why it doesn't work (or does it)
    sessionVariables = {
      LV2_PATH = "/etc/profiles/per-user/${vars.userName}/lib/lv2";
    };
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

    mangohud.enable = true;
  };
}
