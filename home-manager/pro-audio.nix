{ config, pkgs, ... }:

let
  vars = import ../vars.nix;

  profilePath = "/etc/profiles/per-user/${vars.userName}";
  homePath    = "/home/${vars.userName}";
  lv2Path     = "${profilePath}/lib/lv2";
  vstPath     = "${profilePath}/lib/vst:${homePath}/.vst:${homePath}/.vst/yabridge";
  vst3Path    = "${profilePath}/lib/vst3";
  ladspaPath  = "${profilePath}/lib/ladspa";
in {
  systemd.user = {
    sessionVariables = {
      # Make audio software detect LV2, VST2 and VST3 plugins
      LV2_PATH    = lv2Path;
      VST_PATH    = vstPath;
      LXVST_PATH  = vstPath;
      VST3_PATH   = vst3Path;
      LADSPA_PATH = ladspaPath;
    };
  };

  # Completely custom dotfiles
  home.file = {
    ".config/yabridgectl/config.toml".text = ''
      plugin_dirs = ['/home/${vars.userName}/.win-vst']
      vst2_location = 'centralized'
      no_verify = false
      blacklist = []
    '';
  };
}
