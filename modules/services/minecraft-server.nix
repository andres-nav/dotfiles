{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.services.minecraft-server;
in {
  options.modules.services.minecraft-server = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      zulu
    ];

    networking.firewall.allowedTCPPorts = [25565];

    systemd.user.services.minecraft = {
      wantedBy = ["default.target"];
      after = ["network.target"];
      description = "Start MC Server";
      serviceConfig = {
        ExecStart = ''${pkgs.zulu}/bin/java -Xmx6G -Xms4G -jar /home/god/mc/forge-1.16.5-36.2.39.jar nogui'';
        Restart = "always";
        RestartSec = 1;
        WorkingDirectory = "/home/god/mc";
      };
    };
  };
}
