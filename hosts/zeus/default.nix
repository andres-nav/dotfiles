{ lib, pkgs, ... }: {
  imports = [
    ./../../modules/darwin
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

    tmux
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
