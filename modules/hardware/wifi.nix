{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.hardware.wifi;
in {
  options.modules.hardware.wifi = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;
  };
}
