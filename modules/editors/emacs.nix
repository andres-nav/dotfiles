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

      emacsPackages.compat
      emacsPackages.gcmh
      emacsPackages.super-save

      emacsPackages.magit
      emacsPackages.forge

      emacsPackages.format-all


      # Grammar checker
      emacsPackages.jinx
      nuspell # for language checker jinx
      hunspellDicts.en_US # install hunspell dicts
      hunspellDicts.es_ES
      emacsPackages.flycheck-grammarly

      # NixOS
      emacsPackages.direnv
      emacsPackages.consult
      emacsPackages.diminish

      # Theme
      emacsPackages.doom-themes
      emacsPackages.doom-modeline

      # Org
      emacsPackages.org-modern
      emacsPackages.org-roam
      emacsPackages.org-ql

      # Evil
      emacsPackages.evil
      emacsPackages.evil-collection
      emacsPackages.evil-leader
      emacsPackages.evil-multiedit
      emacsPackages.evil-surround
      emacsPackages.evil-commentary
      emacsPackages.evil-lion
      emacsPackages.evil-matchit
      emacsPackages.evil-org

      emacsPackages.undo-fu
      emacsPackages.undo-fu-session

      emacsPackages.flycheck

      emacsPackages.ace-window

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
