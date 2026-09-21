# This function creates a NixOS system based on config.
{ nixpkgs, nixpkgs-unstable, overlays, inputs }:

name:
{
  system,
  user
}:

let
  # The config files for this system.
  machineConfig = ../machines/${name}.nix;
  userHMConfig = ../users/${user}/home-manager.nix;

  pkgsUnstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
in nixpkgs.lib.nixosSystem {
  inherit system;

  modules = [
    # Apply overlays.
    { nixpkgs.overlays = overlays; }

    # Allow unfree packages.
    { nixpkgs.config.allowUnfree = true; }

    machineConfig
    inputs.home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "backup";

      home-manager.extraSpecialArgs = {
        inherit inputs pkgsUnstable;
      };

      home-manager.users.${user} = import userHMConfig {
        inputs = inputs;
      };
    }
 
    {
      config._module.args = {
        currentSystem = system;
        currentSystemName = name;
        currentSystemUser = user;
        inputs = inputs;
      };
    }
  ];
}
