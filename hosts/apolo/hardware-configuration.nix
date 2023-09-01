{
  config,
  lib,
  pkgs,
  inputs,
  modulesPath,
  ...
}: {
  imports = [
    #    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot = {
    loader = {
      systemd-boot.enable = false;
      grub.device = "/dev/vda";
    };
    initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "xen_blkfront" "vmw_pvscsi"];
    initrd.kernelModules = ["nvme"];
  };

  # Storage
  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };
}
