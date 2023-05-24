{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.i3;
    configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.i3 = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    # modules.theme.onReload.bspwm = ''
    #   ${pkgs.bspwm}/bin/bspc wm -r
    #   source $XDG_CONFIG_HOME/bspwm/bspwmrc
    # '';

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
	  # extraSessionCommands = ''
          #   megasync
	  # '';
        };
      };
    };

    home.configFile = {
      "i3".source = "${configDir}/i3";
    };
  };
}
