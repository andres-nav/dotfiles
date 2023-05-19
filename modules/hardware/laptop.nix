# modules/hardware/laptop.nix --- support for laptops

{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.laptop;
in {
  options.modules.hardware.laptop = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.xserver.libinput = {
      enable = true; # trackpad
      touchpad.disableWhileTyping = true;
    };

    services.tlp.enable = lib.mkDefault ((lib.versionOlder (lib.versions.majorMinor lib.version) "21.05")
                                       || !config.services.power-profiles-daemon.enable); # tlp

    services.fwupd.enable = true;

    services.thermald.enable = true;

    hardware.enableRedistributableFirmware = lib.mkDefault true; # add firmware such has wifi

    environment.systemPackages = with pkgs; [
      brightnessctl 
    ]; 
  };
}
