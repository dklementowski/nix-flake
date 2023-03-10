{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;

  profilePath = "~/.nix-profile/";
  homePath    = "/home/${vars.userName}";
  lv2Path     = "${profilePath}/lib/lv2";
  vstPath     = "${profilePath}/lib/vst:${homePath}/.vst:${homePath}/.vst/yabridge";
  vst3Path    = "${profilePath}/lib/vst3";
  ladspaPath  = "${profilePath}/lib/ladspa";
in {
  # Make audio software detect LV2, VST2 and VST3 plugins
  systemd.user.sessionVariables = {
    LV2_PATH    = lv2Path;
    VST_PATH    = vstPath;
    LXVST_PATH  = vstPath;
    VST3_PATH   = vst3Path;
    LADSPA_PATH = ladspaPath;
  };

  home.packages = with pkgs; [
    ardour
    tenacity
    klick
    qpwgraph

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
    geonkick

    # Support for Windows VST2/VST3 plugins
    yabridge
    yabridgectl
    wine
  ];

  # Setup Yabridge
  home.file = {
    ".config/yabridgectl/config.toml".text = ''
      plugin_dirs = ['/home/${vars.userName}/.win-vst']
      vst2_location = 'centralized'
      no_verify = false
      blacklist = []
    '';
  };
}
