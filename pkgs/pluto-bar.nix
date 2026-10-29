{ stdenv, src, wayland, wayland-scanner, wayland-protocols, cairo, pango, wlr-protocols, fontconfig, pkg-config }:

stdenv.mkDerivation {
  pname = "pluto-bar";
  version = "0.1";
  inherit src;

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

  makeFlags = [
    "WLR_PROTOCOLS=${wlr-protocols}/share/wlr-protocols"
    "WAYLAND_PROTOCOLS=${wayland-protocols}/share/wayland-protocols"
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

