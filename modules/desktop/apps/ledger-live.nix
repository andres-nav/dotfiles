{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.apps.ledger-live;
in {
  options.modules.desktop.apps.ledger-live = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    users.groups.plugdev = {};
    user.extraGroups = ["plugdev"];

    user.packages = with pkgs; [
      ledger-live-desktop
    ];

    hardware.ledger.enable = true;
  };
}
