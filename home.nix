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

  systemd.user = {
    sessionVariables = {
      # Make Ardour (and other DAWs detect LV2 plugins)
      LV2_PATH = "/etc/profiles/per-user/${vars.userName}/lib/lv2";
    };

    services = {
      # Extra per-user systemd services
      protonmail-bridge = {
        Unit = {
          Description = "ProtonMail background service for bridge";
        };

        Service = {
          ExecStart = "/bin/sh -c protonmail-bridge";
        };
      };
    };
  };
}
