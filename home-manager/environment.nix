{ config, pkgs, ... }:

let
  vars = import ../vars.nix;
in
{
  home.stateVersion = vars.stateVersion;

  systemd.user = {
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
