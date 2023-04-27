# Aijiro -- a portable mini-ITX desktop

{ ... }:
{
  imports = [
    ../home.nix
    ./hardware-configuration.nix
  ];

  ## Modules
  modules = {
    desktop = {
      bspwm.enable = true;
      apps = {
        rofi.enable = true;
      };
      browsers = {
        default = "brave";
        brave.enable = true;
      };
      media = {
        documents.enable = true;
        #graphics.enable = true;
        spotify.enable = true;
      };
      term = {
        default = "xst";
        st.enable = true;
      };
      vm = {
        virtualbox.enable = true;
      };
    };
    dev = {
      #python.enable = true;
    };
    editors = {
      default = "nvim";
      emacs.enable = true;
      vim.enable = true;
    };
    shell = {
      direnv.enable = true;
      git.enable    = true;
      gnupg.enable  = true;
      tmux.enable   = true;
      #zsh.enable    = true;
    };
    services = {
      ssh.enable = true;
      docker.enable = true;
    };
    theme.active = "alucard";
  };


  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.wireless = {
    enable = true;
    networks = {
      "Salon-5G".pskRaw = "73a2d68efe1e1ec55a89c88280b6b01a1edb9e18095629d491082bfeed35a095";
    };
  };

  time.timeZone = "Europe/Madrid";
}
