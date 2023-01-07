{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in {
  users.users.${vars.userName}.packages = with pkgs; [
    ardour
    tenacity
    klick
    qpwgraph

    # Audio plugins (LV2, VST2, VST3)
    distrho
    calf
    eq10q
    lsp-plugins
    x42-plugins
    x42-gmsynth
    dragonfly-reverb
    guitarix

    # Support for Windows VST2/VST3 plugins
    yabridge
    yabridgectl
    wine
  ];
}
