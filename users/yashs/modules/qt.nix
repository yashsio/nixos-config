{ ... }:

{
  qt = {
    enable = true;
    platformTheme.name = "qtct";

    qt5ctSettings = {
      Appearance.icon_theme = "Gruvbox-Plus-Dark";
    };

    qt6ctSettings = {
      Appearance.icon_theme = "Gruvbox-Plus-Dark";
    };
  };  
}
