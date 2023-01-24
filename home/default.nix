{ config, ... }:

let
  vars = import ../vars.nix;
in {
  home.stateVersion = vars.stateVersion;

  imports = [
    # Shell, Terminals
    ./shell
    ./kitty

    # Additional desktop stuff
    ./gaming
    ./pro-audio
    ./protonmail
  ];
}
