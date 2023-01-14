{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in {
  users.users.${vars.userName}.packages = with pkgs; [
    ardour
    tenacity
    klick
    qpwgraph
    carla

    # Audio plugins (LV2, VST2, VST3, LADSPA)
    distrho
    calf
    eq10q
    lsp-plugins
    x42-plugins
    x42-gmsynth
    dragonfly-reverb
    guitarix
    FIL-plugins

    # Support for Windows VST2/VST3 plugins
    yabridge
    yabridgectl
    wine
  ];
}
