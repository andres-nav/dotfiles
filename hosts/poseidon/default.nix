# Poseidon: my main server
{ ... }:
{
  imports = [
    ../home.nix
    ./hardware-configuration.nix
  ];

  ## Modules
  modules = {
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
      zerotier = {
        enable = true;
        joinNetworks = [ "1d71939404843223" ];
      };
    };
  };

  services.k3s = {
    enable = true;
    role = "server";
    token = "test";
  };

  services.logind.lidSwitch = "ignore";
}
