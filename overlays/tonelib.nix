# Leaving this only as example for future use

self: super:

{
  tonelib-gfx = super.tonelib-gfx.overrideAttrs (old: rec {
    version = "4.7.8";

    src = super.fetchurl {
      url = "https://tonelib.net/download/221222/ToneLib-GFX-amd64.deb";
      hash = "sha256-1sTwHqQYqNloZ3XSwhryqlW7b1FHh4ymtj3rKUcVZIo=";
    };
  });

  tonelib-metal = super.tonelib-metal.overrideAttrs (old: rec {
    version = "1.2.6";

    src = super.fetchurl {
      url = "https://tonelib.net/download/221222/ToneLib-Metal-amd64.deb";
      hash = "sha256-G80EKAsXomdk8GsnNyvjN8shz3YMKhqdWWYyVB7xTsU=";
    };
  });
}
