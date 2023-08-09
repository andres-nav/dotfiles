{pkgs}:
pkgs.stdenv.mkDerivation rec {
  pname = "globaleaks";
  version = "4.12.9";

  src = pkgs.fetchurl {
    url = "https://deb.globaleaks.org/bookworm/globaleaks_${version}_all.deb";
    sha256 = "sha256-anjxasu6gFN+skcTU5ZEPZH2ngowdzKAxqTuSOxr2rg=";
  };

  nativeBuildInputs = with pkgs; [autoPatchelfHook dpkg makeWrapper];

  buildInputs = with pkgs; [
    (python3.withPackages (ps:
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
      ]))
  ];

  unpackPhase = "true";

  installPhase = ''
    mkdir -p $out/bin
    dpkg -x $src $out
    cp -r $out/usr/share/globaleaks/* $out/usr/lib/

    cat > $out/bin/globaleaks <<EOF
    PYTHONPATH="$out/usr/lib/python3/dist-packages" $out/usr/bin/globaleaks
    EOF

    chmod +x $out/bin/globaleaks
  '';
}
