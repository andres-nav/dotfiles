{ config, lib, ... }:

with builtins;
with lib;
let #blocklist = fetchurl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts;
in {
  #networking.extraHosts = ''

    # Block garbage
   # ${optionalString config.services.xserver.enable (readFile blocklist)}
  #'';

  time.timeZone = mkDefault "Europe/Madrid";
  location = {
    latitude = 55.88;
    longitude = 12.5;
  };


  # Keyboard default
  i18n.defaultLocale = mkDefault "en_US.UTF-8";
  console = {
    keyMap = mkDefault "us";
    useXkbConfig = mkDefault true;
  };

  services.xserver = {
    layout = mkDefault "us";
    xkbOptions = "caps:swapescape,ctrl:swap_lalt_lctl";
  };
}
