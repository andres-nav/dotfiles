# modules/hardware/laptop.nix --- support for laptops
{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.hardware.laptop;
in {
  options.modules.hardware.laptop = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.xserver.libinput = {
      enable = true; # trackpad
      touchpad.disableWhileTyping = true;
    };

    services.tlp.enable = true;

    services.fwupd.enable = true;

    services.acpid.enable = true;

    hardware.enableRedistributableFirmware = lib.mkDefault true; # add firmware such has wifi

    environment.systemPackages = with pkgs; [
      acpi
      brightnessctl
      # TODO: hardware.acpilight.enable
    ];
  };
}
