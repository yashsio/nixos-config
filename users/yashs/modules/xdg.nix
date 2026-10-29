{ ... }:

{
  xdg.enable = true;

  xdg.desktopEntries.neovim = {
    name = "Neovim";
    genericName = "Text Editor";
    comment = "Edit files";
    exec = "footclient nvim %F";
    terminal = false;
    type = "Application"; 
    icon = "nvim";
    categories = [ "Development" "TextEditor" ];
    mimeType = [
      "text/plain"
      "text/x-c"
      "text/x-c++"
      "text/x-python"
    ];
  }; 

  xdg.configFile = {
    "hypr".source = ../hypr;
    "nvim".source = ../nvim;
  };
} 

