{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.shell.fish;
  configDir = config.dotfiles.configDir;
in {
  options.modules.shell.fish = with types; {
    enable = mkBoolOpt false;
  };

  # TODO: make fish default shell in home.nix
  config = mkIf cfg.enable {
    users.defaultUserShell = pkgs.fish;

    programs.fish = {
      enable = true;
      useBabelfish = true;
    };

    environment.systemPackages = with pkgs; [
      fd
      fzf
      fishPlugins.fzf-fish

      jq # TODO: change to somewhere general
      ripgrep

      bat
      eza

      zip
      unzip

      grc
      fishPlugins.grc

      fishPlugins.colored-man-pages
    ];

    environment.shellAliases = {
      cat = "bat";
      ls = "eza -l";
    };

    home.configFile = {
      "fish" = {source = "${configDir}/fish";};
    };

    environment.sessionVariables = {
      FZF_DEFAULT_COMMAND = "fd";
    };

    # system.userActivationScripts.cleanupZgen = ''
    #   rm -rf $ZSH_CACHE
    #   rm -fv $ZGEN_DIR/init.zsh{,.zwc}
    # '';
  };
}
