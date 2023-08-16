{
  fetchFromGitHub,
  python3Packages,
}: let
  pname = "globaleaks";
  version = "4.12.6";

  repo = fetchFromGitHub {
    owner = pname;
    repo = "GlobaLeaks";
    rev = "v${version}";
    hash = "sha256-DwVZ7ssDmguyTadXoTxmZypdf1kWL0Gb4kVBeW9yTC0=";
  };
in
  python3Packages.buildPythonPackage {
    inherit pname version;

    src = "${repo}";

    propagatedBuildInputs = with python3Packages; [
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

    postUnpack = ''
      echo hello
      echo $out
      cat > $out/setup.py <<EOF
      from setuptools import setup, find_packages

      setup(
        name="foo",
        version="1.0",
        packages=find_packages('./backend'),
      )
      EOF
    '';
  }
