# When I'm stuck in the terminal or don't have access to Emacs, (neo)vim is my
# go-to. I am a vimmer at heart, after all.

{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors.emacs;
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

      nil
      nixpkgs-fmt
    ];
    
    services.emacs.enable = true;

    environment.shellAliases = {
    };

    home.configFile = {
      "emacs" = { source = "${configDir}/emacs"; recursive = true; };
    };
  };
}
