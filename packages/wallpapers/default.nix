{ lib
, builtins
, stdenv   
}:
let
  system = "x86_64-linux";
in {
  defaultPackage.${system} = 
  stdenv.mkDerivation rec {
    pname = "wallpapers";
    version = "1.0";
  
    
    src = builtins.fetchGit {
      url = "https://github.com/andres-nav/wallpapers.git";
      ref = "master";
    };
  
  }
}
