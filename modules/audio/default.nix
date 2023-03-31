{ config, pkgs, ... }:

let
  vars = ../../vars.nix;
in {
  sound.enable = true;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  environment.etc = {
    "pipewire.conf.d/rt.conf".source = ./pipewire.conf.d/rt.conf;
  };

  # Realtime privileges for audio production
  security.rtkit.enable = true;
  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"   ; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio" ; type = "-"   ; value = "99"       ; }
    { domain = "@audio"; item = "nofile" ; type = "soft"; value = "99999"    ; }
    { domain = "@audio"; item = "nofile" ; type = "hard"; value = "524288"    ; }
  ];
}
