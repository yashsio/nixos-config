{ config, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = import ./shell-aliases.nix { inherit config; };
    interactiveShellInit = ''
      if status is-interactive
      end
    '';
    functions = {
      fish_greeting = {
        body = '' 
        '';
      };
      hl = {
        body = ''
          start-hyprland $argv
        '';
      }; 
    }; 
  };  
}
