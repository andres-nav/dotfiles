# Apolo: Hostinger
{
  inputs,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    ../home.nix
    ./hardware-configuration.nix

    # (modulesPath + "/profiles/minimal.nix")
    # (modulesPath + "/profiles/headless.nix")
    # (modulesPath + "/profiles/hardened.nix") # TODO: check if it is really needed
    # (modulesPath + "/installer/scan/not-detected.nix") # TODO: check if it is really needed
  ];

  # boot.loader.grub = {
  #   devices = ["/dev/sda"];
  #   efiSupport = true;
  #   efiInstallAsRemovable = true;
  # };

  zramSwap.enable = true;

  ## Modules
  modules = {
    editors = {
      default = "neovim";
      nvim.enable = true;
    };
    shell = {
      git.enable = true;
      fish.enable = true;
    };
    services = {
      ssh.enable = true;
      zerotier = {
        enable = true;
        joinNetworks = ["1d71939404843223"];
      };

      globaleaks.enable = true;
    };
  };
}
