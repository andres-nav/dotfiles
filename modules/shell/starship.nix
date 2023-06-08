{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.shell.starship;
  configDir = config.dotfiles.configDir;
  starshipDir = "${configDir}/starship";
in {
  options.modules.shell.starship = with types; {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
    };

    environment.variables.STARSHIP_CONFIG = starshipDir;

    home.configFile = {
      "starship" = {source = starshipDir;};
    };

    # system.userActivationScripts.cleanupZgen = ''
    #   rm -rf $ZSH_CACHE
    #   rm -fv $ZGEN_DIR/init.zsh{,.zwc}
    # '';
  };
}
