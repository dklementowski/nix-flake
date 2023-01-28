{ config, ... }:

{
  imports = [
    ./zsh.nix
    ./tmux.nix
    ./neovim.nix
    ./pass.nix
  ];
}
