{
  lib,
  stdenv,
  src,
}:

stdenv.mkDerivation {
  pname = "sfm";
  version = "unstable";
  inherit src;
 
  installFlags = [ "PREFIX=$(out)" ];

  preBuild = ''
    make clean
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 sfm "$out/bin/sfm"
    runHook postInstall
  ''; 
}
