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
      emacs

      emacsPackages.vterm
      emacsPackages.sqlite3

      emacsPackages.org-roam
      sqlite

      nil
      alejandra
    ];

    services.emacs.enable = true;

    environment.shellAliases = {};

    home.configFile = {
      "emacs" = {
        source = "${configDir}/emacs";
        recursive = true;
      };
    };
  };
}
