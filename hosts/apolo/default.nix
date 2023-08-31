# Apolo: Hostinger
{
  inputs,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    ../home.nix

    inputs.disko.nixosModules.disko # TODO: if used for other hosts, add it to general ./home.nix

    (modulesPath + "/profiles/minimal.nix")
    (modulesPath + "/profiles/headless.nix")
    # (modulesPath + "/profiles/hardened.nix") # TODO: check if it is really needed
    # (modulesPath + "/installer/scan/not-detected.nix") # TODO: check if it is really needed

    (modulesPath + "/profiles/qemu-guest.nix") # FIXME: only for testing in the vm
  ];

  ## Disko module
  disko.devices = import ./disk-config.nix {
    inherit lib;
  };

  ## Modules
  modules = {
    editors = {
      default = "neovim";
      nvim.enable = true;
    };
    shell = {
      direnv.enable = true;
      git.enable = true;
      tmux.enable = true;
      fish.enable = true;
    };
    services = {
      ssh.enable = true;
      docker.enable = true;
      zerotier = {
        enable = true;
        joinNetworks = ["1d71939404843223"];
      };

      globaleaks.enable = true;
    };
  };
}
