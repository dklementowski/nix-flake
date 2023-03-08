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
      ExecStart = "${pkgs.protonmail-bridge}/bin/bridge --noninteractive --no-window";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
