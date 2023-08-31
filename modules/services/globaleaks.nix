# modules/services/globaleaks.nix
#
# For keeping an eye on things...
{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.services.globaleaks;
in {
  options.modules.services.globaleaks = with types; {
    enable = mkBoolOpt false;

    package = mkOption {
      type = types.package;
      description = lib.mdDoc ''
        Globaleaks package to use.
      '';
      default = pkgs.my.globaleaks;
    };

    user = mkOption {
      type = str;
      description = "Username of the system user that should own files and services related to globaleaks.";
      default = "globaleaks";
    };

    group = mkOption {
      type = str;
      description = "Group that contains the system user that executes globaleaks.";
      default = "globaleaks";
    };

    workingPath = mkOption {
      type = path;
      description = "Path for the backend working directory.";
      default = "/var/lib/globaleaks";
    };
  };

  config = mkIf cfg.enable {
    users.users."${cfg.user}" = {
      isNormalUser = true;
      createHome = true;
      home = cfg.workingPath;
      group = cfg.group;
    };

    users.groups."${cfg.group}" = {};

    systemd.services.globaleaks = {
      wantedBy = ["multi-user.target"];
      after = ["network.target"];
      wants = ["network-online.target"];

      description = "Start GlobaLeaks service.";
      path = [cfg.package]; # add package to the PATH

      serviceConfig = {
        User = cfg.user;
        Group = cfg.group;
        ExecStart = ''
          ${pkgs.my.globaleaks}/bin/globaleaks --working-path=${cfg.workingPath}
        '';
        Type = "forking";
        PIDFile = "${cfg.workingPath}/globaleaks.pid";
        Restart = "always";
        RestartSec = 5;
        WorkingDirectory = cfg.workingPath;
      };
    };
  };
}
