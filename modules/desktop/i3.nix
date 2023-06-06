{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.i3;
  configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.i3 = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lightdm
    ];

    services = {
      redshift.enable = true;
      xserver = {
        enable = true;
        displayManager = {
          defaultSession = "none+i3";
          lightdm.enable = true;
          lightdm.greeters.mini.enable = true;
        };
        windowManager.i3 = {
          enable = true;
          extraPackages = with pkgs; [
            i3status
            xss-lock
            i3blocks
          ];
        };
      };
    };

    programs.i3lock = {
      enable = true;
      package = pkgs.i3lock-fancy-rapid;
    };

    home.configFile = {
      "i3".source = "${configDir}/i3";
      "i3blocks".source = "${configDir}/i3blocks";
    };
  };
}
