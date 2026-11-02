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

    plutowm = {
      url = "path:/home/yashs/pluto";
      flake = false;
    };

    pluto-bar = {
      url = "path:/home/yashs/pluto-bar";
      flake = false;
    };

    sfm = {
      url = "path:/home/yashs/sfm";
      flake = false;
    };

  };

  outputs = { nixpkgs, ... }@inputs: let
    overlays = [
      inputs.nur.overlays.default
      (final: prev: {
        plutowm = final.callPackage ./pkgs/plutowm.nix {
          src = inputs.plutowm;
        };
      })
      (final: prev: {
        pluto-bar = final.callPackage ./pkgs/pluto-bar.nix {
          src = inputs.pluto-bar;
        };
      })
      (final: prev: {
        sfm = final.callPackage ./pkgs/sfm.nix {
          src = inputs.sfm;
        };
      })
    ];

    mkSystem = import ./lib/mksystem.nix {
      inherit overlays nixpkgs inputs;
    };
  in {
    # NixOS host.
    nixosConfigurations.tuf-laptop-amd = mkSystem "tuf-laptop-amd" {
      system = "x86_64-linux";
      user   = "yashs";
    };

    # NixOS VM.
    nixosConfigurations.vm-x64-kvm = mkSystem "vm-x64-kvm" {
      system = "x86_64-linux";
      user   = "yashs";
    };
  };
}
