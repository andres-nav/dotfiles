{ pkgs, ... }: {
  users.users.znavandr.home = "/Users/znavandr";

  home-manager.users.znavandr = {
    # programs.tmux = {
    #   enable = true;
    # };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    home.packages = with pkgs; [
      fd
      (ripgrep.override {withPCRE2 = true;})

      # Font / icon config
      emacs-all-the-icons-fonts
      fontconfig

      nixfmt # :lang nix
    ];

    fonts.fontconfig.enable = true;

    programs.emacs = {
      enable = true;
      package = pkgs.emacs-macport;
    };

    xdg.configFile."doom" = {
      source = ./../doom;
      recursive = true;
      onChange = "${pkgs.writeShellScript "doom-change" ''
        #!/usr/bin/env sh
        EMACS="$HOME/.config/emacs"
        if [ ! -f $EMACS/bin/doom ]; then
          rm -rf $EMACS # Remove old Emacs config
          ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs "$EMACS"
          $EMACS/bin/doom -y install
        fi
      ''}";
    };

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "25.05";
  
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
