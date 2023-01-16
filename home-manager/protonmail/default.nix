{ config, pkgs, ... }:

let
  vars = import ../vars.nix;
in
{
  home.packages = [ pkgs.protonmail-bridge ];

  systemd.user.services.protonmail-bridge = {
    Unit = {
      Description = "ProtonMail background service for bridge";
    };

    Service = {
      ExecStart = "/bin/sh -c protonmail-bridge";
    };

    Install = {
      WantedBy = [ "multi-user.target" ];
    };
  };
}
