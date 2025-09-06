{
  description = "andres-nav dotfiles flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#zeus
    darwinConfigurations."7cf34de936f3" = nix-darwin.lib.darwinSystem {
      modules = [ 
	configuration
	./hosts/zeus
      ];
    };
  };
}
