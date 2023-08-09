# Poseidon: my main server
{...}: {
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
      minecraft-server.enable = true;
    };
  };

  services.logind.lidSwitch = "ignore";
}
