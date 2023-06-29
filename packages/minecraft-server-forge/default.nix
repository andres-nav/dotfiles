{
  lib,
  stdenv,
  jre_headless,
}:
stdenv.mkDerivation rec {
  pname = "minecraft-server-forge";
  version = "1.12.2";

  src = "./${version}";

  preferLocalBuild = true;

  installPhase = ''
    mkdir -p $out/bin $out/lib/minecraft
    cp -v $src/* $out/lib/minecraft/*

    cat > $out/bin/minecraft-server << EOF
    #!/bin/sh
    exec ${jre_headless}/bin/java \$@ -jar $out/lib/minecraft/server.jar nogui
    EOF

    chmod +x $out/bin/minecraft-server
  '';

  dontUnpack = true;

  meta = with lib; {
    description = "Minecraft Server Forge";
    homepage = "https://minecraft.net";
    sourceProvenance = with sourceTypes; [binaryBytecode];
    license = licenses.unfreeRedistributable;
    platforms = platforms.unix;
    maintainers = with maintainers; [andresnav];
  };
}
