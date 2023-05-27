# Zeus: my main laptop 

{ ... }:
{
  imports = [
    ../home.nix
    ./hardware-configuration.nix
  ];

  ## Modules
  modules = {
    desktop = {
      i3.enable = true;
      apps = {
        rofi.enable = true;
      };
      browsers = {
        default = "brave";
        brave.enable = true;
      };
      media = {
        documents.enable = true;
        lf.enable = true;
        #graphics.enable = true;
        spotify.enable = true;
      };
      term = {
        default = "alacritty";
        #st.enable = true;
        alacritty.enable = true;
      };
      vm = {
        #virtualbox.enable = true;
      };
    };
    dev = {
      #python.enable = true;
    };
    editors = {
      default = "emacs";
      emacs.enable = true;
      nvim.enable = true;
    };
    shell = {
      direnv.enable = true;
      git.enable    = true;
      gnupg.enable  = true;
      tmux.enable   = true;
      fish.enable    = true;
    };
    services = {
      ssh.enable = true;
      mega.enable = true;
      #docker.enable = true;
    };
    theme.active = "alucard";
  };


  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;
}
