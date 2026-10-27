{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.hack
  ];
}  
