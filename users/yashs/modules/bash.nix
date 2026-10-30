{ config,... }:

{
  programs.bash = {
    enable = true;
    shellOptions = [];
    historyControl = [ "ignoredups" "ignorespace" ];
    shellAliases = import ./shell-aliases.nix { inherit config; };
  };
}
