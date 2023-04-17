{ pkgs, stdenv, writeShellScriptBin }:

let
  pname = "activity-aware";

  firefoxDesktopItem = pkgs.makeDesktopItem {
    name = "${pname}-firefox";
    desktopName = "Activity Aware Firefox";
    type = "Application";
    categories = [ "Network" "WebBrowser" ];
    exec = "${pname}-firefox %u";
    icon = "firefox";
    mimeTypes = [
      "text/html"
      "application/xml"
      "application/xhtml+xml"
      "application/vnd.mozilla.xul+xml"
    ];
    startupWMClass = "firefox";
    startupNotify = true;
  };

  firefox = writeShellScriptBin "${pname}-firefox" ''
    ACTIVITY_ID=$(\
      ${pkgs.qt5.qttools.bin}/bin/qdbus \
      org.kde.ActivityManager \
      /ActivityManager/Activities \
      CurrentActivity \
    )

    ACTIVITY_NAME=$(\
      ${pkgs.qt5.qttools.bin}/bin/qdbus org.kde.ActivityManager \
      /ActivityManager/Activities \
      ActivityName $ACTIVITY_ID \
    )

    ${pkgs.firefox}/bin/firefox -p "$ACTIVITY_NAME" "$@"
  '';

in pkgs.symlinkJoin rec {
  name = pname;
  paths = [ firefox firefoxDesktopItem ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = "wrapProgram $out/bin/${pname}-firefox --prefix PATH : $out/bin";
}
