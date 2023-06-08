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
  ];

  boot = {
    initrd.availableKernelModules = ["ehci_pci" "ahci" "usb_storage" "xhci_pci" "sd_mod"];
    initrd.kernelModules = ["dm-snapshot"];
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];

    # Refuse ICMP echo requests on my desktop/laptop; nobody has any business
    # pinging them, unlike my servers.
    kernel.sysctl."net.ipv4.icmp_echo_ignore_broadcasts" = 1;
  };

  # Modules
  modules.hardware = {
    fs = {
      enable = true;
      ssd.enable = true;
    };

    laptop.enable = true;

    wifi.enable = true;
  };

  # CPU
  nix.settings.max-jobs = lib.mkDefault 4;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.enableRedistributableFirmware = lib.mkDefault true; # for wifi

  # Storage
  fileSystems = {
    "/" = {
      device = "/dev/mapper/vg-root";
      fsType = "btrfs";
      options = ["subvol=root" "compress-force=zstd"];
    };

    "/home" = {
      device = "/dev/mapper/vg-root";
      fsType = "btrfs";
      options = ["subvol=home" "compress-force=zstd"];
    };

    "/nix" = {
      device = "/dev/mapper/vg-root";
      fsType = "btrfs";
      options = ["subvol=nix" "compress-force=zstd" "noatime"];
    };

    "/persist" = {
      device = "/dev/mapper/vg-root";
      fsType = "btrfs";
      options = ["subvol=persist" "compress-force=zstd"];
    };

    "/var/log" = {
      device = "/dev/mapper/vg-root";
      fsType = "btrfs";
      options = ["subvol=log" "compress-force=zstd"];
    };

    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };
  };

  swapDevices = [{device = "/dev/mapper/vg-swap";}];
}