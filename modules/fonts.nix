{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = false;

    packages = with pkgs; [
      nerd-fonts.iosevka
    ];
   
    fontconfig.defaultFonts = {
      monospace = [ "Iosevka Nerd Font" ];
      sansSerif = [ "Iosevka Nerd Font" ];
      serif     = [ "Iosevka Nerd Font" ];
    };
  };     
}

