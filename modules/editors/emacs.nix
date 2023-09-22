{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.editors.emacs;
  configDir = config.dotfiles.configDir;
in {
  options.modules.editors.emacs = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gnuplot
    ];

    services.emacs = {
      enable = true;
      package = pkgs.emacs29;
      defaultEditor = true;
    };

    environment.shellAliases = {
      e = "emacsclient";
      E = "emacsclient -nw";
    };

    home.configFile = {
      "emacs" = {
        source = "${configDir}/emacs";
        recursive = true;
      };
    };
  };
}
