{
  lib,
  stdenv,
  src,
}:

stdenv.mkDerivation rec {
  pname = "sfm";
  version = "unstable";
  inherit src;
 
  installFlags = [ "PREFIX=$(out)" ];

  preBuild = ''
    make clean
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 pluto "$out/bin/sfm"
    runHook postInstall
  ''; 
}
