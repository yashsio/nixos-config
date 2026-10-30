{ pkgs, ... }:

{
  gtk = {
    enable = true;
    colorScheme = "dark";

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
 
    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons.override {
        folder-color = "highland";
      };
    }; 
  };  
}
