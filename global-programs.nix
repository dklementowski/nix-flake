{ config, pkgs, ... }:

let
  vars = import ./vars.nix;
in
{
  programs = {
    # Workaround for badly themed GTK apps on Wayland
    dconf.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    nix-ld.enable = true;
  };
}
