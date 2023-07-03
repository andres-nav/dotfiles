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
      jdk17_headless
    ];

    networking.firewall.allowedTCPPorts = [25565];

    systemd.user.services.minecraft = {
      wantedBy = ["default.target"];
      after = ["network.target"];
      description = "Start MC Server";
      serviceConfig = {
        ExecStart = ''/home/god/mc/run.sh'';
        Restart = "always";
        RestartSec = 1;
        WorkingDirectory = "/home/god/mc";
      };
    };
  };
}
