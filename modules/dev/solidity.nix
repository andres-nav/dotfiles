# modules/dev/shell.nix --- http://zsh.sourceforge.net/
#
# Shell script programmers are strange beasts. Writing programs in a language
# that wasn't intended as a programming language. Alas, it is not for us mere
# mortals to question the will of the ancient ones. If they want shell programs,
# they get shell programs.
{
  config,
  options,
  lib,
  pkgs,
  my,
  ...
}:
with lib;
with lib.my; let
  devCfg = config.modules.dev;
  cfg = devCfg.solidity;
in {
  options.modules.dev.solidity = {
    enable = mkBoolOpt false;
    xdg.enable = mkBoolOpt devCfg.xdg.enable;
  };

  config = mkMerge [
    (mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        solc
      ];
    })

    (mkIf cfg.xdg.enable {
      })
  ];
}
