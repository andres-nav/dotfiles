{
  stdenv,
  python3,
  fetchurl,
  fetchPypi,
  autoPatchelfHook,
  dpkg,
  makeWrapper,
}: let
  mypython = python3.override {
    packageOverrides = self: super: {
      sqlalchemy = super.sqlalchemy.overridePythonAttrs (old: rec {
        version = "1.4.46";
        src = fetchPypi {
          pname = "SQLAlchemy";
          inherit version;
          hash = "sha256-aRO4JH2KKS74MVFipRkx4rQM6RaB8bbxj2lwRSAMSjA=";
        };
        disabledTestPaths = [
          "test/aaa_profiling"
          "test/ext/mypy"
        ];
      });
    };
  };
in
  stdenv.mkDerivation rec {
    pname = "globaleaks";
    version = "4.12.9";

    src = fetchurl {
      url = "https://deb.globaleaks.org/bookworm/globaleaks_${version}_all.deb";
      sha256 = "sha256-anjxasu6gFN+skcTU5ZEPZH2ngowdzKAxqTuSOxr2rg=";
    };

    nativeBuildInputs = [autoPatchelfHook dpkg makeWrapper];

    buildInputs = [
      (mypython.withPackages (ps:
        with ps; [
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
        ]))
    ];

    unpackPhase = "true";

    installPhase = ''
      mkdir -p $out/bin
      dpkg -x $src $out

      cat > $out/bin/globaleaks <<EOF
      if [ ! -d "/tmp/globaleaks" ]; then
        cp -r $out/usr/share/globaleaks /tmp
        chmod +w /tmp/globaleaks
      fi

      PYTHONPATH="$out/usr/lib/python3/dist-packages" $out/usr/bin/globaleaks --working-path=/tmp/globaleaks -n --ip=http://localhost
      EOF

      chmod +x $out/bin/globaleaks
    '';
  }
