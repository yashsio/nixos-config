{ ... }: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    sandbox = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}  
