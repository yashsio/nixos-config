{ stdenv, wayland, wayland-scanner, wayland-protocols, libxkbcommon, pkg-config }:

stdenv.mkDerivation rec {
  pname = "plutowm";
  version = "0.1";

  src = ./.;

  nativeBuildInputs = [ wayland-scanner pkg-config ];
  buildInputs = [ wayland wayland-protocols libxkbcommon ];

  preBuild = ''
    make clean
  '';

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp pluto $out/bin/
    chmod +x $out/bin/pluto
  '';
}  
