# Zeus: my main laptop
{...}: {
  imports = [
    ../home.nix
    ./hardware-configuration.nix
  ];

  ## Modules
  modules = {
    desktop = {
      i3.enable = true;
      apps = {
        dbeaver.enable = true;
        ledger-live.enable = true;
        minecraft.enable = true;
        rofi.enable = true;
        freecad.enable = true;
        prusaslicer.enable = true;
      };
      browsers = {
        default = "firefox";
        chromium.enable = true;
        firefox.enable = true;
      };
      media = {
        #graphics.enable = true;
        discord.enable = true;
        documents.enable = true;
        latex.enable = true;
        lf.enable = true;
        ranger.enable = true;
        spotify.enable = true;
        teams.enable = true;
        zoom.enable = true;
      };
      term = {
        default = "alacritty";
        alacritty.enable = true;
      };
      vm = {
        virtualbox.enable = true;
      };
    };
    dev = {
      node.enable = true;
      python.enable = true;
      solidity.enable = true;
    };
    editors = {
      default = "emacsclient -n";
      emacs.enable = true;
      nvim.enable = true;
    };
    shell = {
      cachix.enable = true;
      direnv.enable = true;
      git.enable = true;
      gnupg.enable = true;
      mob.enable = true;
      starship.enable = true;
      tmux.enable = true;
      fish.enable = true;
    };
    services = {
      ssh.enable = true;
      zerotier.enable = true;
      mega.enable = true;
      docker.enable = true;
    };

    theme.active = "alucard";
  };

  ## Local config
  #programs.gnupg.agent.enableSSHSupport = true;
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  # nix.gc.automatic = true;
}
