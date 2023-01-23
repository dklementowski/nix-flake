self: super:

let
  system = "x86_64-linux";
  libliftoffOldTb = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/6b14b4fb30a94559a3e4e4dac7c83bb15e11e494.tar.gz";
    sha256 = "0ld83hccgq58bdjfh00ps2vvd6lyd5gjkrpkvprymkdx292rq1ms";
  };

  oldDeps = import libliftoffOldTb { inherit system; };
in {
  gamescope = super.gamescope.overrideAttrs (old: rec {
    version = "3.9.5";
    src = super.fetchFromGitHub {
      owner = "plagman";
      repo = "gamescope";
      rev = "refs/tags/3.9.5";
      hash = "sha256-1cJ9xP74cq8rP218JDbEhp8sjso8dpxGKaZYOknk9pI=";
    };

    patches = [];

    mesonFlags = [];

    nativeBuildInputs = [
      super.meson
      super.pkg-config
      super.ninja
      super.makeBinaryWrapper
      super.cmake
    ];

    buildInputs = [
      oldDeps.libliftoff

      oldDeps.xorg.libXdamage
      oldDeps.xorg.libXcomposite
      oldDeps.xorg.libXrender
      oldDeps.xorg.libXext
      oldDeps.xorg.libXxf86vm
      oldDeps.xorg.libXtst
      oldDeps.xorg.libXres
      oldDeps.libdrm

      oldDeps.vulkan-loader
      oldDeps.SDL2
      oldDeps.wayland
      oldDeps.wayland-protocols
      oldDeps.wlroots
      oldDeps.xwayland
      oldDeps.seatd
      oldDeps.libinput
      oldDeps.libxkbcommon
      oldDeps.udev
      oldDeps.pixman
      oldDeps.libcap
      super.pipewire
      super.wlroots
      super.stb
    ];
  });
}
