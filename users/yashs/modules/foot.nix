{ ... }:

{
  programs.foot = {
    enable = true;

    settings = {
      main = {
        # font = "DejaVuSansMono:size=14";
        # font-bold = "DejaVuSansMono:weight=bold:size=14";
        # font-italic = "DejaVuSansMono:slant=italic:size=14";
        # font-bold-italic = "DejaVuSansMono:weight=bold:slant=italic:size=14";

        # font = "JetBrainsMono Nerd Font:size=14";
        # font-bold = "JetBrainsMono Nerd Font:weight=bold:size=14";
        # font-italic = "JetBrainsMono Nerd Font:slant=italic:size=14";
        # font-bold-italic = "JetBrainsMono Nerd Font:weight=bold:slant=italic:size=14";

        font = "Iosevka Nerd Font:size=17";
        font-bold = "Iosevka Nerd Font:weight=bold:size=17";
        font-italic = "Iosevka Nerd Font:slant=italic:size=17";
        font-bold-italic = "Iosevka Nerd Font:weight=bold:slant=italic:size=17";

        pad = "15x15 center";
      };

      cursor = {
        style = "beam";
        blink = "yes";
      };

      colors-dark = {
        alpha = "0.9";
        foreground = "d4be98";
        background = "1d2021";

        regular0 = "32302f";
        regular1 = "ea6962";
        regular2 = "a9b665";
        regular3 = "d8a657";
        regular4 = "7daea3";
        regular5 = "d3869b";
        regular6 = "89b482";
        regular7 = "d4be98";

        bright0 = "7c6f64";
        bright1 = "ea6962";
        bright2 = "a9b665";
        bright3 = "d8a657";
        bright4 = "7daea3";
        bright5 = "d3869b";
        bright6 = "89b482";
        bright7 = "d4be98";
      };
    };
  };
}

