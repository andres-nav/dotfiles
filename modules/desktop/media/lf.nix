# modules/desktop/media/lf.nix

{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.media.lf;
    configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.media.lf = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      lf
    ];

    home.configFile = {
      "lf".source = "${configDir}/lf";
    };

  };
}
