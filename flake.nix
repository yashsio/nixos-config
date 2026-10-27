{
  description = "NixOS system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = { 
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };  

  };

  outputs = { nixpkgs, ... }@inputs: let
    overlays = [
      inputs.nur.overlays.default
      (final: prev: {
        plutowm = final.callPackage ./pkgs/pluto { };
      })
      (final: prev: {
        pluto-bar = final.callPackage ./pkgs/pluto-bar { };
      })
    ];

    mkSystem = import ./lib/mksystem.nix {
      inherit overlays nixpkgs inputs;
    };
  in {
    # NixOS host.
    nixosConfigurations.host = mkSystem "host" {
      system = "x86_64-linux";
      user   = "yashs";
    };

    # NixOS VM.
    nixosConfigurations.vm = mkSystem "vm" {
      system = "x86_64-linux";
      user   = "yashs";
    };
  };
}
