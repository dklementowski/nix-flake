{ config, ... }:

let
  vars = import ../vars.nix;
in {
  home.stateVersion = vars.stateVersion;

  imports = [
    # Shell, Terminals
    ./neovim
    ./zsh
    ./kitty
    ./tmux

    # Additional desktop stuff
    ./gaming
    ./pro-audio
    ./protonmail
  ];
}
