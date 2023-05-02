{ config, lib, pkgs, inputs, modulesPath, ... }:

{
  imports = [
#    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc"];
    initrd.kernelModules = [ "dm-snapshot" ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    # Refuse ICMP echo requests on my desktop/laptop; nobody has any business
    # pinging them, unlike my servers.
    kernel.sysctl."net.ipv4.icmp_echo_ignore_broadcasts" = 1;

    initrd.luks.devices."nixenc".device = "/dev/disk/by-partlabel/primary";
  };

  # Modules
  modules.hardware = {
    audio.enable = true;

    fs = {
      enable = true;
      ssd.enable = true;
    };

    nvidia.enable = true;

    laptop.enable = true;

    wifi.enable = true;

  };

  # CPU
  nix.settings.max-jobs = lib.mkDefault 4;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  powerManagement.cpuFreqGovernor = "powersave";

  hardware.enableRedistributableFirmware = lib.mkDefault true; # for wifi

  # Storage
  fileSystems = {
    "/" = { 
      device = "/dev/mapper/vg-root";
      fsType = "btrfs";
      options = [ "subvol=root" "compress-force=zstd" "noatime" ];
    };

    "/home" = { 
      device = "/dev/mapper/vg-root";
      fsType = "btrfs";
      options = [ "subvol=home" "compress-force=zstd" "noatime" ];
    };

    "/nix" = {
      device = "/dev/mapper/vg-root";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress-force=zstd" "noatime" ];
    };

    "/persist" = {
      device = "/dev/mapper/vg-root";
      fsType = "btrfs";
      options = [ "subvol=persist" "compress-force=zstd" "noatime" ];
    };

    "/var/log" = {
      device = "/dev/mapper/vg-root";
      fsType = "btrfs";
      options = [ "subvol=log" "compress-force=zstd" "noatime" ];
    };

    "/boot" = { 
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };
  };

  swapDevices = [ { device = "/dev/mapper/vg-swap"; }];
}
