{ lib, pkgs, ... }: {
  imports = [
    ./../../modules/darwin
    ./../../home/znavandr
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    betterdisplay
    aerospace

    librewolf
    obsidian
    ghostty-bin
    insomnia

    slack
    zoom-us
    spotify

    zsh
    zsh-autocomplete
    zsh-autosuggestions
    zsh-history-substring-search
    git
    direnv

    colima
    docker
  ];
}
