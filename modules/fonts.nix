{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = false;

    packages = [ pkgs.nerd-fonts.dejavu-sans-mono ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "DejaVu Sans Mono" ];
        sansSerif = [ "DejaVu Sans" ];
        serif = [ "DejaVu Serif" ];
        emoji = [ "DejaVu Sans" ];
      };
    };
  };
}

