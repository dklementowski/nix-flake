{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ardour
    tenacity
    klick
    qpwgraph

    yabridge
    yabridgectl
    wine

    # Audio plugins (LV2, VST2, VST3)
    distrho
    calf
    eq10q
    lsp-plugins
    x42-plugins
    x42-gmsynth
    dragonfly-reverb
    guitarix
  ];
}
