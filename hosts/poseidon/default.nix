# Poseidon: my main server
{...}: {
  imports = [
    ../home.nix
    ./hardware-configuration.nix
  ];

  ## Modules
  modules = {
    dev = {
      #python.enable = true;
    };
    editors = {
      default = "neovim";
      nvim.enable = true;
    };
    shell = {
      direnv.enable = true;
      git.enable = true;
      gnupg.enable = true;
      tmux.enable = true;
      fish.enable = true;
    };
    services = {
      ssh.enable = true;
    };

    theme.active = "alucard";
  };

  ## Local config
  #programs.gnupg.agent.enableSSHSupport = true;

  # nix.gc.automatic = true;
}
