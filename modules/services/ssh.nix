{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.services.ssh;
in {
  options.modules.services.ssh = {
    enable = mkBoolOpt false;
    addSSHKey = mkBoolOpt false;
    sshPath = mkPathOpt "./";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      startWhenNeeded = true;

      settings = {
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };

      hostKeys = mkIf cfg.addSSHKey [
        {
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };

    sops = mkIf cfg.addSSHKey {
      age.sshKeyPaths = map (x: x.path) config.services.openssh.hostKeys;
      secrets = {
        "ssh/key".sopsFile = cfg.sshPath;
      };
    };

    user.openssh.authorizedKeys.keys =
      if config.user.name == "god"
      then ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICDJYyEWnTfyMPn0iWhTOVKyGoY2DI6/dTynXZBGhlDp god@zeus"]
      else [];
  };
}
