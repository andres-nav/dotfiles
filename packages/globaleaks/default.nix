{
  lib,
  fetchFromGitHub,
  fetchPypi,
  python3,
  nodejs,
}: let
  python = python3.override {
    packageOverrides = self: super: {
      sqlalchemy = super.sqlalchemy.overridePythonAttrs rec {
        version = "1.4.46";
        src = fetchPypi {
          pname = "SQLAlchemy";
          inherit version;
          hash = "sha256-aRO4JH2KKS74MVFipRkx4rQM6RaB8bbxj2lwRSAMSjA=";
        };
      };
    };
  };
in
  python.pkgs.buildPythonPackage rec {
    pname = "globaleaks";
    version = "4.12.6";

    src = fetchFromGitHub {
      owner = pname;
      repo = "GlobaLeaks";
      rev = "v${version}";
      hash = "sha256-DwVZ7ssDmguyTadXoTxmZypdf1kWL0Gb4kVBeW9yTC0=";
    };

    sourceRoot = "${src.name}/backend";

    nativeBuildInputs = [
      nodejs
    ];

    propagatedBuildInputs = with python.pkgs; [
      twisted
      h2
      priority
      sqlalchemy
      pyotp
      cryptography
      pynacl
      acme
      python-gnupg
      service-identity
      debian
      txtorcon
    ];

    doCheck = false;

    installPhase = ''
      cp -r $src/client $out/lib/python3.10 # FIXME: don't use python3.10 directory hardcoded

      cd $out/lib/python3.10/client && npm install -d && ./node_modules/grunt/bin/grunt build
    '';

    meta = with lib; {
      description = "";
      license = licenses.gpl3;
      platforms = platforms.linux;
      maintainers = with maintainers; [];
    };
  }
