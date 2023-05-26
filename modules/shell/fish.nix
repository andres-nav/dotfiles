{ config, options, pkgs, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.fish;
    configDir = config.dotfiles.configDir;
in {
  options.modules.shell.fish = with types; {
    enable = mkBoolOpt false;

  };

  config = mkIf cfg.enable {
    users.defaultUserShell = pkgs.fish;

    programs.fish = {
      enable = true;
    };

    user.packages = with pkgs; [
      fd
      fzf
      jq
      ripgrep
    ];

    home.configFile = {
      "fish" = { source = "${configDir}/fish";};
    };

   # system.userActivationScripts.cleanupZgen = ''
   #   rm -rf $ZSH_CACHE
   #   rm -fv $ZGEN_DIR/init.zsh{,.zwc}
   # '';
  };
}
