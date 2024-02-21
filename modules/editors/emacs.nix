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
      # Doom Emacs dependencies
      binutils
      ripgrep
      gnutls
      fd
      imagemagick
      zstd
      # nodePackages.javascript-typescript-langserver
      sqlite
      editorconfig-core-c
      emacs-all-the-icons-fonts

      # Github Copilot
      nodejs
    ];

    services.emacs = {
      enable = true;
      defaultEditor = true;
    };

    environment.shellAliases = {
      e = "emacsclient -n -r";
      E = "emacsclient -nw";
    };

    home.configFile = {
      "doom" = {
        source = "${configDir}/doom";
        recursive = true;
        onChange = "${pkgs.writeShellScript "doom-change" ''
          #!/bin/sh
          DOOM="$XDG_CONFIG_HOME/emacs"

          if [ ! -f "$DOOM/bin/doom" ]; then
            rm -rf $DOOM # Remove old Emacs config
          	git clone --depth 1 https://github.com/doomemacs/doomemacs $DOOM
          	$DOOM/bin/doom -y install
          fi

          $DOOM/bin/doom sync
        ''}";
      };

      # "emacs" = {
      #   source = "${configDir}/emacs";
      # };
    };
  };
}
