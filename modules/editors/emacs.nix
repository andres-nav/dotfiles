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

      # Grammar checker
      emacsPackages.jinx
      nuspell # for language checker jinx
      hunspellDicts.en_US # install hunspell dicts
      hunspellDicts.es_ES

      # NixOS
      emacsPackages.direnv
      emacsPackages.consult

      # Github Copilot
      emacsPackages.editorconfig
      nodejs
    ];

    services.emacs = {
      enable = true;
      package = pkgs.emacs29;
      defaultEditor = true;
    };

    environment.shellAliases = {
      e = "emacsclient -n -r";
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
