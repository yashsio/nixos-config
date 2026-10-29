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
      nixos-check = {
        body = ''
          nix flake check "$HOME/nixos-config" --all-systems --no-build; or return 1

          nix eval --raw \
            "$HOME/nixos-config#nixosConfigurations.host.config.system.build.toplevel.drvPath" \
            >/dev/null; or return 1

          nix eval --raw \
            "$HOME/nixos-config#nixosConfigurations.vm.config.system.build.toplevel.drvPath" \
            >/dev/null; or return 1

          echo "NixOS configurations are valid."
        ''; 
      };
    }; 
  };  
}
