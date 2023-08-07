{ config, options, lib, pkgs, ... }:
with lib;
with lib.my;
let cfg = config.modules.dev.r;
in {
  options.modules.dev.r = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [ R rPackages.languageserver ];
  };
}
