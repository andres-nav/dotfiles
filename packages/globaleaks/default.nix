{
  lib,
  fetchFromGitHub,
  fetchPypi,
  python3,
  buildNpmPackage,
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

  pname = "globaleaks";
  version = "4.13.0";

  src = fetchFromGitHub {
    owner = pname;
    repo = "GlobaLeaks";
    rev = "v${version}";
    hash = "sha256-+eYD+nPqmAxGCaQUNewMzmSX0lw4OivIv1PSnHvZUxQ=";
  };

  meta = with lib; {
    description = "";
    license = licenses.agpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [andresnav];
  };

  clientPackage = buildNpmPackage {
    pname = "${pname}-client";
    inherit version src meta;

    sourceRoot = "${src.name}/client";

    postPatch = ''
      # substituteInPlace npm-shrinkwrap.json \
      # --replace '"stylelint": "15.10.3",' '"stylelint": "15.10.2",'

      cp npm-shrinkwrap.json package-lock.json
    '';

    npmDepsHash = "sha256-n9Hcr3IeVOA3hAb2ZygVRTR8pJ3CliRjMTnw+PlweV4=";
    # npmFlags = ["--legacy-peer-deps" "--ignore-scripts"];

    # makeCacheWritable = true;
    # dontNpmInstall = true;
    # dontNpmBuild = true;
  };
in
  python.pkgs.buildPythonApplication rec {
    inherit pname version src meta;

    # outputs = [
    #   "out"
    #   "client"
    # ];

    sourceRoot = "${src.name}/backend";

    # nativeBuildInputs = [
    #   nodejs
    # ];

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
      clientPackage
    ];

    postInstall = ''
      find $out -name "__pycache__" -type d | xargs rm -rv

      # mkdir -p $client

      # cp -r $src/client $out/lib/python3.10 # FIXME: don't use python3.10 directory hardcoded

      # cp -r $src/client/* $client
      # cd $client && npm install -d && ./node_modules/grunt/bin/grunt build
    '';
  }
