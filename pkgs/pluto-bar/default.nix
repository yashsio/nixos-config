{ stdenv, wayland, wayland-scanner, wayland-protocols, cairo, pango, wlr-protocols, fontconfig, pkg-config }:

stdenv.mkDerivation rec {
  pname = "pluto-bar";
  version = "0.1";

  src = ./.;

  nativeBuildInputs = [ wayland-scanner pkg-config ];
  buildInputs = [ wayland wayland-protocols wlr-protocols cairo pango fontconfig ];

  # makeFlags = [
  #   "WLR_PROTOCOLS=${wlr-protocols}/share/wlr-protocols"
  #   "WAYLAND_PROTOCOLS=${wayland-protocols}/share/wayland-protocols"
  # ];

  preBuild = ''
    make clean
  '';

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp pluto-bar $out/bin/
    chmod +x $out/bin/pluto-bar
  '';
}   
