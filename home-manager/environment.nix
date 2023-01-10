{ config, pkgs, ... }:

let
  vars = import ../vars.nix;
in
{
  home.stateVersion = vars.stateVersion;

  systemd.user = {
    sessionVariables = {
      # Make Ardour (and other DAWs) detect LV2 plugins
      LV2_PATH = "/etc/profiles/per-user/${vars.userName}/lib/lv2";

      #TODO maybe I can set such values for VST2 and VST3 as well?
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
