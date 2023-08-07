{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.services.zerotier;
in {
  options.modules.services.zerotier = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.zerotierone = {
      enable = true;
      joinNetworks = ["1d71939404843223" "a0cbf4b62ac2045f"];
    };
  };
}
