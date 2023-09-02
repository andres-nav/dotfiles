{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.apps.minecraft;
in {
  options.modules.desktop.apps.minecraft = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      minecraft
      zulu
    ];
  };
}
