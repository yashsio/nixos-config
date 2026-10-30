{ ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        # font = "sans-serif:weight=bold:size=14";
        # font = "JetBrainsMono Nerd Font:weight=bold:size=14";
        font = "Iosevka Nerd Font:weight=bold:size=14";
        line-height = 25;
        fields = "name,generic,comment,categories,filename,keywords";
        terminal = "footclient";
        prompt = "' ➜  '" ;
        icon-theme = "Gruvbox-Plus-Dark";
        layer = "top";
        lines = 10;
        width = 35;
        horizontal-pad = 25;
        inner-pad = 5;
      };
      colors = {
        background = "282828f2";
        text = "d4be98ff";
        prompt = "d8a657ff";
        input = "d4be98ff";
        placeholder = "928374ff";
        match = "a9b665ff";
        selection = "3c3836ff";
        selection-text = "d4be98ff";
        selection-match = "89b482ff";
        counter = "a89984ff";
        border = "a9b665ff";
      };
      border = {
        radius = 0;
        width = 1;
      };
    };
  };
}

