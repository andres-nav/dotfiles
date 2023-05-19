{ config, options, pkgs, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.megacmd;
in {
  options.modules.services.megacmd = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      megacmd
    ];
  };
}
