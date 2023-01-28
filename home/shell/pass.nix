{ config, pkgs, ... }:

{
  programs.password-store = {
    enable = true;
    package = pkgs.pass-wayland.withExtensions (es: with es; [
      pass-update
      pass-otp
    ]);
  };
}
