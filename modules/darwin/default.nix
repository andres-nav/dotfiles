{ lib, config, ...}: {
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix = {
    # WARN: Don't enable the nix process when using determinate's nix installer
    enable = lib.mkForce false;
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = config.rev or config.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  security.pam.services.sudo_local.touchIdAuth = true;
}
