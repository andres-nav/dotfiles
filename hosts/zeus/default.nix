{ lib, pkgs, ... }: {
  imports = [
    ./../../modules/darwin
  ];

  nixpkgs.config.allowUnfree = true; 

  environment.systemPackages = with pkgs; [
     librewolf
     obsidian
     ghostty-bin
  ];
}
