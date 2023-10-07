# Zeus: my main laptop
{...}: {
  imports = [../home.nix ./hardware-configuration.nix];

  ## Modules
  modules = {
    desktop = {
      i3.enable = true;
      apps = {
        dbeaver.enable = true;
        insomnia.enable = true;
        ledger-live.enable = true;
        rofi.enable = true;
        freecad.enable = true;
        prusaslicer.enable = true;
        kicad.enable = true;
        notion.enable = true;
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
        skype.enable = true;
        zoom.enable = true;
      };
      term = {
        default = "alacritty";
        alacritty.enable = true;
      };
      vm = {qemu.enable = true;};
    };
    dev = {
      node.enable = true;
      python.enable = true;
      solidity.enable = true;
      cc.enable = true;
      nix.enable = true;
      r.enable = true;
    };
    editors = {
      default = "emacsclient -nw";
      emacs.enable = true;
      nvim.enable = true;
      vscodium.enable = true;
    };
    shell = {
      cachix.enable = true;
      direnv.enable = true;
      git.enable = true;
      gnupg.enable = true;
      mob.enable = true;
      starship.enable = true;
      nom.enable = true;
      tmux.enable = true;
      fish.enable = true;
    };
    services = {
      mega.enable = true;
      docker.enable = true;
      zerotier = {
        enable = true;
        joinNetworks = ["1d71939404843223" "a0cbf4b62ac2045f"];
      };
    };

    theme.active = "alucard";
  };

  ## Local config

  # programs.ssh.startAgent = true;
  # services.openssh.startWhenNeeded = true;

  # nix.gc.automatic = true;
}
