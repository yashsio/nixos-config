{ stdenv, src, wayland, wayland-scanner, wayland-protocols, libxkbcommon, pkg-config }:

stdenv.mkDerivation rec {
  pname = "plutowm";
  version = "0.1";
  inherit src;

  nativeBuildInputs = [
    wayland-scanner
    pkg-config
  ];

  buildInputs = [
    wayland
    wayland-protocols
    libxkbcommon
  ];

  preBuild = ''
    make clean
  ''; 

  installPhase = ''
    runHook preInstall
    install -Dm755 pluto "$out/bin/pluto"
    runHook postInstall
  '';
}  
