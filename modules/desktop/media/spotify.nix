# I use spotify for my music needs. Gone are the days where I'd manage 200gb+ of
# local music; most of which I haven't heard or don't even like.
{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.media.spotify;
in {
  options.modules.desktop.media.spotify = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      spotifywm
      playerctl

      (makeDesktopItem {
        name = "spotify";
        desktopName = "Spotify";
        icon = "spotify";
        exec = ''spotifywm'';
        categories = ["Music"];
      })
    ];
  };
}
