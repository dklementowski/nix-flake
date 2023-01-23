{ ... }:

{
  imports = [
    ./filesystems.nix
    ./hardware.nix
  ];

  #nixpkgs.overlays = [
  #  # ( import ../../overlays/gamescope-3.9.5.nix )
  #];
}
