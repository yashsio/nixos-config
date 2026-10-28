{ stdenv, wayland, wayland-scanner, wayland-protocols, cairo, pango, wlr-protocols, fontconfig, pkg-config }:

stdenv.mkDerivation {
  pname = "pluto-bar";
  version = "0.1";
  src = /home/yashs/pluto-bar;

  nativeBuildInputs = [ 
    wayland-scanner
    pkg-config
  ];

  buildInputs = [
    wayland
    wayland-protocols
    wlr-protocols
    cairo
    pango
    fontconfig
  ];

  preBuild = ''
    make clean
  ''; 

  installPhase = ''
    runHook preInstall
    install -Dm755 pluto-status -t "$out/bin"
    install -Dm755 pluto-bar -t "$out/bin"
    runHook postInstall
  '';

}

